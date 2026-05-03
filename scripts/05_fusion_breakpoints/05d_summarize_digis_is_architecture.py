#!/usr/bin/env python3
"""
05d_summarize_digis_is_architecture.py

Section 5 / Figure 5b-c and Supplementary Figures 12-13:
Summarize insertion sequences detected by digIS in paired breakpoint windows.

This script implements:
- Best IS hit per breakpoint window, chosen by:
    breakpoint overlap first,
    then distance to breakpoint,
    then score,
    then e-value.
- Pair classification:
    0 IS
    1 IS
    2 IS (same)
    2 IS (different)
- Orientation for "2 IS (same)" pairs:
    repeat/direct if both strands are equal
    inverted if strands differ
- Real vs random control summaries.
- IS family/name abundance among "2 IS (same)" pairs.

Inputs
------
--breakpoints-master:
    breakpoints_master.tsv from 05b
--breakpoints-digis-csv:
    digIS output CSV for breakpoints, usually:
    digis_out/breakpoints/digis_output/results/breakpoints_windows.csv

Optional:
--random-master:
    random_windows_master.tsv from 05b
--random-digis-csv:
    digIS output CSV for random windows, usually:
    digis_out/random/digis_output/results/random_windows.csv

Outputs
-------
outdir/
  digis_breakpoint_best_hits.tsv
  digis_breakpoint_pair_classification.tsv
  digis_breakpoint_class_summary.tsv
  digis_breakpoint_orientation_summary.tsv
  digis_breakpoint_2ISsame_family_counts.tsv
  digis_random_best_hits.tsv                 [optional]
  digis_random_pair_classification.tsv        [optional]
  digis_random_class_summary.tsv              [optional]
  digis_real_vs_random_class_summary.tsv      [optional]
"""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
import pandas as pd


CLASS_ORDER = ["0 IS", "1 IS", "2 IS (same)", "2 IS (different)"]


# ============================================================
# Helpers
# ============================================================

def parse_sid(s: object) -> dict:
    d = {}
    for part in str(s).split("|"):
        if "=" in part:
            k, v = part.split("=", 1)
            d[k] = v
    return {
        "pair_id": int(d.get("pair")),
        "plasmid": d.get("plasmid"),
        "bp_kind": d.get("kind"),
        "breakpoint_pos_genome": int(d.get("pos")),
        "window_hw": int(d.get("hw")),
        "dataset": d.get("dataset", ""),
    }


def read_digis_csv(path: Path) -> pd.DataFrame:
    if not path.exists():
        raise FileNotFoundError(path)
    if path.stat().st_size == 0:
        return pd.DataFrame()

    df = pd.read_csv(path, sep=",")
    df.columns = [str(c).strip().replace("\ufeff", "") for c in df.columns]

    required = {"sid", "qid", "sstart", "send", "strand", "score", "evalue"}
    missing = required - set(df.columns)
    if missing:
        raise ValueError(f"{path} missing required digIS columns: {sorted(missing)}")

    meta = df["sid"].apply(parse_sid).apply(pd.Series)
    df = pd.concat([df, meta], axis=1)

    for c in ["sstart", "send", "score", "evalue", "window_hw"]:
        df[c] = pd.to_numeric(df[c], errors="coerce")

    df = df.dropna(subset=["sstart", "send", "window_hw"]).copy()
    df["breakpoint_pos_window"] = df["window_hw"].astype(int) + 1

    df["_start"] = df[["sstart", "send"]].min(axis=1)
    df["_end"] = df[["sstart", "send"]].max(axis=1)

    df["bp_inside"] = (
        (df["_start"] <= df["breakpoint_pos_window"]) &
        (df["_end"] >= df["breakpoint_pos_window"])
    )

    df["dist_to_bp"] = np.where(
        df["bp_inside"],
        0,
        np.minimum(
            np.abs(df["_start"] - df["breakpoint_pos_window"]),
            np.abs(df["_end"] - df["breakpoint_pos_window"]),
        )
    )

    df["is_name_norm"] = df["qid"].astype(str).str.strip()
    return df


