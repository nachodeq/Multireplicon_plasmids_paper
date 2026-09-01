#!/usr/bin/env python3
from __future__ import annotations

from collections import defaultdict
import argparse
from pathlib import Path

import numpy as np
import pandas as pd
from ete3 import NCBITaxa

TABLES: Path
LOGS: Path

TAX_LEVELS = ["genus", "family", "order", "class", "phylum"]
BAD_HOST_TERMS = ("uncultured", "bacterium", "metagenome", "environmental")


def split_replicons(value: object) -> list[str]:
    if pd.isna(value):
        return []
    return [x.strip() for x in str(value).split(",") if x.strip()]


def unique_preserve_order(values: list[str]) -> list[str]:
    seen = set()
    out = []
    for value in values:
        if value not in seen:
            seen.add(value)
            out.append(value)
    return out


def status_from_replicons(reps: list[str]) -> str:
    n_unique = len(set(reps))
    if n_unique == 0:
        return "no detectable replicon"
    if n_unique == 1:
        return "single-replicon"
    return "multi-replicon"


class Taxonomy:
    def __init__(self) -> None:
        self.ncbi = NCBITaxa()
        self.cache: dict[str, dict[str, str] | None] = {}

    def get(self, name: object) -> dict[str, str] | None:
        if pd.isna(name):
            return None
        key = str(name).strip()
        if not key:
            return None
        if key in self.cache:
            return self.cache[key]
        try:
            translated = self.ncbi.get_name_translator([key])
            if key not in translated:
                self.cache[key] = None
                return None
            taxid = translated[key][0]
            lineage = self.ncbi.get_lineage(taxid)
            ranks = self.ncbi.get_rank(lineage)
            names = self.ncbi.get_taxid_translator(lineage)
            tax = {}
            for t in lineage:
                rank = ranks.get(t)
                if rank in TAX_LEVELS:
                    tax[rank] = names[t]
            self.cache[key] = tax
            return tax
        except Exception:
            self.cache[key] = None
            return None


def minimum_jump(base_taxa: list[dict[str, str]], new_tax: dict[str, str]) -> str | None:
    order = {"genus": 0, "family": 1, "order": 2, "class": 3, "phylum": 4}
    candidates = []
    for base_tax in base_taxa:
        if base_tax.get("family") and new_tax.get("family") and base_tax["family"] == new_tax["family"]:
            candidates.append("genus")
        elif base_tax.get("order") and new_tax.get("order") and base_tax["order"] == new_tax["order"]:
            candidates.append("family")
        elif base_tax.get("class") and new_tax.get("class") and base_tax["class"] == new_tax["class"]:
            candidates.append("order")
        elif base_tax.get("phylum") and new_tax.get("phylum") and base_tax["phylum"] == new_tax["phylum"]:
            candidates.append("class")
        elif new_tax.get("phylum"):
            candidates.append("phylum")
    if not candidates:
        return None
    return min(candidates, key=lambda x: order[x])


def jump_between_families(taxonomy: Taxonomy, baseline_family: str, new_family: str) -> str | None:
    base_tax = taxonomy.get(baseline_family)
    new_tax = taxonomy.get(new_family)
    if not base_tax or not new_tax:
        return None
    return minimum_jump([base_tax], new_tax)


