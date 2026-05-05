#!/usr/bin/env python3
"""
Section 2 analysis for Figure 2.

Manuscript section:
"Multireplicon plasmids couple high mobility with expanded host ranges"

This script does NOT export final figures. It generates clean tables and
statistical summaries needed for:

Figure 2a:
- Predicted mobility distribution by replicon status.
- Global chi-square test.
- Category-specific Fisher exact tests.

Figure 2b:
- Predicted host-range distribution by replicon status.
- Category-specific Fisher exact tests with FDR correction.

Figure 2c/d:
- Moved to the dedicated R workflow:
  scripts/02_mobility_host_range/02_section2_hostrange_jumps_minimum_event.R
- This Python script now focuses on Figure 2a/2b and related summary tables.

Inputs:
- Supplementary_Dataset_1.xlsx with plasmid_id and n_replicons.
- typing table, ideally the deduplicated table used in the notebook:
    NUCCORE_ACC
    rep_type(s)
    predicted_mobility
    predicted_host_range_overall_rank
    Genus_from_description
  Replicon_Status is optional; if absent, status is reconstructed from Supplementary Dataset 1.
- optional taxonomy table:
    genus, family, order, class, phylum
  If absent, the script tries to use ete3.NCBITaxa.

No plotting is performed here.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path
from typing import Iterable

import numpy as np
import pandas as pd
from scipy.stats import chi2_contingency, fisher_exact
from statsmodels.stats.multitest import multipletests


TAX_ORDER = ["genus", "family", "order", "class", "phylum", "multi-phylla"]
JUMP_ORDER = ["family", "order", "class", "phylum", "unknown"]

BAD_HOST_PATTERNS = ["uncultured", "bacterium", "metagenome", "environmental"]


# ============================================================
# I/O AND NORMALIZATION
# ============================================================

def read_table(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    suffix = "".join(path.suffixes).lower()
    if suffix.endswith(".xlsx") or suffix.endswith(".xls"):
        return pd.read_excel(path)
    if suffix.endswith(".csv"):
        return pd.read_csv(path)
    return pd.read_csv(path, sep="\t")


def write_table(df: pd.DataFrame, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if df is None or df.empty:
        print(f"[skip] {path.name}: no data")
        return
    df.to_csv(path, sep="\t", index=False)
    print(f"[out] {path}")


def standardize_columns(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out.columns = out.columns.str.strip()
    return out


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower_map = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower_map:
            return lower_map[c.lower()]
    return None


def normalize_id(x: object) -> str:
    s = str(x).strip().split("/")[-1]
    for ext in (".fasta", ".fa", ".fna", ".faa", ".gb", ".gbk", ".csv", ".tsv", ".xlsx", ".gz"):
        if s.endswith(ext):
            s = s[: -len(ext)]
    return s


def normalize_status(x: object) -> str | float:
    s = str(x).strip().lower().replace("_", "-").replace(" ", "-")
    if s in {"single", "single-replicon", "single-rep"}:
        return "single-replicon"
    if s in {"multi", "multi-replicon", "multireplicon", "multi-rep"}:
        return "multi-replicon"
    return np.nan


def status_from_n_replicons(n: object) -> str | float:
    try:
        n = int(n)
    except Exception:
        return np.nan
    return "multi-replicon" if n >= 2 else "single-replicon"


def clean_genus(x: object) -> str | float:
    if pd.isna(x):
        return np.nan
    s = str(x).strip()
    if not s:
        return np.nan
    s = re.sub(r"\s*\([^)]*\)\s*$", "", s)
    g = s.split()[0].capitalize() if s.split() else ""
    if not g:
        return np.nan
    if any(p in g.lower() for p in BAD_HOST_PATTERNS):
        return np.nan
    return g


def parse_replicons(x: object) -> list[str]:
    if pd.isna(x):
        return []
    s = str(x).strip()
    if not s or s.lower() in {"nan", "none"}:
        return []
    return [r.strip() for r in s.split(",") if r.strip()]


def normalize_host_rank(x: object) -> str | float:
    if pd.isna(x):
        return np.nan
    s = str(x).strip().lower().replace("_", "-").replace(" ", "-")
    synonyms = {
        "multiphyla": "multi-phylla",
        "multi-phyla": "multi-phylla",
        "multi-phylum": "multi-phylla",
        "multiple-phyla": "multi-phylla",
    }
    s = synonyms.get(s, s)
    return s if s in TAX_ORDER else np.nan


# ============================================================
# LOADERS
# ============================================================

def load_supplementary_dataset(path: str | Path) -> pd.DataFrame:
    df = standardize_columns(read_table(path))

    required = {"plasmid_id", "n_replicons"}
    missing = required - set(df.columns)
    if missing:
        raise SystemExit(f"Supplementary Dataset 1 is missing columns: {sorted(missing)}")

    out = df.copy()
    out["plasmid_id"] = out["plasmid_id"].map(normalize_id)
    out["n_replicons"] = pd.to_numeric(out["n_replicons"], errors="coerce")
    out["Replicon_Status"] = out["n_replicons"].map(status_from_n_replicons)
    return out[["plasmid_id", "n_replicons", "Replicon_Status"]].drop_duplicates("plasmid_id")


def load_typing(path: str | Path, supp: pd.DataFrame) -> pd.DataFrame:
    df = standardize_columns(read_table(path))

    id_col = first_existing(df.columns, ["NUCCORE_ACC", "plasmid_id", "nuccore_acc", "accession", "acc", "id"])
    rep_col = first_existing(df.columns, ["rep_type(s)", "replicon_types", "rep_types", "replicons"])
    mobility_col = first_existing(df.columns, ["predicted_mobility", "mobility"])
    host_range_col = first_existing(df.columns, ["predicted_host_range_overall_rank", "host_range", "predicted_host_range"])
    genus_col = first_existing(df.columns, ["Genus_from_description", "host_genus", "genus", "GENUS"])
    status_col = first_existing(df.columns, ["Replicon_Status", "replicon_status", "rep_count_class"])

    if id_col is None:
        raise SystemExit("Typing table needs plasmid id column, e.g. NUCCORE_ACC.")
    if rep_col is None:
        raise SystemExit("Typing table needs replicon column, e.g. rep_type(s).")

    out = pd.DataFrame()
    out["plasmid_id"] = df[id_col].map(normalize_id)
    out["rep_type(s)"] = df[rep_col].astype(str)
    out["rep_list"] = out["rep_type(s)"].map(parse_replicons)

    if mobility_col is not None:
        out["predicted_mobility"] = df[mobility_col].astype(str).str.strip()
        out.loc[out["predicted_mobility"].isin(["", "nan", "None"]), "predicted_mobility"] = np.nan
    else:
        out["predicted_mobility"] = np.nan

    if host_range_col is not None:
        out["predicted_host_range_overall_rank"] = df[host_range_col].map(normalize_host_rank)
    else:
        out["predicted_host_range_overall_rank"] = np.nan

    if genus_col is not None:
        out["host_genus"] = df[genus_col].map(clean_genus)
    else:
        out["host_genus"] = np.nan

    if status_col is not None:
        out["Replicon_Status"] = df[status_col].map(normalize_status)
    else:
        out["Replicon_Status"] = np.nan

    # Prefer Supplementary Dataset 1 status because this is the deduplicated set used in the paper.
    out = out.merge(
        supp[["plasmid_id", "n_replicons", "Replicon_Status"]].rename(
            columns={"Replicon_Status": "Replicon_Status_from_supp"}
        ),
        on="plasmid_id",
        how="inner",
    )

    out["Replicon_Status"] = out["Replicon_Status_from_supp"].combine_first(out["Replicon_Status"])
    out = out.drop(columns=["Replicon_Status_from_supp"])

    out = out[out["Replicon_Status"].isin(["single-replicon", "multi-replicon"])].copy()
    return out.drop_duplicates("plasmid_id")


def load_taxonomy_table(path: str | Path) -> pd.DataFrame:
    tax = standardize_columns(read_table(path))
    genus_col = first_existing(tax.columns, ["genus", "Genus", "host_genus"])
    if genus_col is None:
        raise SystemExit("Taxonomy table needs a genus column.")

    out = tax.copy()
    out["genus"] = out[genus_col].map(clean_genus)

    for col in ["family", "order", "class", "phylum"]:
        src = first_existing(out.columns, [col, col.capitalize(), col.upper()])
        if src is None:
            out[col] = np.nan
        elif src != col:
            out[col] = out[src]

    return out[["genus", "family", "order", "class", "phylum"]].dropna(subset=["genus"]).drop_duplicates("genus")


def build_taxonomy_with_ete3(genera: list[str]) -> pd.DataFrame:
    try:
        from ete3 import NCBITaxa
    except Exception as e:
        print(f"[warn] ete3 is unavailable: {e}")
        return pd.DataFrame(columns=["genus", "family", "order", "class", "phylum"])

    ncbi = NCBITaxa()
    rows = []

    for genus in sorted(set(genera)):
        if pd.isna(genus):
            continue
        try:
            translated = ncbi.get_name_translator([genus])
            if genus not in translated:
                continue
            taxid = translated[genus][0]
            lineage = ncbi.get_lineage(taxid)
            ranks = ncbi.get_rank(lineage)
            names = ncbi.get_taxid_translator(lineage)

            row = {"genus": genus, "family": np.nan, "order": np.nan, "class": np.nan, "phylum": np.nan}
            for t in lineage:
                rank = ranks.get(t)
                if rank in {"family", "order", "class", "phylum"}:
                    row[rank] = names[t]
            rows.append(row)
        except Exception:
            continue

    return pd.DataFrame(rows).drop_duplicates("genus") if rows else pd.DataFrame(columns=["genus", "family", "order", "class", "phylum"])


# ============================================================
# FIGURE 2A: MOBILITY
# ============================================================

def mobility_distribution(df: pd.DataFrame) -> pd.DataFrame:
    sub = df.dropna(subset=["predicted_mobility"]).copy()

    out = (
        sub.groupby(["Replicon_Status", "predicted_mobility"])
        .size()
        .reset_index(name="n")
    )
    out["percent"] = out.groupby("Replicon_Status")["n"].transform(lambda x: 100 * x / x.sum())
    return out.sort_values(["Replicon_Status", "predicted_mobility"])


def mobility_chi_square(df: pd.DataFrame) -> pd.DataFrame:
    sub = df.dropna(subset=["predicted_mobility", "Replicon_Status"]).copy()
    ct = pd.crosstab(sub["predicted_mobility"], sub["Replicon_Status"])

    if ct.shape[0] < 2 or ct.shape[1] < 2:
        return pd.DataFrame()

    chi2, p_value, dof, _ = chi2_contingency(ct)

    return pd.DataFrame([{
        "test": "chi-square independence",
        "chi2": chi2,
        "dof": dof,
        "p_value": p_value,
    }])


def fisher_by_category(df: pd.DataFrame, category_col: str, output_category_name: str) -> pd.DataFrame:
    sub = df.dropna(subset=[category_col, "Replicon_Status"]).copy()
    rows = []

    for cat in sorted(sub[category_col].dropna().unique()):
        is_cat = sub[category_col] == cat

        multi_in = int(((sub["Replicon_Status"] == "multi-replicon") & is_cat).sum())
        multi_out = int(((sub["Replicon_Status"] == "multi-replicon") & ~is_cat).sum())
        single_in = int(((sub["Replicon_Status"] == "single-replicon") & is_cat).sum())
        single_out = int(((sub["Replicon_Status"] == "single-replicon") & ~is_cat).sum())

        # Orientation gives OR > 1 when category is enriched in multi-replicon plasmids.
        odds_ratio, p_value = fisher_exact(
            [[multi_in, multi_out], [single_in, single_out]],
            alternative="two-sided",
        )

        rows.append({
            output_category_name: cat,
            "multi_in": multi_in,
            "multi_out": multi_out,
            "single_in": single_in,
            "single_out": single_out,
            "odds_ratio_multi_vs_single": odds_ratio,
            "p_value": p_value,
        })

    out = pd.DataFrame(rows)
    if not out.empty:
        valid = out["p_value"].notna()
        out.loc[valid, "p_FDR"] = multipletests(out.loc[valid, "p_value"], method="fdr_bh")[1]
    return out


# ============================================================
# FIGURE 2B: PREDICTED HOST RANGE
# ============================================================

def predicted_host_range_distribution(df: pd.DataFrame) -> pd.DataFrame:
    sub = df.dropna(subset=["predicted_host_range_overall_rank"]).copy()
    sub["predicted_host_range_overall_rank"] = pd.Categorical(
        sub["predicted_host_range_overall_rank"],
        categories=TAX_ORDER,
        ordered=True,
    )

    out = (
        sub.groupby(["Replicon_Status", "predicted_host_range_overall_rank"], observed=False)
        .size()
        .reset_index(name="n")
    )
    out["percent"] = out.groupby("Replicon_Status")["n"].transform(lambda x: 100 * x / x.sum())
    return out.sort_values(["Replicon_Status", "predicted_host_range_overall_rank"])


def suppfig4_replicon_predicted_host_range(df: pd.DataFrame) -> pd.DataFrame:
    """
    Supplementary-style table from Hostrange.ipynb:
    per replicon and context, percentage of plasmids assigned to each predicted host-range rank.
    """
    rep_df = explode_replicons(df)
    rep_df = rep_df.dropna(subset=["predicted_host_range_overall_rank"]).copy()

    counts = (
        rep_df.groupby(["replicon", "Replicon_Status", "predicted_host_range_overall_rank"])["plasmid_id"]
        .nunique()
        .reset_index(name="n")
    )

    totals = (
        rep_df.groupby(["replicon", "Replicon_Status"])["plasmid_id"]
        .nunique()
        .reset_index(name="n_context")
    )

    out = counts.merge(totals, on=["replicon", "Replicon_Status"], how="left")
    out["percent"] = 100 * out["n"] / out["n_context"]
    return out.sort_values(["replicon", "Replicon_Status", "predicted_host_range_overall_rank"])


# ============================================================
# FIGURE 2C/D: OBSERVED HOST-RANGE EXPANSION
# ============================================================

def explode_replicons(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out = out[out["rep_list"].map(len) > 0].copy()
    out = out.explode("rep_list").rename(columns={"rep_list": "replicon"})
    out["replicon"] = out["replicon"].astype(str).str.strip()
    out = out[out["replicon"] != ""].copy()
    return out


def taxonomic_jump_between(tax_a: dict, tax_b: dict) -> str:
    """
    Minimum taxonomic level separating two genera.
    Same family -> family-level expansion
    Same order but different family -> family
    Same class but different order -> order
    Same phylum but different class -> class
    Different phylum -> phylum
    """
    if not tax_a or not tax_b:
        return "unknown"

    if pd.notna(tax_a.get("family")) and tax_a.get("family") == tax_b.get("family"):
        return "family"
    if pd.notna(tax_a.get("order")) and tax_a.get("order") == tax_b.get("order"):
        return "family"
    if pd.notna(tax_a.get("class")) and tax_a.get("class") == tax_b.get("class"):
        return "order"
    if pd.notna(tax_a.get("phylum")) and tax_a.get("phylum") == tax_b.get("phylum"):
        return "class"
    return "phylum"


def minimum_taxonomic_jump(new_genus: str, baseline_genera: set[str], taxonomy: dict[str, dict]) -> str:
    new_tax = taxonomy.get(new_genus, {})
    jumps = []

    rank_score = {"family": 1, "order": 2, "class": 3, "phylum": 4, "unknown": 99}

    for base_genus in baseline_genera:
        base_tax = taxonomy.get(base_genus, {})
        jumps.append(taxonomic_jump_between(base_tax, new_tax))

    if not jumps:
        return "unknown"

    return sorted(jumps, key=lambda x: rank_score.get(x, 99))[0]


def observed_expansion_events(df: pd.DataFrame, taxonomy_df: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    rep_df = explode_replicons(df.dropna(subset=["host_genus"]).copy())

    single_hosts = (
        rep_df[rep_df["Replicon_Status"] == "single-replicon"]
        .groupby("replicon")["host_genus"]
        .apply(lambda x: set(x.dropna()))
    )

    multi_hosts = (
        rep_df[rep_df["Replicon_Status"] == "multi-replicon"]
        .groupby("replicon")["host_genus"]
        .apply(lambda x: set(x.dropna()))
    )

    taxonomy = taxonomy_df.set_index("genus")[["family", "order", "class", "phylum"]].to_dict("index")

    multi_plasmids = df[df["Replicon_Status"] == "multi-replicon"].copy()
    multi_plasmids = multi_plasmids.dropna(subset=["host_genus"])
    multi_plasmids["rep_list_clean"] = multi_plasmids["rep_type(s)"].map(parse_replicons)

    raw_records = []
    unique_records = []
    transition_records = []

    for rep in sorted(multi_hosts.index):
        baseline = set(single_hosts.get(rep, set()))
        multi = set(multi_hosts.get(rep, set()))

        if not baseline:
            continue

        new_genera = sorted(multi - baseline)

        for new_genus in new_genera:
            tax_jump = minimum_taxonomic_jump(new_genus, baseline, taxonomy)

            plasmids_host = multi_plasmids[
                (multi_plasmids["host_genus"] == new_genus) &
                (multi_plasmids["rep_list_clean"].map(lambda xs: rep in xs))
            ]

            supporting_plasmids = sorted(plasmids_host["plasmid_id"].dropna().unique())

            co_reps = []
            for reps in plasmids_host["rep_list_clean"]:
                co_reps.extend([r for r in reps if r != rep])

            co_reps = sorted(set(co_reps))

            unique_records.append({
                "replicon": rep,
                "new_genus": new_genus,
                "taxonomic_jump": tax_jump,
                "n_supporting_plasmids": len(supporting_plasmids),
                "supporting_plasmids": ";".join(supporting_plasmids),
                "baseline_genera": ";".join(sorted(baseline)),
                "multi_genera": ";".join(sorted(multi)),
                "cointegrating_replicons": ";".join(co_reps),
            })

            for plasmid in supporting_plasmids:
                raw_records.append({
                    "replicon": rep,
                    "new_genus": new_genus,
                    "taxonomic_jump": tax_jump,
                    "plasmid_id": plasmid,
                    "cointegrating_replicons": ";".join(co_reps),
                })

            # Figure 2d: all pairwise baseline genus -> new genus connections.
            for base_genus in sorted(baseline):
                transition_records.append({
                    "replicon": rep,
                    "baseline_genus": base_genus,
                    "new_genus": new_genus,
                    "taxonomic_jump": tax_jump,
                })

    unique_events = pd.DataFrame(unique_records)
    raw_events = pd.DataFrame(raw_records)
    transitions = pd.DataFrame(transition_records)

    if unique_events.empty:
        jump_counts = pd.DataFrame()
        transition_edges = pd.DataFrame()
        return raw_events, unique_events, jump_counts, transition_edges

    jump_counts = (
        unique_events.groupby("taxonomic_jump")
        .size()
        .reset_index(name="n_events")
    )
    jump_counts["taxonomic_jump"] = pd.Categorical(jump_counts["taxonomic_jump"], categories=JUMP_ORDER, ordered=True)
    jump_counts = jump_counts.sort_values("taxonomic_jump")

    if not transitions.empty:
        transition_edges = (
            transitions.groupby(["baseline_genus", "new_genus", "taxonomic_jump"])
            .agg(
                n_distinct_replicons=("replicon", "nunique"),
                replicons=("replicon", lambda x: ";".join(sorted(set(x)))),
            )
            .reset_index()
            .sort_values(["taxonomic_jump", "n_distinct_replicons"], ascending=[True, False])
        )
    else:
        transition_edges = pd.DataFrame()

    return raw_events, unique_events, jump_counts, transition_edges


def replicon_hostrange_changes(df: pd.DataFrame) -> pd.DataFrame:
    rep_df = explode_replicons(df.dropna(subset=["host_genus"]).copy())

    single_hosts = (
        rep_df[rep_df["Replicon_Status"] == "single-replicon"]
        .groupby("replicon")["host_genus"]
        .apply(lambda x: sorted(set(x.dropna())))
    )

    multi_hosts = (
        rep_df[rep_df["Replicon_Status"] == "multi-replicon"]
        .groupby("replicon")["host_genus"]
        .apply(lambda x: sorted(set(x.dropna())))
    )

    all_reps = sorted(set(single_hosts.index) | set(multi_hosts.index))
    rows = []

    for rep in all_reps:
        s = set(single_hosts.get(rep, []))
        m = set(multi_hosts.get(rep, []))
        new = sorted(m - s)

        rows.append({
            "replicon": rep,
            "n_single_genera": len(s),
            "n_multi_genera": len(m),
            "n_new_genera": len(new),
            "single_genera": ";".join(sorted(s)),
            "multi_genera": ";".join(sorted(m)),
            "new_genera": ";".join(new),
        })

    return pd.DataFrame(rows).sort_values("n_new_genera", ascending=False)


# ============================================================
# MAIN
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(
        description="Generate Section 2 mobility and host-range analysis tables."
    )

    ap.add_argument(
        "--supplementary-dataset",
        required=True,
        help="Supplementary_Dataset_1.xlsx/tsv/csv with deduplicated plasmids.",
    )
    ap.add_argument(
        "--typing",
        required=True,
        help="Typing table with NUCCORE_ACC, rep_type(s), predicted_mobility, predicted_host_range_overall_rank, genus.",
    )
    ap.add_argument(
        "--taxonomy",
        default=None,
        help="Optional taxonomy table with genus, family, order, class, phylum.",
    )
    ap.add_argument(
        "--outdir",
        required=True,
        help="Output directory for Section 2 tables.",
    )

    args = ap.parse_args()
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    supp = load_supplementary_dataset(args.supplementary_dataset)
    df = load_typing(args.typing, supp)

    write_table(df, outdir / "section2_master_table.tsv")

    # Figure 2a
    write_table(mobility_distribution(df), outdir / "fig2a_mobility_distribution.tsv")
    write_table(mobility_chi_square(df), outdir / "fig2a_mobility_chi_square.tsv")
    write_table(
        fisher_by_category(df, "predicted_mobility", "predicted_mobility"),
        outdir / "fig2a_mobility_fisher_tests.tsv",
    )

    # Figure 2b
    write_table(predicted_host_range_distribution(df), outdir / "fig2b_predicted_host_range_distribution.tsv")
    write_table(
        fisher_by_category(df, "predicted_host_range_overall_rank", "host_range_rank"),
        outdir / "fig2b_predicted_host_range_fisher_tests.tsv",
    )
    write_table(suppfig4_replicon_predicted_host_range(df), outdir / "suppfig4_replicon_predicted_host_range.tsv")

    # Figure 2c/d were moved to a dedicated R script implementing
    # minimum-jump-per-event Sankey/alluvial logic.
    write_table(replicon_hostrange_changes(df), outdir / "fig2_observed_replicon_hostrange_changes.tsv")

    print("[done] Section 2 (Figure 2a/2b + shared tables) generated. For Figure 2c/d, run 02_section2_hostrange_jumps_minimum_event.R")


if __name__ == "__main__":
    main()
