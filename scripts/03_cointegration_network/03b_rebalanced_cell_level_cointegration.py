#!/usr/bin/env python3
from __future__ import annotations

import argparse
import ast
from collections import defaultdict
from pathlib import Path

import numpy as np
import pandas as pd
from scipy import stats
from statsmodels.stats.proportion import proportion_confint


OUTDIR = Path("cell_level_rebalanced_cointegration")


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser()
    p.add_argument("--input-dir", type=Path, required=True,
                   help="Cell-level directory containing meta/nuccore.csv, assembly.csv and typing.csv.")
    p.add_argument("--outdir", type=Path, default=OUTDIR)
    p.add_argument("--min-cell", type=int, default=5)
    p.add_argument("--min-genus-cell", type=int, default=5)
    p.add_argument("--dominant-frac", type=float, default=0.8)
    p.add_argument("--subsample-cap", type=int, default=100)
    p.add_argument("--subsample-reps", type=int, default=300)
    p.add_argument("--seed", type=int, default=20260704)
    return p.parse_args()


def safe_eval_list(x):
    if pd.isna(x):
        return []
    if isinstance(x, list):
        return x
    if isinstance(x, str):
        try:
            val = ast.literal_eval(x)
        except Exception:
            return []
        return val if isinstance(val, list) else []
    return []


def parse_reps(x) -> list[str]:
    if pd.isna(x):
        return []
    return [r.strip() for r in str(x).split(",") if r.strip()]


def classify_rate(rate: float, ci_low: float, ci_high: float) -> str:
    if rate >= 0.8 and ci_low >= 0.6:
        return "STRONG_COINTEGRATION"
    if rate <= 0.2 and ci_high <= 0.4:
        return "STRONG_REPULSION"
    return "MIXED"


def is_incf_pair(rep_a: str, rep_b: str) -> bool:
    return str(rep_a).startswith("IncF") or str(rep_b).startswith("IncF")


def read_cell_plasmid_replicons(input_dir: Path) -> pd.DataFrame:
    meta = input_dir / "meta"
    nuccore = pd.read_csv(meta / "nuccore.csv", usecols=["NUCCORE_UID", "NUCCORE_ACC", "NUCCORE_Description"])
    assembly = pd.read_csv(meta / "assembly.csv", usecols=["ASSEMBLY_ACC", "NUCCORE_UID"])
    typing = pd.read_csv(meta / "typing.csv", usecols=["NUCCORE_ACC", "rep_type(s)"])

    nuccore["GENUS"] = (
        nuccore["NUCCORE_Description"].astype(str).str.strip().str.split().str[0].str.capitalize()
    )
    nuccore.loc[nuccore["GENUS"].isin(["Nan", ""]), "GENUS"] = np.nan

    assembly["NUCCORE_UID"] = assembly["NUCCORE_UID"].apply(safe_eval_list)
    assembly_long = assembly.explode("NUCCORE_UID").dropna(subset=["NUCCORE_UID"]).copy()

    df = assembly_long.merge(
        nuccore[["NUCCORE_UID", "NUCCORE_ACC", "GENUS"]],
        on="NUCCORE_UID",
        how="left",
    ).merge(typing, on="NUCCORE_ACC", how="left")
    df["rep_types"] = df["rep_type(s)"].apply(parse_reps)
    return df