def choose_best_hit_per_breakpoint(df: pd.DataFrame) -> pd.DataFrame:
    if df.empty:
        return df
    return (
        df.sort_values(
            ["pair_id", "bp_kind", "bp_inside", "dist_to_bp", "score", "evalue"],
            ascending=[True, True, False, True, False, True],
        )
        .groupby(["pair_id", "bp_kind"], as_index=False)
        .head(1)
        .copy()
    )


def pair_base_from_master(master_path: Path) -> pd.DataFrame:
    master = pd.read_csv(master_path, sep="\t")

    start = (
        master[master["bp_kind"] == "start"]
        [["pair_id", "plasmid", "breakpoint_pos", "window_hw"]]
        .rename(columns={"breakpoint_pos": "bp_start_pos_genome"})
        .drop_duplicates()
    )

    end = (
        master[master["bp_kind"] == "end"]
        [["pair_id", "plasmid", "breakpoint_pos", "window_hw"]]
        .rename(columns={"breakpoint_pos": "bp_end_pos_genome"})
        .drop_duplicates()
    )

    return start.merge(end, on=["pair_id", "plasmid", "window_hw"], how="inner")


def classify_pair(row) -> str:
    s = bool(row["start_has_is"])
    e = bool(row["end_has_is"])

    if (not s) and (not e):
        return "0 IS"
    if s ^ e:
        return "1 IS"
    if str(row["start_is_name_norm"]) == str(row["end_is_name_norm"]):
        return "2 IS (same)"
    return "2 IS (different)"


def orientation_from_strand(row) -> str | None:
    if row["IS_class"] != "2 IS (same)":
        return None
    if pd.isna(row["start_strand"]) or pd.isna(row["end_strand"]):
        return "unknown"
    return "repeat/direct" if str(row["start_strand"]) == str(row["end_strand"]) else "inverted"


def summarize_classes(pair_df: pd.DataFrame, dataset: str) -> pd.DataFrame:
    out = (
        pair_df["IS_class"]
        .value_counts()
        .reindex(CLASS_ORDER, fill_value=0)
        .reset_index()
    )
    out.columns = ["IS_class", "n_pairs"]
    out["dataset"] = dataset
    total = out["n_pairs"].sum()
    out["fraction"] = out["n_pairs"] / total if total else 0
    out["percentage"] = 100 * out["fraction"]
    return out[["dataset", "IS_class", "n_pairs", "fraction", "percentage"]]


def build_pair_classification(master_path: Path, digis_csv: Path, dataset: str):
    base = pair_base_from_master(master_path)
    raw = read_digis_csv(digis_csv)
    best = choose_best_hit_per_breakpoint(raw)

    if best.empty:
        pair = base.copy()
        pair["start_has_is"] = False
        pair["end_has_is"] = False
        pair["start_is_name_norm"] = pd.NA
        pair["end_is_name_norm"] = pd.NA
        pair["start_strand"] = pd.NA
        pair["end_strand"] = pd.NA
    else:
        start = (
            best[best["bp_kind"] == "start"]
            [["pair_id", "plasmid", "qid", "is_name_norm", "_start", "_end", "bp_inside", "dist_to_bp", "strand", "score", "evalue"]]
            .rename(columns={
                "qid": "start_is_name",
                "is_name_norm": "start_is_name_norm",
                "_start": "start_is_start_window",
                "_end": "start_is_end_window",
                "bp_inside": "start_bp_inside",
                "dist_to_bp": "start_dist_to_bp",
                "strand": "start_strand",
                "score": "start_score",
                "evalue": "start_evalue",
            })
        )

        end = (
            best[best["bp_kind"] == "end"]
            [["pair_id", "plasmid", "qid", "is_name_norm", "_start", "_end", "bp_inside", "dist_to_bp", "strand", "score", "evalue"]]
            .rename(columns={
                "qid": "end_is_name",
                "is_name_norm": "end_is_name_norm",
                "_start": "end_is_start_window",
                "_end": "end_is_end_window",
                "bp_inside": "end_bp_inside",
                "dist_to_bp": "end_dist_to_bp",
                "strand": "end_strand",
                "score": "end_score",
                "evalue": "end_evalue",
            })
        )

        pair = base.merge(start, on=["pair_id", "plasmid"], how="left")
        pair = pair.merge(end, on=["pair_id", "plasmid"], how="left")
        pair["start_has_is"] = pair["start_is_name_norm"].notna()
        pair["end_has_is"] = pair["end_is_name_norm"].notna()

    pair["IS_class"] = pair.apply(classify_pair, axis=1)
    pair["IS_orientation"] = pair.apply(orientation_from_strand, axis=1)
    pair["dataset"] = dataset

    return raw, best, pair


