#!/usr/bin/env python3
from __future__ import annotations

import csv
import argparse
import gzip
from collections import defaultdict
from contextlib import AbstractContextManager
from pathlib import Path
from typing import TextIO


ROOT: Path
RAW_EVENTS_TSV: Path
SPECIES_TSV: Path
MOBTYPER_MASTER_TSV: Path
OUT_BY_COMBO: Path
OUT_ONE_ROW_PER_COMBO: Path
OUT_ONE_ROW_PER_PLSDB_PLASMID: Path
OUT_ONE_ROW_PER_PLSDB_PLASMID_FILTERED: Path
OUT_VALID_211_SUMMARY: Path
OUT_ONE_ROW_PER_PLSDB_PLASMID_ATB_VALIDATED: Path
OUT_VALID_36_SUMMARY: Path
OUT_BY_PATH: Path
OUT_EXAMPLES: Path
OUT_SUMMARY: Path


def split_set(value: str, sep: str = ";") -> tuple[str, ...]:
    value = (value or "").strip()
    if not value or value == "-":
        return tuple()
    return tuple(sorted({x.strip() for x in value.split(sep) if x.strip() and x.strip() != "-"}))


def split_replicons(value: str) -> tuple[str, ...]:
    value = (value or "").strip()
    if not value or value == "-":
        return tuple()
    return tuple(sorted({x.strip() for x in value.split(",") if x.strip() and x.strip() != "-"}))


def genus_from_species(value: str) -> str:
    value = (value or "").strip()
    if not value or value.lower() == "unknown":
        return ""
    return value.split()[0]


def best_species(row: dict[str, str]) -> tuple[str, str]:
    for col in ("sylph_species", "sylph_species_pre_202505", "scientific_name"):
        value = (row.get(col) or "").strip()
        if value and value.lower() != "unknown":
            return value, col
    return "", ""


def open_text(path: Path) -> AbstractContextManager[TextIO]:
    if path.suffix == ".gz":
        return gzip.open(path, mode="rt", newline="", encoding="utf-8")
    return path.open(newline="", encoding="utf-8")


def read_raw_events() -> list[dict[str, str]]:
    with open_text(RAW_EVENTS_TSV) as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def require_columns(
    fieldnames: list[str] | None,
    required: set[str],
    table_name: str,
) -> None:
    available = set(fieldnames or [])
    missing = required - available
    if missing:
        raise ValueError(
            f"{table_name} is missing required columns: {', '.join(sorted(missing))}"
        )


def read_species_for_target_genera(
    target_genera: set[str],
) -> dict[str, dict[str, str]]:
    out: dict[str, dict[str, str]] = {}
    with open_text(SPECIES_TSV) as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        require_columns(reader.fieldnames, {"sample_accession"}, "species-call table")
        species_columns = {
            "sylph_species",
            "sylph_species_pre_202505",
            "scientific_name",
        }
        if not species_columns & set(reader.fieldnames or []):
            raise ValueError(
                "species-call table must contain at least one species-call column: "
                + ", ".join(sorted(species_columns))
            )
        for row in reader:
            species, source = best_species(row)
            genus = genus_from_species(species)
            if genus not in target_genera:
                continue
            out[row["sample_accession"]] = {
                "species": species,
                "species_source": source,
                "genus": genus,
                "hq": row.get("HQ", ""),
            }
    return out


def normalize_combo(target: str, cointegrated: str) -> tuple[str, ...]:
    return tuple(sorted({target, *split_set(cointegrated)}))