def build_cell_records(df: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    cell_rows = []
    obs_rows = []

    for cell, sub in df.groupby("ASSEMBLY_ACC", sort=False):
        plasmid_to_reps = (
            sub.dropna(subset=["NUCCORE_ACC"])
            .groupby("NUCCORE_ACC")["rep_types"]
            .apply(lambda xs: set(r for reps in xs for r in reps))
            .to_dict()
        )
        plasmid_to_reps = {p: reps for p, reps in plasmid_to_reps.items() if reps}
        if not plasmid_to_reps:
            continue

        reps_in_cell = set.union(*plasmid_to_reps.values())
        genus_modes = sub["GENUS"].dropna().mode()
        genus = genus_modes.iloc[0] if len(genus_modes) else "Unknown"
        has_incf = any(str(r).startswith("IncF") for r in reps_in_cell)

        cell_rows.append(
            {
                "ASSEMBLY_ACC": cell,
                "genus": genus,
                "n_plasmids_with_replicon": len(plasmid_to_reps),
                "n_replicon_types": len(reps_in_cell),
                "has_IncF": has_incf,
            }
        )

        reps_sorted = sorted(reps_in_cell)
        for i, rep_a in enumerate(reps_sorted):
            for rep_b in reps_sorted[i + 1 :]:
                same_plasmid = any({rep_a, rep_b}.issubset(reps) for reps in plasmid_to_reps.values())
                obs_rows.append(
                    {
                        "ASSEMBLY_ACC": cell,
                        "genus": genus,
                        "repA": rep_a,
                        "repB": rep_b,
                        "same_plasmid": int(same_plasmid),
                    }
                )

    return pd.DataFrame(cell_rows), pd.DataFrame(obs_rows)


def summarize_global(obs: pd.DataFrame, min_cell: int) -> pd.DataFrame:
    rows = []
    grouped = obs.groupby(["repA", "repB"], sort=False)["same_plasmid"]
    for (rep_a, rep_b), vals in grouped:
        n = int(vals.size)
        if n < min_cell:
            continue
        k = int(vals.sum())
        rate = k / n
        ci_low, ci_high = proportion_confint(k, n, alpha=0.05, method="beta")
        rows.append(
            {
                "repA": rep_a,
                "repB": rep_b,
                "n_same_cell": n,
                "n_cell_same_plasmid": k,
                "cointegration_rate": rate,
                "ci_low": ci_low,
                "ci_high": ci_high,
                "category": classify_rate(rate, ci_low, ci_high),
                "is_IncF_pair": is_incf_pair(rep_a, rep_b),
            }
        )
    return pd.DataFrame(rows)


def summarize_by_genus(obs: pd.DataFrame, min_genus_cell: int) -> pd.DataFrame:
    g = (
        obs.groupby(["repA", "repB", "genus"], sort=False)["same_plasmid"]
        .agg(n_same_cell_genus="size", n_cell_same_plasmid_genus="sum")
        .reset_index()
    )
    g = g[g["n_same_cell_genus"] >= min_genus_cell].copy()
    g["cointegration_rate_genus"] = g["n_cell_same_plasmid_genus"] / g["n_same_cell_genus"]
    cis = [
        proportion_confint(int(k), int(n), alpha=0.05, method="beta")
        for k, n in zip(g["n_cell_same_plasmid_genus"], g["n_same_cell_genus"])
    ]
    g["ci_low_genus"] = [x[0] for x in cis]
    g["ci_high_genus"] = [x[1] for x in cis]
    g["category_genus"] = [
        classify_rate(r, lo, hi)
        for r, lo, hi in zip(g["cointegration_rate_genus"], g["ci_low_genus"], g["ci_high_genus"])
    ]
    return g


def macro_summary(global_df: pd.DataFrame, by_genus: pd.DataFrame) -> pd.DataFrame:
    agg = (
        by_genus.groupby(["repA", "repB"], sort=False)
        .agg(
            n_genera_supported=("genus", "nunique"),
            macro_mean_rate=("cointegration_rate_genus", "mean"),
            macro_median_rate=("cointegration_rate_genus", "median"),
            macro_sd_rate=("cointegration_rate_genus", "std"),
            min_genus_rate=("cointegration_rate_genus", "min"),
            max_genus_rate=("cointegration_rate_genus", "max"),
            genus_support_sum=("n_same_cell_genus", "sum"),
        )
        .reset_index()
    )
    dom = by_genus.loc[
        by_genus.groupby(["repA", "repB"])["n_same_cell_genus"].idxmax(),
        ["repA", "repB", "genus", "n_same_cell_genus"],
    ].rename(columns={"genus": "dominant_genus", "n_same_cell_genus": "dominant_genus_n"})
    agg = agg.merge(dom, on=["repA", "repB"], how="left")
    agg["dominant_genus_fraction"] = agg["dominant_genus_n"] / agg["genus_support_sum"]
    out = global_df.merge(agg, on=["repA", "repB"], how="left")
    out["rate_delta_macro_minus_global"] = out["macro_mean_rate"] - out["cointegration_rate"]
    out["abs_rate_delta_macro_minus_global"] = out["rate_delta_macro_minus_global"].abs()
    out["dominant_genus_ge_0p8"] = out["dominant_genus_fraction"] >= 0.8
    return out


def balanced_subsampling(
    obs: pd.DataFrame,
    pairs: pd.DataFrame,
    cap: int,
    reps: int,
    seed: int,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    rng = np.random.default_rng(seed)
    cell_genus = obs[["ASSEMBLY_ACC", "genus"]].drop_duplicates()
    genus_to_cells = {g: sub["ASSEMBLY_ACC"].to_numpy() for g, sub in cell_genus.groupby("genus")}
    sampled_n = {g: min(cap, len(cells)) for g, cells in genus_to_cells.items()}

    pair_keys = list(zip(pairs["repA"], pairs["repB"]))
    pair_index = {key: i for i, key in enumerate(pair_keys)}
    obs_pair_idx = np.array([pair_index.get((a, b), -1) for a, b in zip(obs["repA"], obs["repB"])], dtype=int)
    keep_mask = obs_pair_idx >= 0
    obs2 = obs.loc[keep_mask, ["ASSEMBLY_ACC", "same_plasmid"]].copy()
    obs2["pair_idx"] = obs_pair_idx[keep_mask]

    per_rep_rows = []
    summary_accum = {
        key: {"n_reps_observed": 0, "rate_sum": 0.0, "rate_sq_sum": 0.0, "q_values": []}
        for key in pair_keys
    }

    for rep in range(reps):
        selected = []
        for genus, cells in genus_to_cells.items():
            n = sampled_n[genus]
            if n <= 0:
                continue
            selected.extend(rng.choice(cells, size=n, replace=False).tolist())
        selected = set(selected)
        sub = obs2[obs2["ASSEMBLY_ACC"].isin(selected)]
        if sub.empty:
            continue
        grp = sub.groupby("pair_idx")["same_plasmid"].agg(n="size", k="sum")
        for idx, row in grp.iterrows():
            key = pair_keys[int(idx)]
            n = int(row["n"])
            k = int(row["k"])
            rate = k / n if n else np.nan
            acc = summary_accum[key]
            acc["n_reps_observed"] += 1
            acc["rate_sum"] += rate
            acc["rate_sq_sum"] += rate * rate
            acc["q_values"].append(rate)
        per_rep_rows.append(
            {
                "replicate": rep,
                "n_cells_sampled": len(selected),
                "n_pair_observations": int(len(sub)),
                "n_pairs_observed": int(grp.shape[0]),
            }
        )

    rows = []
    for rep_a, rep_b in pair_keys:
        acc = summary_accum[(rep_a, rep_b)]
        m = acc["n_reps_observed"]
        vals = np.array(acc["q_values"], dtype=float)
        rows.append(
            {
                "repA": rep_a,
                "repB": rep_b,
                "subsample_reps_observed": m,
                "subsample_mean_rate": float(vals.mean()) if m else np.nan,
                "subsample_sd_rate": float(vals.std(ddof=1)) if m > 1 else np.nan,
                "subsample_q025": float(np.quantile(vals, 0.025)) if m else np.nan,
                "subsample_q500": float(np.quantile(vals, 0.5)) if m else np.nan,
                "subsample_q975": float(np.quantile(vals, 0.975)) if m else np.nan,
            }
        )
    return pd.DataFrame(rows), pd.DataFrame(per_rep_rows)


def write_tables(args, global_df, by_genus, macro_df, subsample_df, repstats, cells):
    tables = args.outdir / "tables"
    tables.mkdir(parents=True, exist_ok=True)

    global_df.to_csv(tables / "global_conditional_cointegration_recomputed.tsv", sep="\t", index=False)
    by_genus.to_csv(tables / "conditional_cointegration_by_genus_min_support.tsv", sep="\t", index=False)
    macro_df.to_csv(tables / "per_pair_support_and_genus_balance.tsv", sep="\t", index=False)
    subsample_df.to_csv(tables / "balanced_subsampling_pair_summary.tsv", sep="\t", index=False)
    repstats.to_csv(tables / "balanced_subsampling_replicate_stats.tsv", sep="\t", index=False)
    cells.to_csv(tables / "cell_level_composition.tsv", sep="\t", index=False)

    combined = macro_df.merge(subsample_df, on=["repA", "repB"], how="left")
    combined["subsample_delta_mean_minus_global"] = combined["subsample_mean_rate"] - combined["cointegration_rate"]
    combined["abs_subsample_delta_mean_minus_global"] = combined["subsample_delta_mean_minus_global"].abs()
    combined.to_csv(tables / "per_pair_rebalanced_summary.tsv", sep="\t", index=False)

    # Summary tables.
    rows = []
    for label, mask in {
        "all_pairs": np.ones(len(combined), dtype=bool),
        "incF_pairs": combined["is_IncF_pair"].fillna(False).to_numpy(),
        "non_incF_pairs": ~combined["is_IncF_pair"].fillna(False).to_numpy(),
        "multi_genus_pairs": combined["n_genera_supported"].fillna(0).to_numpy() >= 2,
        "dominant_genus_ge_0p8": combined["dominant_genus_ge_0p8"].fillna(False).to_numpy(),
    }.items():
        sub = combined.loc[mask].copy()
        rows.append(
            {
                "group": label,
                "n_pairs": len(sub),
                "sum_n_same_cell": int(sub["n_same_cell"].sum()) if len(sub) else 0,
                "median_global_rate": sub["cointegration_rate"].median(),
                "median_macro_mean_rate": sub["macro_mean_rate"].median(),
                "median_abs_macro_delta": sub["abs_rate_delta_macro_minus_global"].median(),
                "median_abs_subsample_delta": sub["abs_subsample_delta_mean_minus_global"].median(),
                "n_strong_cointegration_global": int((sub["category"] == "STRONG_COINTEGRATION").sum()),
                "n_strong_repulsion_global": int((sub["category"] == "STRONG_REPULSION").sum()),
            }
        )
    pd.DataFrame(rows).to_csv(tables / "preliminary_summary_by_pair_group.tsv", sep="\t", index=False)

    genus_summary = (
        by_genus.groupby("genus")
        .agg(
            n_pair_genus_rows=("repA", "size"),
            n_unique_pairs=("repA", lambda x: len(set(zip(x, by_genus.loc[x.index, "repB"])))),
            sum_n_same_cell=("n_same_cell_genus", "sum"),
            median_rate=("cointegration_rate_genus", "median"),
        )
        .reset_index()
        .sort_values("sum_n_same_cell", ascending=False)
    )
    genus_summary.to_csv(tables / "genus_support_summary.tsv", sep="\t", index=False)

    cell_summary = (
        cells.groupby("genus")
        .agg(
            n_cells=("ASSEMBLY_ACC", "nunique"),
            n_cells_with_IncF=("has_IncF", "sum"),
            median_plasmids_with_replicon=("n_plasmids_with_replicon", "median"),
            median_replicon_types=("n_replicon_types", "median"),
        )
        .reset_index()
        .sort_values("n_cells", ascending=False)
    )
    cell_summary["frac_cells_with_IncF"] = cell_summary["n_cells_with_IncF"] / cell_summary["n_cells"]
    cell_summary.to_csv(tables / "cell_composition_by_genus.tsv", sep="\t", index=False)

    correlation_rows = []
    for comparison, column in (
        ("genus_macro_mean", "macro_mean_rate"),
        ("host_balanced_subsampling", "subsample_mean_rate"),
    ):
        plot = combined.dropna(subset=["cointegration_rate", column])
        pear = stats.pearsonr(plot["cointegration_rate"], plot[column])
        spear = stats.spearmanr(plot["cointegration_rate"], plot[column])
        correlation_rows.append({
            "comparison": comparison,
            "n_pairs": len(plot),
            "pearson_r": pear.statistic,
            "pearson_p": pear.pvalue,
            "spearman_rho": spear.statistic,
            "spearman_p": spear.pvalue,
        })
    pd.DataFrame(correlation_rows).to_csv(
        tables / "rebalancing_correlation_statistics.tsv", sep="\t", index=False
    )

    return combined


def main() -> None:
    args = parse_args()
    for sub in ["tables", "logs"]:
        (args.outdir / sub).mkdir(parents=True, exist_ok=True)

    print(f"input_dir={args.input_dir}")
    print(f"outdir={args.outdir}")
    print(f"min_cell={args.min_cell}")
    print(f"min_genus_cell={args.min_genus_cell}")
    print(f"subsample_cap={args.subsample_cap}")
    print(f"subsample_reps={args.subsample_reps}")
    print(f"seed={args.seed}")

    raw = read_cell_plasmid_replicons(args.input_dir)
    cells, obs = build_cell_records(raw)
    print(f"typed_cells={len(cells)}")
    print(f"pair_cell_observations={len(obs)}")
    print(f"unique_pairs_raw={obs[['repA','repB']].drop_duplicates().shape[0]}")

    global_df = summarize_global(obs, args.min_cell)
    by_genus = summarize_by_genus(obs, args.min_genus_cell)
    macro_df = macro_summary(global_df, by_genus)
    subsample_df, repstats = balanced_subsampling(
        obs=obs,
        pairs=global_df[["repA", "repB"]],
        cap=args.subsample_cap,
        reps=args.subsample_reps,
        seed=args.seed,
    )
    combined = write_tables(args, global_df, by_genus, macro_df, subsample_df, repstats, cells)

    print(f"global_pairs={len(global_df)}")
    print(f"by_genus_rows={len(by_genus)}")
    print(f"combined_pairs={len(combined)}")
    print("done")


if __name__ == "__main__":
    main()
