#!/usr/bin/env python3

import pandas as pd
import matplotlib.pyplot as plt

# ===============================
# INPUT
# ===============================

df = pd.read_csv("FULL_incremental_summary.tsv", sep="\t")

# ===============================
# PLOT
# ===============================

plt.figure(figsize=(7,5))

plt.plot(df["window"], df["bp_rate"], 
         marker="o", linewidth=2, label="Breakpoints")

plt.plot(df["window"], df["bg_rate"], 
         marker="s", linewidth=2, label="Random plasmid")

plt.plot(df["window"], df["chr_rate"], 
         marker="^", linewidth=2, label="Chromosome")

plt.xlabel("Window size (bp)", fontsize=12)
plt.ylabel("Proportion with ≥1 MGE", fontsize=12)

plt.legend(frameon=False)
plt.grid(alpha=0.3)

plt.tight_layout()
plt.savefig("FULL_incremental_mge_curves.png", dpi=300)
plt.show()