def main() -> None:
    global ROOT, RAW_EVENTS_TSV, SPECIES_TSV, MOBTYPER_MASTER_TSV
    global OUT_BY_COMBO, OUT_ONE_ROW_PER_COMBO, OUT_ONE_ROW_PER_PLSDB_PLASMID
    global OUT_ONE_ROW_PER_PLSDB_PLASMID_FILTERED, OUT_VALID_211_SUMMARY
    global OUT_ONE_ROW_PER_PLSDB_PLASMID_ATB_VALIDATED, OUT_VALID_36_SUMMARY
    global OUT_BY_PATH, OUT_EXAMPLES, OUT_SUMMARY
    parser = argparse.ArgumentParser(
        description=(
            "Validate observed PLSDB host-range events using a precomputed "
            "AllTheBacteria MOB-typer master table."
        )
    )
    parser.add_argument("--raw-events", required=True)
    parser.add_argument("--species-calls", required=True)
    parser.add_argument(
        "--mobtyper-master",
        required=True,
        help="Consolidated table with one MOB-typer result row per assembly.",
    )
    parser.add_argument("--outdir", required=True)
    args = parser.parse_args()
    ROOT = Path(args.outdir)
    RAW_EVENTS_TSV = Path(args.raw_events)
    SPECIES_TSV = Path(args.species_calls)
    MOBTYPER_MASTER_TSV = Path(args.mobtyper_master)
    OUT_BY_COMBO = ROOT / "atb_plsdb_observed_subcombinations_by_combo.tsv"
    OUT_ONE_ROW_PER_COMBO = ROOT / "atb_plsdb_one_row_per_combination.tsv"
    OUT_ONE_ROW_PER_PLSDB_PLASMID = ROOT / "atb_plsdb_one_row_per_plasmid.tsv"
    OUT_ONE_ROW_PER_PLSDB_PLASMID_FILTERED = ROOT / "atb_plsdb_one_row_per_plasmid_valid_only.tsv"
    OUT_VALID_211_SUMMARY = ROOT / "atb_plsdb_valid_211_path_summary.tsv"
    OUT_ONE_ROW_PER_PLSDB_PLASMID_ATB_VALIDATED = ROOT / "atb_plsdb_one_row_per_plasmid_atb_validated.tsv"
    OUT_VALID_36_SUMMARY = ROOT / "atb_plsdb_atb_validated_path_summary.tsv"
    OUT_BY_PATH = ROOT / "atb_plsdb_observed_subcombinations_by_fig2d_path.tsv"
    OUT_EXAMPLES = ROOT / "atb_plsdb_observed_subcombinations_example_samples.tsv"
    OUT_SUMMARY = ROOT / "atb_plsdb_observed_subcombinations_summary.tsv"
    ROOT.mkdir(parents=True, exist_ok=True)

    raw_rows = read_raw_events()
    if not raw_rows:
        raise SystemExit("No raw host-range events found")

    combo_index: dict[tuple[str, str, tuple[str, ...]], dict[str, object]] = {}
    path_index: dict[tuple[str, str], dict[str, object]] = {}
    raw_event_rows: list[dict[str, object]] = []
    target_reps: set[str] = set()
    target_genera: set[str] = set()

    for idx, row in enumerate(raw_rows, start=1):
        target = row["replicon"]
        genus = row["new_genus"]
        combo = normalize_combo(target, row.get("cointegrated_replicons", ""))
        combo_key = (target, genus, combo)
        path_key = (target, genus)

        target_reps.add(target)
        target_genera.add(genus)
        raw_event_rows.append(
            {
                "plasmid": row["plasmid"],
                "replicon": target,
                "new_genus": genus,
                "new_family": row["new_family"],
                "taxonomic_jump": row["taxonomic_jump"],
                "baseline_genera": row.get("baseline_genera", ""),
                "baseline_families": row.get("baseline_families", ""),
                "cointegrated_replicons": row.get("cointegrated_replicons", ""),
                "observed_plsdb_combination": combo,
            }
        )

        if path_key not in path_index:
            path_index[path_key] = {
                "path_index": len(path_index) + 1,
                "replicon": target,
                "new_genus": genus,
                "new_family": row["new_family"],
                "taxonomic_jump": row["taxonomic_jump"],
                "baseline_genera": row.get("baseline_genera", ""),
                "baseline_families": row.get("baseline_families", ""),
            }

        if combo_key not in combo_index:
            combo_index[combo_key] = {
                "combo_index": len(combo_index) + 1,
                "path_index": path_index[path_key]["path_index"],
                "replicon": target,
                "new_genus": genus,
                "new_family": row["new_family"],
                "taxonomic_jump": row["taxonomic_jump"],
                "observed_plsdb_combination": combo,
                "plsdb_partner_replicons": tuple(x for x in combo if x != target),
                "support_plasmids": set(),
                "baseline_genera": row.get("baseline_genera", ""),
                "baseline_families": row.get("baseline_families", ""),
            }

        combo_index[combo_key]["support_plasmids"].add(row["plasmid"])

    combos_by_path_key: dict[tuple[str, str], list[tuple[str, str, tuple[str, ...]]]] = defaultdict(list)
    for combo_key in combo_index:
        combos_by_path_key[(combo_key[0], combo_key[1])].append(combo_key)

    species = read_species_for_target_genera(target_genera)

    exact_samples = defaultdict(set)
    exact_plus_extra_samples = defaultdict(set)
    partial_overlap_samples = defaultdict(set)
    target_single_samples = defaultdict(set)
    target_other_no_partner_samples = defaultdict(set)
    target_any_samples = defaultdict(set)
    exact_atb_combos = defaultdict(set)
    exact_plus_extra_atb_combos = defaultdict(set)
    partial_overlap_atb_combos = defaultdict(set)
    target_single_atb_combos = defaultdict(set)
    target_other_no_partner_atb_combos = defaultdict(set)
    sample_examples = defaultdict(list)

    with open_text(MOBTYPER_MASTER_TSV) as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        master_columns = set(reader.fieldnames or [])
        if not {"sample", "sample_id"} & master_columns:
            raise ValueError(
                "MOB-typer master table must contain 'sample' or 'sample_id'"
            )
        require_columns(
            reader.fieldnames,
            {"rep_type(s)"},
            "MOB-typer master table",
        )
        for row in reader:
            sample = row.get("sample") or row.get("sample_id") or ""
            meta = species.get(sample)
            if not meta or not meta["genus"] or meta["genus"] not in target_genera:
                continue
            reps = split_replicons(row.get("rep_type(s)", ""))
            if not reps:
                continue
            reps_set = set(reps)
            for target in reps_set & target_reps:
                for combo_key in combos_by_path_key.get((target, meta["genus"]), []):
                    info = combo_index[combo_key]
                    expected = set(info["observed_plsdb_combination"])
                    partners = set(info["plsdb_partner_replicons"])

                    if target not in reps_set:
                        continue

                    target_any_samples[combo_key].add(sample)
                    if reps_set == expected:
                        exact_samples[combo_key].add(sample)
                        exact_atb_combos[combo_key].add(";".join(sorted(reps_set)))
                    elif expected.issubset(reps_set):
                        exact_plus_extra_samples[combo_key].add(sample)
                        exact_plus_extra_atb_combos[combo_key].add(";".join(sorted(reps_set)))
                    elif partners & reps_set:
                        partial_overlap_samples[combo_key].add(sample)
                        partial_overlap_atb_combos[combo_key].add(";".join(sorted(reps_set)))
                    elif len(reps_set) == 1:
                        target_single_samples[combo_key].add(sample)
                        target_single_atb_combos[combo_key].add(";".join(sorted(reps_set)))
                    else:
                        target_other_no_partner_samples[combo_key].add(sample)
                        target_other_no_partner_atb_combos[combo_key].add(";".join(sorted(reps_set)))

                    if len(sample_examples[combo_key]) < 20 and (
                        reps_set == expected
                        or expected.issubset(reps_set)
                        or target in reps_set
                    ):
                        sample_examples[combo_key].append(
                            {
                                "sample_accession": sample,
                                "species_call": meta["species"],
                                "species_call_source": meta["species_source"],
                                "HQ": meta["hq"],
                                "atb_replicons_detected": ";".join(sorted(reps_set)),
                                "expected_plsdb_combination": ";".join(sorted(expected)),
                                "match_class": (
                                    "exact"
                                    if reps_set == expected
                                    else "exact_plus_extra"
                                    if expected.issubset(reps_set)
                                    else "partial_overlap"
                                    if partners & reps_set
                                    else "single"
                                    if len(reps_set) == 1
                                    else "target_other_no_partner"
                                ),
                            }
                        )

    combo_rows = []
    one_row_per_combo_rows = []
    one_row_per_plasmid_rows = []
    one_row_per_plasmid_valid_rows = []
    one_row_per_plasmid_atb_validated_rows = []
    path_rows = []
    valid_211_rows = []
    valid_36_rows = []
    for combo_key, info in sorted(combo_index.items(), key=lambda kv: (kv[1]["path_index"], kv[1]["combo_index"])):
        expected = set(info["observed_plsdb_combination"])
        exact_n = len(exact_samples[combo_key])
        exact_plus_extra_n = len(exact_plus_extra_samples[combo_key])
        partial_n = len(partial_overlap_samples[combo_key])
        single_n = len(target_single_samples[combo_key])
        other_no_partner_n = len(target_other_no_partner_samples[combo_key])
        any_n = len(target_any_samples[combo_key])

        if exact_n:
            status = "exact_combination_found_in_atb"
        elif exact_plus_extra_n:
            status = "exact_combination_found_with_extra_replicons_in_atb"
        elif partial_n:
            status = "target_found_with_partial_plsdb_partner_overlap_in_atb"
        elif single_n:
            status = "target_found_as_single_in_atb"
        elif other_no_partner_n:
            status = "target_found_with_other_replicons_no_plsdb_partner_in_atb"
        else:
            status = "target_not_found_in_atb_new_genus"

        combo_rows.append(
            {
                "combo_index": info["combo_index"],
                "path_index": info["path_index"],
                "replicon": info["replicon"],
                "new_genus": info["new_genus"],
                "new_family": info["new_family"],
                "taxonomic_jump": info["taxonomic_jump"],
                "observed_plsdb_combination": ";".join(info["observed_plsdb_combination"]),
                "plsdb_partner_replicons": ";".join(info["plsdb_partner_replicons"]),
                "n_plsdb_partner_replicons": len(info["plsdb_partner_replicons"]),
                "n_plasmids_supporting_combo": len(info["support_plasmids"]),
                "support_plasmids": ";".join(sorted(info["support_plasmids"])),
                "atb_samples_with_target_any_state": any_n,
                "atb_samples_exact_combination": exact_n,
                "atb_samples_exact_combination_plus_extra_replicons": exact_plus_extra_n,
                "atb_samples_partial_plsdb_partner_overlap": partial_n,
                "atb_samples_target_as_single": single_n,
                "atb_samples_target_with_other_replicons_no_plsdb_partner": other_no_partner_n,
                "atb_status": status,
                "caveat": "ATB is MOB-typer sample/assembly evidence, not proof that the combination is on the same complete plasmid",
                "baseline_genera": info["baseline_genera"],
                "baseline_families": info["baseline_families"],
            }
        )
        one_row_per_combo_rows.append(
            {
                "combo_index": info["combo_index"],
                "path_index": info["path_index"],
                "anchor_replicon": info["replicon"],
                "partner_replicons": ";".join(info["plsdb_partner_replicons"]),
                "plsdb_observed_combination": ";".join(info["observed_plsdb_combination"]),
                "single_host_baseline_of_anchor": info["baseline_genera"],
                "multi_host_new_genus": info["new_genus"],
                "new_family": info["new_family"],
                "taxonomic_jump": info["taxonomic_jump"],
                "n_plasmids_supporting_plsdb_combination": len(info["support_plasmids"]),
                "support_plasmids": ";".join(sorted(info["support_plasmids"])),
                "seen_in_atb": "yes" if any_n > 0 else "no",
                "how_seen_in_atb": status,
                "atb_samples_with_anchor_any_state": any_n,
                "atb_samples_exact_same_combination": exact_n,
                "atb_exact_combinations_seen": "|".join(sorted(exact_atb_combos[combo_key])),
                "atb_samples_same_combination_plus_extra": exact_plus_extra_n,
                "atb_exact_plus_extra_combinations_seen": "|".join(sorted(exact_plus_extra_atb_combos[combo_key])),
                "atb_samples_partial_partner_overlap": partial_n,
                "atb_partial_overlap_combinations_seen": "|".join(sorted(partial_overlap_atb_combos[combo_key])),
                "atb_samples_anchor_as_single": single_n,
                "atb_single_anchor_combinations_seen": "|".join(sorted(target_single_atb_combos[combo_key])),
                "atb_samples_anchor_with_non_plsdb_partners": other_no_partner_n,
                "atb_non_plsdb_partner_combinations_seen": "|".join(sorted(target_other_no_partner_atb_combos[combo_key])),
            }
        )

    combo_lookup = {
        (
            row["replicon"],
            row["new_genus"],
            tuple(sorted(row["observed_plsdb_combination"].split(";"))),
        ): row
        for row in combo_rows
    }
    for idx, raw in enumerate(raw_event_rows, start=1):
        combo_key = (raw["replicon"], raw["new_genus"], raw["observed_plsdb_combination"])
        combo_row = combo_lookup[combo_key]
        same_subset_n = (
            int(combo_row["atb_samples_exact_combination"])
            + int(combo_row["atb_samples_exact_combination_plus_extra_replicons"])
        )
        partial_n = int(combo_row["atb_samples_partial_plsdb_partner_overlap"])
        single_n = int(combo_row["atb_samples_target_as_single"])
        non_plsdb_n = int(combo_row["atb_samples_target_with_other_replicons_no_plsdb_partner"])
        invalidating_n = single_n
        invalidation_reasons = []
        if single_n > 0:
            invalidation_reasons.append("anchor_seen_as_single")
        one_row_per_plasmid_rows.append(
            {
                "raw_event_index": idx,
                "plsdb_plasmid": raw["plasmid"],
                "anchor_replicon": raw["replicon"],
                "partner_replicons": raw["cointegrated_replicons"],
                "plsdb_observed_combination": ";".join(raw["observed_plsdb_combination"]),
                "single_host_baseline_of_anchor": raw["baseline_genera"],
                "multi_host_new_genus": raw["new_genus"],
                "new_family": raw["new_family"],
                "taxonomic_jump": raw["taxonomic_jump"],
                "seen_in_atb": "yes" if int(combo_row["atb_samples_with_target_any_state"]) > 0 else "no",
                "atb_support_level": (
                    "same_subset_or_more"
                    if same_subset_n > 0
                    else "partial_only"
                    if partial_n > 0
                    else "single_only"
                    if single_n > 0
                    else "non_plsdb_partners_only"
                    if non_plsdb_n > 0
                    else "not_seen"
                ),
                "atb_samples_with_at_least_same_subset": str(same_subset_n),
                "atb_samples_exact_same_combination": combo_row["atb_samples_exact_combination"],
                "atb_samples_same_subset_plus_extra": combo_row["atb_samples_exact_combination_plus_extra_replicons"],
                "atb_samples_partial_partner_overlap": str(partial_n),
                "atb_samples_anchor_as_single": str(single_n),
                "atb_samples_anchor_with_non_plsdb_partners": str(non_plsdb_n),
                "jump_invalidated_by_anchor_seen_outside_plsdb_subset": "yes" if invalidating_n > 0 else "no",
                "invalidating_atb_samples_total": str(invalidating_n),
                "invalidation_reasons": ";".join(invalidation_reasons),
                "atb_exact_combinations_seen": "|".join(sorted(exact_atb_combos[combo_key])),
                "atb_exact_plus_extra_combinations_seen": "|".join(sorted(exact_plus_extra_atb_combos[combo_key])),
                "atb_partial_overlap_combinations_seen": "|".join(sorted(partial_overlap_atb_combos[combo_key])),
                "atb_single_anchor_combinations_seen": "|".join(sorted(target_single_atb_combos[combo_key])),
                "atb_non_plsdb_partner_combinations_seen": "|".join(sorted(target_other_no_partner_atb_combos[combo_key])),
            }
        )
        if invalidating_n == 0:
            one_row_per_plasmid_valid_rows.append(one_row_per_plasmid_rows[-1])
            if same_subset_n > 0:
                one_row_per_plasmid_atb_validated_rows.append(one_row_per_plasmid_rows[-1])

    path_to_combo_rows: dict[tuple[str, str], list[dict[str, object]]] = defaultdict(list)
    for row in combo_rows:
        path_to_combo_rows[(row["replicon"], row["new_genus"])].append(row)

    for path_key, info in sorted(path_index.items(), key=lambda kv: kv[1]["path_index"]):
        rows = path_to_combo_rows.get(path_key, [])
        n_combos = len(rows)
        n_exact = sum(1 for row in rows if row["atb_status"] == "exact_combination_found_in_atb")
        n_exact_plus_extra = sum(1 for row in rows if row["atb_status"] == "exact_combination_found_with_extra_replicons_in_atb")
        n_partial = sum(1 for row in rows if row["atb_status"] == "target_found_with_partial_plsdb_partner_overlap_in_atb")
        n_single = sum(1 for row in rows if row["atb_status"] == "target_found_as_single_in_atb")
        n_other_no_partner = sum(1 for row in rows if row["atb_status"] == "target_found_with_other_replicons_no_plsdb_partner_in_atb")
        n_not_found = sum(1 for row in rows if row["atb_status"] == "target_not_found_in_atb_new_genus")
        combo_strings = sorted(row["observed_plsdb_combination"] for row in rows)
        exact_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "exact_combination_found_in_atb"
        )
        exact_plus_extra_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "exact_combination_found_with_extra_replicons_in_atb"
        )
        partial_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "target_found_with_partial_plsdb_partner_overlap_in_atb"
        )
        single_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "target_found_as_single_in_atb"
        )
        other_no_partner_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "target_found_with_other_replicons_no_plsdb_partner_in_atb"
        )
        not_found_combos = sorted(
            row["observed_plsdb_combination"]
            for row in rows
            if row["atb_status"] == "target_not_found_in_atb_new_genus"
        )
        if n_exact == n_combos and n_combos > 0:
            path_status = "all_plsdb_combinations_found_exact_in_atb"
        elif (n_exact + n_exact_plus_extra) == n_combos and n_combos > 0:
            path_status = "all_plsdb_combinations_found_exact_or_with_extra_in_atb"
        elif (n_exact + n_exact_plus_extra) > 0:
            path_status = "some_plsdb_combinations_found_exact_or_with_extra_in_atb"
        elif n_partial > 0:
            path_status = "only_partial_plsdb_combination_overlap_in_atb"
        elif n_single > 0:
            path_status = "target_seen_as_single_in_atb_only"
        elif n_other_no_partner > 0:
            path_status = "target_seen_with_non_plsdb_partners_in_atb_only"
        else:
            path_status = "no_plsdb_combination_support_in_atb"
        path_rows.append(
            {
                "path_index": info["path_index"],
                "replicon": info["replicon"],
                "new_genus": info["new_genus"],
                "new_family": info["new_family"],
                "taxonomic_jump": info["taxonomic_jump"],
                "status": path_status,
                "n_unique_plsdb_combinations": n_combos,
                "n_combinations_exact_in_atb": n_exact,
                "n_combinations_exact_plus_extra_in_atb": n_exact_plus_extra,
                "n_combinations_partial_overlap_in_atb": n_partial,
                "n_combinations_target_as_single_in_atb": n_single,
                "n_combinations_target_with_other_no_partner_in_atb": n_other_no_partner,
                "n_combinations_not_found_in_atb": n_not_found,
                "plsdb_observed_combinations": "|".join(combo_strings),
                "plsdb_combinations_exact_in_atb": "|".join(exact_combos),
                "plsdb_combinations_exact_plus_extra_in_atb": "|".join(exact_plus_extra_combos),
                "plsdb_combinations_partial_overlap_in_atb": "|".join(partial_combos),
                "plsdb_combinations_target_as_single_in_atb": "|".join(single_combos),
                "plsdb_combinations_target_with_other_no_partner_in_atb": "|".join(other_no_partner_combos),
                "plsdb_combinations_not_found_in_atb": "|".join(not_found_combos),
                "baseline_genera": info["baseline_genera"],
                "baseline_families": info["baseline_families"],
            }
        )

    with OUT_BY_COMBO.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(combo_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(combo_rows)

    with OUT_ONE_ROW_PER_COMBO.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(one_row_per_combo_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(one_row_per_combo_rows)

    with OUT_ONE_ROW_PER_PLSDB_PLASMID.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(one_row_per_plasmid_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(one_row_per_plasmid_rows)

    with OUT_ONE_ROW_PER_PLSDB_PLASMID_FILTERED.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(one_row_per_plasmid_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(one_row_per_plasmid_valid_rows)

    with OUT_ONE_ROW_PER_PLSDB_PLASMID_ATB_VALIDATED.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(one_row_per_plasmid_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(one_row_per_plasmid_atb_validated_rows)

    valid_by_path: dict[tuple[str, str], list[dict[str, str]]] = defaultdict(list)
    for row in one_row_per_plasmid_valid_rows:
        valid_by_path[(row["anchor_replicon"], row["multi_host_new_genus"])].append(row)

    for idx, ((anchor, new_genus), rows_for_path) in enumerate(sorted(valid_by_path.items()), start=1):
        first = rows_for_path[0]
        unique_combos = sorted({row["plsdb_observed_combination"] for row in rows_for_path})
        unique_plasmids = sorted({row["plsdb_plasmid"] for row in rows_for_path})
        jump_levels = sorted({row["taxonomic_jump"] for row in rows_for_path}, key=lambda x: {"family": 0, "order": 1, "class": 2, "phylum": 3}.get(x, 99))
        valid_211_rows.append(
            {
                "path_index": idx,
                "anchor_replicon": anchor,
                "multi_host_new_genus": new_genus,
                "new_family": first["new_family"],
                "minimum_taxonomic_jump": jump_levels[0],
                "single_host_baseline_of_anchor": first["single_host_baseline_of_anchor"],
                "n_valid_plsdb_raw_events": len(rows_for_path),
                "n_valid_plsdb_unique_combinations": len(unique_combos),
                "n_valid_plsdb_unique_plasmids": len(unique_plasmids),
                "valid_plsdb_combinations": "|".join(unique_combos),
                "valid_plsdb_plasmids": ";".join(unique_plasmids),
                "max_atb_samples_with_at_least_same_subset_across_valid_combos": max(
                    int(row["atb_samples_with_at_least_same_subset"]) for row in rows_for_path
                ),
                "sum_atb_samples_with_at_least_same_subset_across_valid_combos": sum(
                    int(row["atb_samples_with_at_least_same_subset"]) for row in rows_for_path
                ),
                "at_least_one_valid_combo_seen_in_atb": (
                    "yes"
                    if any(int(row["atb_samples_with_at_least_same_subset"]) > 0 for row in rows_for_path)
                    else "no"
                ),
                "all_valid_combos_seen_in_atb": (
                    "yes"
                    if all(int(row["atb_samples_with_at_least_same_subset"]) > 0 for row in rows_for_path)
                    else "no"
                ),
            }
        )

    with OUT_VALID_211_SUMMARY.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(valid_211_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(valid_211_rows)

    atb_validated_by_path: dict[tuple[str, str], list[dict[str, str]]] = defaultdict(list)
    for row in one_row_per_plasmid_atb_validated_rows:
        atb_validated_by_path[(row["anchor_replicon"], row["multi_host_new_genus"])].append(row)

    for idx, ((anchor, new_genus), rows_for_path) in enumerate(sorted(atb_validated_by_path.items()), start=1):
        first = rows_for_path[0]
        unique_combos = sorted({row["plsdb_observed_combination"] for row in rows_for_path})
        unique_plasmids = sorted({row["plsdb_plasmid"] for row in rows_for_path})
        jump_levels = sorted({row["taxonomic_jump"] for row in rows_for_path}, key=lambda x: {"family": 0, "order": 1, "class": 2, "phylum": 3}.get(x, 99))
        valid_36_rows.append(
            {
                "path_index": idx,
                "anchor_replicon": anchor,
                "multi_host_new_genus": new_genus,
                "new_family": first["new_family"],
                "minimum_taxonomic_jump": jump_levels[0],
                "single_host_baseline_of_anchor": first["single_host_baseline_of_anchor"],
                "n_atb_validated_plsdb_raw_events": len(rows_for_path),
                "n_atb_validated_plsdb_unique_combinations": len(unique_combos),
                "n_atb_validated_plsdb_unique_plasmids": len(unique_plasmids),
                "atb_validated_plsdb_combinations": "|".join(unique_combos),
                "atb_validated_plsdb_plasmids": ";".join(unique_plasmids),
                "max_atb_samples_with_at_least_same_subset_across_validated_combos": max(
                    int(row["atb_samples_with_at_least_same_subset"]) for row in rows_for_path
                ),
                "sum_atb_samples_with_at_least_same_subset_across_validated_combos": sum(
                    int(row["atb_samples_with_at_least_same_subset"]) for row in rows_for_path
                ),
            }
        )

    with OUT_VALID_36_SUMMARY.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(valid_36_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(valid_36_rows)

    with OUT_BY_PATH.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(path_rows[0]), delimiter="\t")
        writer.writeheader()
        writer.writerows(path_rows)

    example_rows = []
    for combo_key, examples in sorted(sample_examples.items()):
        info = combo_index[combo_key]
        for ex in examples:
            example_rows.append(
                {
                    "combo_index": info["combo_index"],
                    "path_index": info["path_index"],
                    "replicon": info["replicon"],
                    "new_genus": info["new_genus"],
                    "observed_plsdb_combination": ";".join(info["observed_plsdb_combination"]),
                    **ex,
                }
            )
    with OUT_EXAMPLES.open("w", newline="", encoding="utf-8") as handle:
        fieldnames = [
            "combo_index",
            "path_index",
            "replicon",
            "new_genus",
            "observed_plsdb_combination",
            "sample_accession",
            "species_call",
            "species_call_source",
            "HQ",
            "atb_replicons_detected",
            "expected_plsdb_combination",
            "match_class",
        ]
        writer = csv.DictWriter(handle, fieldnames=fieldnames, delimiter="\t")
        writer.writeheader()
        writer.writerows(example_rows)

    summary = defaultdict(int)
    for row in combo_rows:
        summary["fig2d_combinations_total"] += 1
        summary[f'status::{row["atb_status"]}'] += 1
        summary["sum_atb_samples_with_target_any_state"] += int(row["atb_samples_with_target_any_state"])
        summary["sum_atb_samples_exact_combination"] += int(row["atb_samples_exact_combination"])
        summary["sum_atb_samples_exact_combination_plus_extra_replicons"] += int(
            row["atb_samples_exact_combination_plus_extra_replicons"]
        )
        summary["sum_atb_samples_partial_plsdb_partner_overlap"] += int(
            row["atb_samples_partial_plsdb_partner_overlap"]
        )
        summary["sum_atb_samples_target_as_single"] += int(row["atb_samples_target_as_single"])

    with OUT_SUMMARY.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.writer(handle, delimiter="\t")
        writer.writerow(["metric", "value"])
        for key in [
            "fig2d_combinations_total",
            "status::exact_combination_found_in_atb",
            "status::exact_combination_found_with_extra_replicons_in_atb",
            "status::target_found_with_partial_plsdb_partner_overlap_in_atb",
            "status::target_found_as_single_in_atb",
            "status::target_found_with_other_replicons_no_plsdb_partner_in_atb",
            "status::target_not_found_in_atb_new_genus",
            "sum_atb_samples_with_target_any_state",
            "sum_atb_samples_exact_combination",
            "sum_atb_samples_exact_combination_plus_extra_replicons",
            "sum_atb_samples_partial_plsdb_partner_overlap",
            "sum_atb_samples_target_as_single",
        ]:
            writer.writerow([key, summary[key]])

if __name__ == "__main__":
    main()
