#!/usr/bin/env python3
"""Source-adjusted binomial models for MOB-typer mobility components."""

import argparse
from pathlib import Path

import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
from statsmodels.stats.multitest import multipletests


def normalize_accession(value: str) -> str:
    value = str(value or "").strip()
    return value[3:] if value.startswith("NZ_") else value


def fit_binomial_glm(df: pd.DataFrame, outcome: str, model_name: str, formula_rhs: str) -> dict[str, object]:
    formula = f"{outcome} ~ {formula_rhs}"
    model = smf.glm(formula=formula, data=df, family=__import__("statsmodels.api").api.families.Binomial()).fit()
    term = "multireplicon_status"
    coef = model.params[term]
    ci_low, ci_high = model.conf_int().loc[term]
    return {
        "model": model_name,
        "outcome": outcome,
        "formula": formula,
        "n": int(model.nobs),
        "coef": coef,
        "OR": float(np.exp(coef)),
        "CI_low": float(np.exp(ci_low)),
        "CI_high": float(np.exp(ci_high)),
        "p_value": float(model.pvalues[term]),
        "aic": float(model.aic),
        "pseudo_R2": float(1 - model.deviance / model.null_deviance),
        "converged": bool(model.converged),
    }


def format_or(row: pd.Series) -> str:
    return f"{row['OR']:.2f} ({row['CI_low']:.2f}-{row['CI_high']:.2f})"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model-table", required=True,
                        help="Clean covariate table produced by 01b_source_adjusted_glm.py.")
    parser.add_argument("--mobility-features", required=True,
                        help="One row per plasmid with MOB-typer component-presence columns.")
    parser.add_argument("--outdir", required=True)
    args = parser.parse_args()
    out = Path(args.outdir)
    out.mkdir(parents=True, exist_ok=True)
    model_df = pd.read_csv(args.model_table, sep="\t", dtype=str).fillna("")
    mobility = pd.read_csv(args.mobility_features, sep="\t", dtype=str).fillna("")

    model_df["merge_key"] = model_df["plasmid_id"].map(normalize_accession)
    mobility["merge_key"] = mobility["plasmid_id"].map(normalize_accession)

    feature_cols = [
        "relaxase_present",
        "mpf_present",
        "orit_present",
        "relaxase_mpf_present",
        "relaxase_orit_present",
        "all_three_present",
    ]
    mobility = mobility.rename(columns={"predicted_mobility": "mobtyper_predicted_mobility"})
    keep_cols = ["merge_key", "mobtyper_predicted_mobility"] + feature_cols
    merged = model_df.merge(mobility[keep_cols], on="merge_key", how="left", validate="one_to_one")
    if merged[feature_cols].isna().any().any():
        missing = int(merged[feature_cols].isna().any(axis=1).sum())
        raise SystemExit(f"Missing mobility-feature rows after merge: {missing}")

    merged["multireplicon_status"] = pd.to_numeric(merged["multireplicon_status"], errors="raise")
    merged["log10_length"] = pd.to_numeric(merged["log10_length"], errors="raise")
    for col in feature_cols:
        merged[col] = pd.to_numeric(merged[col], errors="raise").astype(int)
    merged["predicted_conjugative"] = (merged["mobtyper_predicted_mobility"] == "conjugative").astype(int)

    outcomes = [
        "predicted_conjugative",
        "relaxase_present",
        "mpf_present",
        "orit_present",
        "relaxase_mpf_present",
        "relaxase_orit_present",
        "all_three_present",
    ]
    model_formulas = {
        "M0_unadjusted": "multireplicon_status",
        "M1_length": "multireplicon_status + log10_length",
        "M2_length_genus": "multireplicon_status + log10_length + C(host_genus_model)",
        "M3_length_genus_source": "multireplicon_status + log10_length + C(host_genus_model) + C(source_model)",
    }
    rows = [
        fit_binomial_glm(merged, outcome, model_name, rhs)
        for outcome in outcomes
        for model_name, rhs in model_formulas.items()
    ]
    results = pd.DataFrame(rows)
    results["FDR"] = np.nan
    for model_name, idx in results.groupby("model").groups.items():
        results.loc[idx, "FDR"] = multipletests(results.loc[idx, "p_value"], method="fdr_bh")[1]
    results["OR_95CI"] = results.apply(format_or, axis=1)
    results["p_value_fmt"] = results["p_value"].map(lambda x: f"{x:.2e}")
    results["FDR_fmt"] = results["FDR"].map(lambda x: f"{x:.2e}")

    results.to_csv(out / "adjusted_mobility_with_source_full.tsv", sep="\t", index=False)
    pretty_cols = ["model", "outcome", "n", "OR_95CI", "p_value_fmt", "FDR_fmt", "pseudo_R2", "aic", "converged"]
    results[pretty_cols].to_csv(out / "adjusted_mobility_with_source_pretty.tsv", sep="\t", index=False)

    main_m2 = results[results["model"].eq("M2_length_genus")].copy()
    main_m3 = results[results["model"].eq("M3_length_genus_source")].copy()
    compare = main_m2.merge(main_m3, on="outcome", suffixes=("_M2", "_M3"))
    compare["delta_OR_source_added"] = compare["OR_M3"] - compare["OR_M2"]
    compare["M2_OR_95CI"] = compare["OR_95CI_M2"]
    compare["M3_OR_95CI"] = compare["OR_95CI_M3"]
    compare[["outcome", "n_M3", "M2_OR_95CI", "M3_OR_95CI", "delta_OR_source_added"]].to_csv(
        out / "mobility_source_adjustment_comparison.tsv", sep="\t", index=False
    )
    print(f"Wrote source-adjusted mobility tables to {out}")


if __name__ == "__main__":
    main()
