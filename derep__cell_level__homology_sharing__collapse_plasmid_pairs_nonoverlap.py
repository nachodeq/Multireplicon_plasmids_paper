#!/usr/bin/env python3
import pandas as pd
from collections import defaultdict

BASE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing"
IN = f"{BASE}/coords_all_hits.tsv"
OUT = f"{BASE}/plasmid_pair_homology.tsv"

def union_len(intervals):
    """intervals = list of (start, end), inclusive"""
    if not intervals:
        return 0
    intervals = sorted(intervals)
    total = 0
    cur_start, cur_end = intervals[0]

    for s, e in intervals[1:]:
        if s <= cur_end:  # solapan
            cur_end = max(cur_end, e)
        else:
            total += cur_end - cur_start + 1
            cur_start, cur_end = s, e

    total += cur_end - cur_start + 1
    return total

acc = defaultdict(lambda: {
    "intervals_A": [],
    "intervals_B": [],
    "pid_sum": 0.0,
    "pid_len": 0,
    "lenA": None,
    "lenB": None
})

CHUNK = 2_000_000

for chunk in pd.read_csv(IN, sep="\t", chunksize=CHUNK):

    for (pair, A, B), sub in chunk.groupby(
        ["replicon_pair", "plasmid_A", "plasmid_B"]
    ):
        key = (pair, A, B)

        # 🔑 NORMALIZACIÓN DE INTERVALOS (FIX)
        acc[key]["intervals_A"].extend(
            (min(s, e), max(s, e))
            for s, e in zip(sub["start_A"], sub["end_A"])
        )
        acc[key]["intervals_B"].extend(
            (min(s, e), max(s, e))
            for s, e in zip(sub["start_B"], sub["end_B"])
        )

        acc[key]["pid_sum"] += (sub["aln_len_A"] * sub["pct_identity"]).sum()
        acc[key]["pid_len"] += sub["aln_len_A"].sum()

        if acc[key]["lenA"] is None:
            acc[key]["lenA"] = sub["plasmid_len_A"].iloc[0]
            acc[key]["lenB"] = sub["plasmid_len_B"].iloc[0]

rows = []

for (pair, A, B), v in acc.items():
    nonov_A = union_len(v["intervals_A"])
    nonov_B = union_len(v["intervals_B"])

    covA = nonov_A / v["lenA"]
    covB = nonov_B / v["lenB"]

    rows.append({
        "replicon_pair": pair,
        "plasmid_A": A,
        "plasmid_B": B,
        "aligned_bp_nonoverlap": min(nonov_A, nonov_B),
        "mean_pid": v["pid_sum"] / v["pid_len"],
        "coverage_A": covA,
        "coverage_B": covB,
        "coverage_min": min(covA, covB)
    })

pd.DataFrame(rows).to_csv(OUT, sep="\t", index=False)
print("Wrote", OUT)