def main() -> None:
    ap = argparse.ArgumentParser(description="Summarize digIS breakpoint architecture.")
    ap.add_argument("--breakpoints-master", required=True)
    ap.add_argument("--breakpoints-digis-csv", required=True)
    ap.add_argument("--random-master", default=None)
    ap.add_argument("--random-digis-csv", default=None)
    ap.add_argument("--outdir", required=True)
    args = ap.parse_args()

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    raw, best, pair = build_pair_classification(
        Path(args.breakpoints_master),
        Path(args.breakpoints_digis_csv),
        dataset="breakpoints",
    )

    raw.to_csv(outdir / "digis_breakpoint_raw_hits.tsv", sep="\t", index=False)
    best.to_csv(outdir / "digis_breakpoint_best_hits.tsv", sep="\t", index=False)
    pair.to_csv(outdir / "digis_breakpoint_pair_classification.tsv", sep="\t", index=False)

    summary = summarize_classes(pair, dataset="breakpoints")
    summary.to_csv(outdir / "digis_breakpoint_class_summary.tsv", sep="\t", index=False)

    same = pair[pair["IS_class"] == "2 IS (same)"].copy()
    if not same.empty:
        ori = (
            same["IS_orientation"]
            .value_counts()
            .reset_index()
        )
        ori.columns = ["IS_orientation", "n_pairs"]
        ori["fraction"] = ori["n_pairs"] / ori["n_pairs"].sum()
        ori["percentage"] = 100 * ori["fraction"]
        ori.to_csv(outdir / "digis_breakpoint_orientation_summary.tsv", sep="\t", index=False)

        fam = (
            same["start_is_name_norm"]
            .value_counts()
            .reset_index()
        )
        fam.columns = ["IS_name", "n_pairs"]
        fam.to_csv(outdir / "digis_breakpoint_2ISsame_family_counts.tsv", sep="\t", index=False)

    if args.random_master and args.random_digis_csv:
        raw_r, best_r, pair_r = build_pair_classification(
            Path(args.random_master),
            Path(args.random_digis_csv),
            dataset="random",
        )

        raw_r.to_csv(outdir / "digis_random_raw_hits.tsv", sep="\t", index=False)
        best_r.to_csv(outdir / "digis_random_best_hits.tsv", sep="\t", index=False)
        pair_r.to_csv(outdir / "digis_random_pair_classification.tsv", sep="\t", index=False)

        summary_r = summarize_classes(pair_r, dataset="random")
        summary_r.to_csv(outdir / "digis_random_class_summary.tsv", sep="\t", index=False)

        combined = pd.concat([summary, summary_r], ignore_index=True)
        combined.to_csv(outdir / "digis_real_vs_random_class_summary.tsv", sep="\t", index=False)

    print("[done] digIS architecture summary complete.")


if __name__ == "__main__":
    main()
