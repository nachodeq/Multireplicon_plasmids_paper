#!/usr/bin/env python3
import pandas as pd

BASE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing"

plasm = pd.read_csv(
    f"{BASE}/plasmid_pair_homology.tsv",
    sep="\t"
)

rows = []

for pair, sub in plasm.groupby("replicon_pair"):

    rows.append({
        "replicon_pair": pair,
        "n_plasmid_pairs": len(sub),

        # =========
        # BP CRUDOS
        # =========
        "mean_bp": sub["aligned_bp_nonoverlap"].mean(),
        "median_bp": sub["aligned_bp_nonoverlap"].median(),
        "max_bp": sub["aligned_bp_nonoverlap"].max(),
        "sum_bp": sub["aligned_bp_nonoverlap"].sum(),

        # frecuencia por tamaño absoluto
        "p_bp_gt_500":   (sub["aligned_bp_nonoverlap"] > 500).mean(),
        "p_bp_gt_1000":  (sub["aligned_bp_nonoverlap"] > 1000).mean(),
        "p_bp_gt_5000":  (sub["aligned_bp_nonoverlap"] > 5000).mean(),
        "p_bp_gt_10000": (sub["aligned_bp_nonoverlap"] > 10000).mean(),

        # ==================
        # COVERAGE (NORMAL)
        # ==================
        "mean_cov": sub["coverage_min"].mean(),
        "median_cov": sub["coverage_min"].median(),
        "max_cov": sub["coverage_min"].max(),

        # frecuencia por coverage
        "p_cov_gt_001": (sub["coverage_min"] > 0.001).mean(),
        "p_cov_gt_01":  (sub["coverage_min"] > 0.01).mean(),
        "p_cov_gt_05":  (sub["coverage_min"] > 0.05).mean(),
    })

rep = pd.DataFrame(rows)

# separar replicones
rep[["repA", "repB"]] = rep["replicon_pair"].str.split("__", expand=True)

# cargar cointegración
coin = pd.read_csv(f"{BASE}/pairs_table.csv")

final = rep.merge(
    coin,
    on=["repA", "repB"],
    how="left"
)

out = f"{BASE}/replicon_pair_homology_full.tsv"
final.to_csv(out, sep="\t", index=False)

print("Wrote:", out)
print(final.head())

