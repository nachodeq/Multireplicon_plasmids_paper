#!/usr/bin/env python3
"""
05e_section5_final_tables.py

Section 5 final table builder.

This script collects the outputs from the Section 5 pipeline into compact tables that
correspond to Figure 5 and Supplementary Figures 9-13. It does not generate figures.

Inputs are outputs from:
  05b_breakpoint_homology_analysis.py
  05d_summarize_digis_is_architecture.py

Outputs:
  fig5a_homology_length_summary.tsv
  suppfig9_homology_real_vs_random_summary.tsv
  fig5b_is_class_summary.tsv
  fig5c_is_orientation_summary.tsv
  suppfig10_homologous_cluster_rank_abundance.tsv [if clusters are available]
  suppfig13_is_family_counts.tsv
"""

from __future__ import annotations

import argparse
from pathlib import Path

import pandas as pd


def read_tsv(path: str | Path) -> pd.DataFrame:
    return pd.read_csv(path, sep="\t")


def main() -> None:
    ap = argparse.ArgumentParser(description="Build compact final Section 5 analysis tables.")
    ap.add_argument("--homology-dir", required=True, help="Output directory from 05b.")
    ap.add_argument("--digis-summary-dir", required=True, help="Output directory from 05d.")
    ap.add_argument("--outdir", required=True)
    args = ap.parse_args()

    homology_dir = Path(args.homology_dir)
    digis_dir = Path(args.digis_summary_dir)
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    # Figure 5a / Supp Fig 9
    cats = read_tsv(homology_dir / "homology_length_categories.tsv")
    cats.to_csv(outdir / "fig5a_homology_length_summary.tsv", sep="\t", index=False)
    cats.to_csv(outdir / "suppfig9_homology_real_vs_random_summary.tsv", sep="\t", index=False)

    # Figure 5b
    is_class = read_tsv(digis_dir / "digis_breakpoint_class_summary.tsv")
    is_class.to_csv(outdir / "fig5b_is_class_summary.tsv", sep="\t", index=False)

    # Figure 5c
    ori = digis_dir / "digis_breakpoint_orientation_summary.tsv"
    if ori.exists():
        read_tsv(ori).to_csv(outdir / "fig5c_is_orientation_summary.tsv", sep="\t", index=False)

    # Supp Fig 10
    clusters = homology_dir / "homologous_tract_cluster_sizes.tsv"
    if clusters.exists():
        cl = read_tsv(clusters).sort_values("cluster_size", ascending=False).reset_index(drop=True)
        cl.insert(0, "cluster_rank", range(1, len(cl) + 1))
        cl.to_csv(outdir / "suppfig10_homologous_cluster_rank_abundance.tsv", sep="\t", index=False)

    # Supp Fig 13
    fam = digis_dir / "digis_breakpoint_2ISsame_family_counts.tsv"
    if fam.exists():
        read_tsv(fam).to_csv(outdir / "suppfig13_is_family_counts.tsv", sep="\t", index=False)

    # Supp Fig 12, if random digIS was summarized
    rv = digis_dir / "digis_real_vs_random_class_summary.tsv"
    if rv.exists():
        read_tsv(rv).to_csv(outdir / "suppfig12_is_real_vs_random_summary.tsv", sep="\t", index=False)

    print("[done] Final Section 5 tables written.")


if __name__ == "__main__":
    main()
