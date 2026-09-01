#!/usr/bin/env python3
"""Prepare analysis tables from native ConjScan Likely System model names.

This script does not map ConjScan models to conjugative/mobilizable classes.
It preserves the native system_type values parsed from model_fqn and only
adds the pre-existing single- versus multi-replicon status.
"""

from __future__ import annotations

import csv
import argparse
from collections import Counter, defaultdict
from pathlib import Path


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def write_tsv(
    path: Path,
    rows: list[dict[str, object]],
    fieldnames: list[str],
) -> None:
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=fieldnames,
            delimiter="\t",
            lineterminator="\n",
        )
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--systems", required=True,
                        help="Long table of native ConjScan Likely-System calls.")
    parser.add_argument("--plasmid-metadata", required=True,
                        help="One row per plasmid with replicon_status.")
    parser.add_argument("--outdir", required=True)
    args = parser.parse_args()
    output_dir = Path(args.outdir)
    output_dir.mkdir(parents=True, exist_ok=True)
    systems = read_tsv(Path(args.systems))
    metadata = read_tsv(Path(args.plasmid_metadata))

    plasmid_status: dict[str, str] = {}
    for row in metadata:
        plasmid_id = row["plasmid_id"]
        status = row["replicon_status"]
        if plasmid_id in plasmid_status:
            raise ValueError(f"Duplicate plasmid metadata row: {plasmid_id}")
        if status not in {"Single-replicon", "Multi-replicon"}:
            raise ValueError(f"Unexpected replicon status for {plasmid_id}: {status}")
        plasmid_status[plasmid_id] = status

    system_types = sorted({row["system_type"] for row in systems})
    system_ids = [row["sys_id"] for row in systems]
    if len(system_ids) != len(set(system_ids)):
        raise ValueError("sys_id is not unique in conjscan_systems_long.tsv")

    missing_plasmids = sorted(
        {row["plasmid_id"] for row in systems} - set(plasmid_status)
    )
    if missing_plasmids:
        raise ValueError(
            f"{len(missing_plasmids)} ConjScan plasmids lack replicon status"
        )

    long_fields = [
        "plasmid_id",
        "replicon_status",
        "replicon",
        "sys_id",
        "model_fqn",
        "system_type",
        "sys_wholeness",
        "hits",
        "mandatory",
        "accessory",
        "neutral",
        "other",
        "n_unique_genes",
        "genes",
    ]
    long_rows: list[dict[str, object]] = []
    for row in systems:
        long_rows.append(
            {
                "plasmid_id": row["plasmid_id"],
                "replicon_status": plasmid_status[row["plasmid_id"]],
                **{field: row[field] for field in long_fields[2:]},
            }
        )
    write_tsv(
        output_dir
        / "conjscan_native_likely_systems_with_replicon_status.tsv",
        long_rows,
        long_fields,
    )

    per_plasmid_counts: dict[str, Counter[str]] = defaultdict(Counter)
    for row in systems:
        per_plasmid_counts[row["plasmid_id"]][row["system_type"]] += 1

    matrix_fields = [
        "plasmid_id",
        "replicon_status",
        "n_all_likely_systems",
        *[f"n_{system_type}" for system_type in system_types],
    ]
    matrix_rows: list[dict[str, object]] = []
    for plasmid_id in sorted(plasmid_status):
        counts = per_plasmid_counts[plasmid_id]
        matrix_rows.append(
            {
                "plasmid_id": plasmid_id,
                "replicon_status": plasmid_status[plasmid_id],
                "n_all_likely_systems": sum(counts.values()),
                **{
                    f"n_{system_type}": counts[system_type]
                    for system_type in system_types
                },
            }
        )
    write_tsv(
        output_dir / "conjscan_native_model_counts_by_plasmid.tsv",
        matrix_rows,
        matrix_fields,
    )

    denominators = Counter(plasmid_status.values())
    systems_by_status_type: Counter[tuple[str, str]] = Counter()
    plasmids_by_status_type: dict[tuple[str, str], set[str]] = defaultdict(set)
    for row in systems:
        key = (plasmid_status[row["plasmid_id"]], row["system_type"])
        systems_by_status_type[key] += 1
        plasmids_by_status_type[key].add(row["plasmid_id"])

    status_order = ["Single-replicon", "Multi-replicon"]
    summary_rows: list[dict[str, object]] = []
    for status in status_order:
        for system_type in system_types:
            key = (status, system_type)
            n_plasmids = len(plasmids_by_status_type[key])
            denominator = denominators[status]
            summary_rows.append(
                {
                    "replicon_status": status,
                    "system_type": system_type,
                    "n_likely_systems": systems_by_status_type[key],
                    "n_plasmids_with_system_type": n_plasmids,
                    "denominator_plasmids": denominator,
                    "percent_plasmids_with_system_type": (
                        100.0 * n_plasmids / denominator
                    ),
                }
            )
    summary_fields = [
        "replicon_status",
        "system_type",
        "n_likely_systems",
        "n_plasmids_with_system_type",
        "denominator_plasmids",
        "percent_plasmids_with_system_type",
    ]
    write_tsv(
        output_dir
        / "conjscan_native_model_counts_by_replicon_status.tsv",
        summary_rows,
        summary_fields,
    )

    total_system_counts = Counter(row["system_type"] for row in systems)
    total_plasmids_by_type: dict[str, set[str]] = defaultdict(set)
    for row in systems:
        total_plasmids_by_type[row["system_type"]].add(row["plasmid_id"])
    total_rows = [
        {
            "system_type": system_type,
            "n_likely_systems": total_system_counts[system_type],
            "n_plasmids_with_system_type": len(
                total_plasmids_by_type[system_type]
            ),
            "denominator_plasmids": len(plasmid_status),
            "percent_plasmids_with_system_type": (
                100.0
                * len(total_plasmids_by_type[system_type])
                / len(plasmid_status)
            ),
        }
        for system_type in system_types
    ]
    write_tsv(
        output_dir / "conjscan_native_model_counts_total.tsv",
        total_rows,
        [
            "system_type",
            "n_likely_systems",
            "n_plasmids_with_system_type",
            "denominator_plasmids",
            "percent_plasmids_with_system_type",
        ],
    )

    plasmids_with_any = {
        row["plasmid_id"] for row in systems
    }
    denominator_rows = []
    for status in status_order:
        ids = {
            plasmid_id
            for plasmid_id, plasmid_status_value in plasmid_status.items()
            if plasmid_status_value == status
        }
        with_any = len(ids & plasmids_with_any)
        denominator_rows.append(
            {
                "replicon_status": status,
                "n_plasmids": len(ids),
                "n_plasmids_with_any_native_likely_system": with_any,
                "n_plasmids_without_native_likely_system": len(ids) - with_any,
            }
        )
    write_tsv(
        output_dir / "conjscan_native_denominators.tsv",
        denominator_rows,
        [
            "replicon_status",
            "n_plasmids",
            "n_plasmids_with_any_native_likely_system",
            "n_plasmids_without_native_likely_system",
        ],
    )

    print(f"Wrote native ConjScan analysis tables to {output_dir}")
    print(f"Plasmids: {len(plasmid_status)}")
    print(f"Likely systems: {len(systems)}")
    print(f"Native system types: {len(system_types)}")


if __name__ == "__main__":
    main()