def main() -> None:
    global TABLES, LOGS
    parser = argparse.ArgumentParser(description="Build observed host-range extension tables from the complete PLSDB data.")
    parser.add_argument("--typing", required=True)
    parser.add_argument("--genus", required=True)
    parser.add_argument("--descriptions", required=True)
    parser.add_argument("--outdir", required=True)
    args = parser.parse_args()
    TABLES = Path(args.outdir)
    LOGS = TABLES
    TABLES.mkdir(parents=True, exist_ok=True)
    typing = pd.read_csv(args.typing, low_memory=False)
    genus = pd.read_csv(args.genus, low_memory=False)
    desc = pd.read_csv(args.descriptions, low_memory=False)

    df = typing.merge(genus, on="NUCCORE_ACC", how="left").merge(desc, on="NUCCORE_ACC", how="left")
    df["replicon_list_raw"] = df["rep_type(s)"].apply(split_replicons)
    df["replicon_list"] = df["replicon_list_raw"].apply(unique_preserve_order)
    df["n_replicon_hits"] = df["replicon_list_raw"].map(len)
    df["n_unique_replicons"] = df["replicon_list"].map(len)
    df["replicon_status"] = df["replicon_list"].map(status_from_replicons)
    df["host_genus"] = df["Genus"].astype("string").str.strip()
    bad_regex = "|".join(BAD_HOST_TERMS)
    df["informative_host_genus"] = df["host_genus"].notna() & ~df["host_genus"].str.lower().str.contains(bad_regex, na=False)

    denominators = pd.DataFrame(
        [
            ("all_mobtyper_rows", len(df)),
            ("unique_plasmids", df["NUCCORE_ACC"].nunique()),
            ("no_detectable_replicon", int((df["replicon_status"] == "no detectable replicon").sum())),
            ("single_replicon_unique", int((df["replicon_status"] == "single-replicon").sum())),
            ("multi_replicon_unique", int((df["replicon_status"] == "multi-replicon").sum())),
            ("with_informative_host_genus", int(df["informative_host_genus"].sum())),
            ("with_predicted_host_range_rank", int(df["predicted_host_range_overall_rank"].notna().sum())),
            ("with_mobility_prediction", int(df["predicted_mobility"].notna().sum())),
        ],
        columns=["metric", "value"],
    )
    denominators.to_csv(TABLES / "all_plasmids_denominators.tsv", sep="\t", index=False)

    rep_count_dist = (
        df["n_unique_replicons"]
        .value_counts()
        .sort_index()
        .rename_axis("n_unique_replicons")
        .reset_index(name="n_plasmids")
    )
    rep_count_dist["percent"] = 100 * rep_count_dist["n_plasmids"] / len(df)
    rep_count_dist.to_csv(TABLES / "all_plasmids_replicon_count_distribution.tsv", sep="\t", index=False)

    mobility_by_status = (
        df.groupby(["replicon_status", "predicted_mobility"], dropna=False)["NUCCORE_ACC"]
        .nunique()
        .reset_index(name="n_plasmids")
    )
    mobility_by_status.to_csv(TABLES / "all_plasmids_mobility_by_replicon_status.tsv", sep="\t", index=False)

    hostrank_by_status = (
        df.groupby(["replicon_status", "predicted_host_range_overall_rank"], dropna=False)["NUCCORE_ACC"]
        .nunique()
        .reset_index(name="n_plasmids")
    )
    hostrank_by_status.to_csv(TABLES / "all_plasmids_mobtyper_hostrange_rank_by_replicon_status.tsv", sep="\t", index=False)

    work = df[df["informative_host_genus"]].copy()
    taxonomy = Taxonomy()
    unique_genera = sorted(work["host_genus"].dropna().unique())
    tax_rows = []
    for g in unique_genera:
        tax = taxonomy.get(g)
        if tax:
            tax_rows.append({"host_genus": g, **tax, "taxonomy_status": "ok"})
        else:
            tax_rows.append({"host_genus": g, "taxonomy_status": "unresolved"})
    tax_table = pd.DataFrame(tax_rows)
    tax_table.to_csv(TABLES / "all_plasmids_host_genus_taxonomy.tsv", sep="\t", index=False)
    tax_dict = {
        row["host_genus"]: {k: row.get(k) for k in TAX_LEVELS if pd.notna(row.get(k))}
        for _, row in tax_table.iterrows()
        if row.get("taxonomy_status") == "ok"
    }

    rep_rows = []
    for row in work.itertuples(index=False):
        for rep in row.replicon_list:
            rep_rows.append(
                {
                    "NUCCORE_ACC": row.NUCCORE_ACC,
                    "replicon": rep,
                    "replicon_status": row.replicon_status,
                    "host_genus": row.host_genus,
                }
            )
    rep_df = pd.DataFrame(rep_rows)

    single = rep_df[rep_df["replicon_status"] == "single-replicon"].copy()
    multi = work[work["replicon_status"] == "multi-replicon"].copy()

    baseline_genera = single.groupby("replicon")["host_genus"].apply(lambda x: set(x.dropna())).to_dict()
    baseline_taxa: dict[str, list[dict[str, str]]] = {}
    baseline_families: dict[str, set[str]] = defaultdict(set)
    for rep, genera_set in baseline_genera.items():
        taxa = []
        for g in genera_set:
            tax = tax_dict.get(g)
            if not tax:
                continue
            taxa.append(tax)
            if tax.get("family"):
                baseline_families[rep].add(tax["family"])
        if taxa:
            baseline_taxa[rep] = taxa

    event_rows = []
    for row in multi.itertuples(index=False):
        host = row.host_genus
        new_tax = tax_dict.get(host)
        if not new_tax:
            continue
        reps = row.replicon_list
        for rep in reps:
            base_genera = baseline_genera.get(rep, set())
            base_taxa = baseline_taxa.get(rep, [])
            if not base_genera or not base_taxa:
                continue
            if host in base_genera:
                continue
            jump = minimum_jump(base_taxa, new_tax)
            if not jump:
                continue
            co_reps = [x for x in reps if x != rep]
            event_rows.append(
                {
                    "plasmid": row.NUCCORE_ACC,
                    "replicon": rep,
                    "cointegrated_replicons": ";".join(co_reps),
                    "new_genus": host,
                    "new_family": new_tax.get("family"),
                    "taxonomic_jump": jump,
                    "baseline_genera": ";".join(sorted(base_genera)),
                    "baseline_families": ";".join(sorted(baseline_families.get(rep, set()))),
                }
            )

    events_raw = pd.DataFrame(event_rows)
    events_raw.to_csv(TABLES / "all_plasmids_host_range_jump_events_raw.tsv", sep="\t", index=False)

    if events_raw.empty:
        raise SystemExit("No host-range jump events detected")

    events_min = events_raw.drop_duplicates(["replicon", "new_genus"]).copy()
    events_min.to_csv(TABLES / "all_plasmids_host_range_jump_events_minimum.tsv", sep="\t", index=False)

    min_summary = (
        events_min.groupby("taxonomic_jump")
        .size()
        .reindex(TAX_LEVELS, fill_value=0)
        .rename_axis("taxonomic_jump")
        .reset_index(name="n_events")
    )
    min_summary.to_csv(TABLES / "all_plasmids_taxonomic_jump_counts_minimum.tsv", sep="\t", index=False)

    # Expand each minimum event over all baseline families and classify each
    # baseline/new-family pair.
    expanded_rows = []
    for row in events_min.itertuples(index=False):
        base_fams = [x for x in str(row.baseline_families).split(";") if x]
        for base_family in base_fams:
            jump = jump_between_families(taxonomy, base_family, row.new_family)
            if not jump:
                continue
            expanded_rows.append(
                {
                    "replicon": row.replicon,
                    "baseline_family": base_family,
                    "new_family": row.new_family,
                    "new_genus": row.new_genus,
                    "taxonomic_jump": jump,
                    "cointegrating_replicons": row.cointegrated_replicons,
                }
            )
    expanded_df = pd.DataFrame(expanded_rows).drop_duplicates()
    expanded_df.to_csv(TABLES / "all_plasmids_host_range_jump_events_baseline_family_expanded.tsv", sep="\t", index=False)
    expanded_summary = (
        expanded_df.groupby("taxonomic_jump")
        .size()
        .reindex(TAX_LEVELS, fill_value=0)
        .rename_axis("taxonomic_jump")
        .reset_index(name="n_events")
    )
    expanded_summary.to_csv(TABLES / "all_plasmids_taxonomic_jump_counts_baseline_family_expanded.tsv", sep="\t", index=False)

    top_reps = (
        events_min.groupby(["replicon", "taxonomic_jump"])
        .size()
        .reset_index(name="n_new_genera")
        .sort_values(["n_new_genera", "replicon"], ascending=[False, True])
    )
    top_reps.to_csv(TABLES / "all_plasmids_jump_counts_by_replicon_minimum.tsv", sep="\t", index=False)

    with open(LOGS / "run_summary.txt", "w") as out:
        out.write("All-plasmids Fig. 2d host-range jump rebuild\n")
        out.write(f"input_typing_rows\t{len(typing)}\n")
        out.write(f"merged_rows\t{len(df)}\n")
        out.write(f"events_raw_plasmid_replicon\t{len(events_raw)}\n")
        out.write(f"events_minimum_replicon_new_genus\t{len(events_min)}\n")
        out.write(f"events_baseline_family_expanded\t{len(expanded_df)}\n")
        out.write("\nMinimum summary:\n")
        out.write(min_summary.to_string(index=False))
        out.write("\n\nBaseline-family expanded summary:\n")
        out.write(expanded_summary.to_string(index=False))
        out.write("\n")


if __name__ == "__main__":
    main()
