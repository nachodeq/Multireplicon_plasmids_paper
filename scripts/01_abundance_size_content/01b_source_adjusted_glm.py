#!/usr/bin/env python3
"""Source-adjusted GLMs for multireplicon gene-content enrichment."""

import argparse
from pathlib import Path
import re
import warnings

import numpy as np
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.stats.multitest import multipletests


warnings.filterwarnings("ignore", category=RuntimeWarning)

OUT: Path
SD1: Path
PLASMIDS_DATA: Path

MIN_GENUS_N = 200
MIN_MOBILITY_N = 20

OUTCOMES = [
    "AMR_presence",
    "metal_biocide_presence",
    "virulence_presence",
]

OUTCOME_LABELS = {
    "AMR_presence": "AMR genes",
    "metal_biocide_presence": "Metal/biocide resistance genes",
    "virulence_presence": "Virulence genes",
}


def normalize_id(value):
    if pd.isna(value):
        return np.nan
    text = str(value).strip().split("/")[-1]
    for ext in (".fasta", ".fa", ".fna", ".faa", ".gb", ".gbk", ".csv", ".tsv", ".xlsx", ".gz"):
        if text.endswith(ext):
            text = text[: -len(ext)]
    return text


def clean_text(value):
    if pd.isna(value):
        return np.nan
    text = re.sub(r"\s+", " ", str(value).strip())
    if not text or text.lower() in {"nan", "none", "null"}:
        return np.nan
    return text


def clean_genus(value):
    text = clean_text(value)
    if pd.isna(text):
        return np.nan
    tokens = text.split()
    return np.nan if not tokens else tokens[0].capitalize()


def clean_mobility(value):
    text = clean_text(value)
    if pd.isna(text):
        return np.nan
    return text.lower().replace("-", "_").replace(" ", "_")


def first_nonempty(series):
    for value in series:
        if pd.notna(value) and str(value).strip() not in {"", "nan", "None"}:
            return value
    return np.nan


def load_base():
    base = pd.read_excel(SD1, sheet_name="selected_representatives")
    base.columns = base.columns.str.strip()
    base["plasmid_id"] = base["plasmid_id"].map(normalize_id)
    base["n_replicons"] = pd.to_numeric(base["n_replicons"], errors="coerce")
    base["length_bp"] = pd.to_numeric(base["length_bp"], errors="coerce")
    base = base.dropna(subset=["plasmid_id", "n_replicons", "length_bp"]).copy()
    base = base[base["length_bp"] > 0].copy()
    base["multireplicon_status"] = (base["n_replicons"] >= 2).astype(int)
    base["replicon_status"] = np.where(base["multireplicon_status"].eq(1), "Multi-replicon", "Single-replicon")
    base["log10_length"] = np.log10(base["length_bp"])
    return base


def load_metadata():
    sheet1 = pd.read_excel(PLASMIDS_DATA, sheet_name="Sheet1")
    summary = pd.read_excel(PLASMIDS_DATA, sheet_name="Plasmids_genes_summary")
    sheet1.columns = sheet1.columns.str.strip()
    summary.columns = summary.columns.str.strip()

    metadata = sheet1[
        [
            "NUCCORE_ACC",
            "TAXONOMY.TAXONOMY_taxon_name",
            "MOB.predicted_mobility",
            "rep_type(s)",
            "sources",
        ]
    ].copy()
    metadata["plasmid_id"] = metadata["NUCCORE_ACC"].map(normalize_id)
    metadata["host_taxon_name"] = metadata["TAXONOMY.TAXONOMY_taxon_name"].map(clean_text)
    metadata["host_genus"] = metadata["host_taxon_name"].map(clean_genus)
    metadata["predicted_mobility"] = metadata["MOB.predicted_mobility"].map(clean_mobility)
    metadata["replicon_types"] = metadata["rep_type(s)"].map(clean_text)
    metadata["source"] = metadata["sources"].map(clean_text)
    metadata = (
        metadata[
            [
                "plasmid_id",
                "host_taxon_name",
                "host_genus",
                "predicted_mobility",
                "replicon_types",
                "source",
            ]
        ]
        .dropna(subset=["plasmid_id"])
        .groupby("plasmid_id", as_index=False)
        .agg(first_nonempty)
    )

    features = summary[["NUCCORE_ACC", "N_AMR", "N_Virulence", "N_Metal_Biocide"]].copy()
    features["plasmid_id"] = features["NUCCORE_ACC"].map(normalize_id)
    for col in ["N_AMR", "N_Virulence", "N_Metal_Biocide"]:
        features[col] = pd.to_numeric(features[col], errors="coerce").fillna(0).astype(int)
    features = (
        features.dropna(subset=["plasmid_id"])
        .groupby("plasmid_id", as_index=False)
        .agg({"N_AMR": "max", "N_Virulence": "max", "N_Metal_Biocide": "max"})
    )
    features["AMR_presence"] = (features["N_AMR"] > 0).astype(int)
    features["metal_biocide_presence"] = (features["N_Metal_Biocide"] > 0).astype(int)
    features["virulence_presence"] = (features["N_Virulence"] > 0).astype(int)

    return metadata, features


def build_model_df():
    base = load_base()
    metadata, features = load_metadata()
    df = base.merge(metadata, on="plasmid_id", how="left").merge(features, on="plasmid_id", how="left")

    for col in ["N_AMR", "N_Virulence", "N_Metal_Biocide"]:
        df[col] = df[col].fillna(0).astype(int)
    for col in OUTCOMES:
        df[col] = df[col].fillna(0).astype(int)

    df["host_genus"] = df["host_genus"].map(clean_text)
    df["predicted_mobility"] = df["predicted_mobility"].map(clean_mobility)
    df["source"] = df["source"].map(clean_text)

    df.to_csv(OUT / "model_df_raw_with_source.tsv", sep="\t", index=False)

    model_df = df[
        df["log10_length"].notna()
        & df["host_genus"].notna()
        & df["predicted_mobility"].notna()
        & df["source"].notna()
    ].copy()

    common_genera = model_df["host_genus"].value_counts().loc[lambda s: s >= MIN_GENUS_N].index
    model_df["host_genus_model"] = np.where(model_df["host_genus"].isin(common_genera), model_df["host_genus"], "Other")

    common_mobility = model_df["predicted_mobility"].value_counts().loc[lambda s: s >= MIN_MOBILITY_N].index
    model_df["predicted_mobility_model"] = np.where(
        model_df["predicted_mobility"].isin(common_mobility),
        model_df["predicted_mobility"],
        "other_or_unknown",
    )

    model_df["source_model"] = model_df["source"]
    model_df.to_csv(OUT / "model_df_clean_for_source_adjusted_GLM.tsv", sep="\t", index=False)
    return model_df


def fit_glm(df, outcome, model_name, formula):
    fit = smf.glm(formula=formula, data=df, family=sm.families.Binomial()).fit(maxiter=500)
    conf = fit.conf_int()
    pseudo_r2 = 1 - (fit.llf / fit.llnull)
    return pd.DataFrame(
        {
            "model": model_name,
            "formula": formula,
            "outcome": outcome,
            "term": fit.params.index,
            "coef": fit.params.values,
            "OR": np.exp(fit.params.values),
            "CI_low": np.exp(conf[0].values),
            "CI_high": np.exp(conf[1].values),
            "p_value": fit.pvalues.values,
            "n": int(fit.nobs),
            "aic": fit.aic,
            "pseudo_R2": pseudo_r2,
            "converged": bool(fit.converged),
        }
    )


def add_fdr(results):
    main = results[results["term"] == "multireplicon_status"].copy()
    main["p_adj_FDR_within_model"] = np.nan
    for model_name in main["model"].dropna().unique():
        mask = main["model"].eq(model_name) & main["p_value"].notna()
        if mask.sum():
            main.loc[mask, "p_adj_FDR_within_model"] = multipletests(main.loc[mask, "p_value"], method="fdr_bh")[1]
    return results.merge(
        main[["model", "outcome", "term", "p_adj_FDR_within_model"]],
        on=["model", "outcome", "term"],
        how="left",
    ), main


def format_p(value):
    if pd.isna(value):
        return "NA"
    if value < 0.001:
        return f"{value:.2e}"
    return f"{value:.3f}"


def format_or_ci(row):
    if pd.isna(row["OR"]):
        return "NA"
    return f"{row['OR']:.2f} ({row['CI_low']:.2f}-{row['CI_high']:.2f})"


def write_source_summary(df):
    summary = (
        df.groupby("source_model", as_index=False)
        .agg(
            n_plasmids=("plasmid_id", "size"),
            n_multireplicon=("multireplicon_status", "sum"),
            frac_multireplicon=("multireplicon_status", "mean"),
            amr_positive=("AMR_presence", "sum"),
            metal_biocide_positive=("metal_biocide_presence", "sum"),
            virulence_positive=("virulence_presence", "sum"),
        )
        .sort_values("n_plasmids", ascending=False)
    )
    summary["frac_multireplicon"] = summary["frac_multireplicon"].round(4)
    summary.to_csv(OUT / "source_distribution_summary.tsv", sep="\t", index=False)
    species_source = (
        df.groupby(["host_taxon_name", "source_model"], as_index=False)
        .agg(
            n_plasmids=("plasmid_id", "size"),
            n_multireplicon=("multireplicon_status", "sum"),
        )
        .rename(columns={"source_model": "source"})
        .sort_values("n_plasmids", ascending=False)
    )
    species_source["pct_multireplicon"] = (
        100 * species_source["n_multireplicon"] / species_source["n_plasmids"]
    )
    species_source.to_csv(
        OUT / "multireplicon_prevalence_by_species_and_source.tsv",
        sep="\t", index=False,
    )


def run_models(df):
    formulas = {
        "M0_unadjusted": "{outcome} ~ multireplicon_status",
        "M1_length": "{outcome} ~ multireplicon_status + log10_length",
        "M2_length_mobility_genus": (
            "{outcome} ~ multireplicon_status + log10_length "
            "+ C(predicted_mobility_model) + C(host_genus_model)"
        ),
        "M3_length_mobility_genus_source": (
            "{outcome} ~ multireplicon_status + log10_length "
            "+ C(predicted_mobility_model) + C(host_genus_model) + C(source_model)"
        ),
    }

    all_results = []
    for outcome in OUTCOMES:
        for model_name, template in formulas.items():
            formula = template.format(outcome=outcome)
            all_results.append(fit_glm(df, outcome, model_name, formula))

    results = pd.concat(all_results, ignore_index=True)
    results, main = add_fdr(results)
    results.to_csv(OUT / "all_GLM_source_adjusted_results_full.tsv", sep="\t", index=False)
    main.to_csv(OUT / "all_GLM_source_adjusted_main_effects.tsv", sep="\t", index=False)
    return main


def write_tables(main):
    pretty = main.copy()
    pretty["Outcome"] = pretty["outcome"].map(OUTCOME_LABELS)
    pretty["OR_95CI"] = pretty.apply(format_or_ci, axis=1)
    pretty["P_value"] = pretty["p_value"].map(format_p)
    pretty["FDR"] = pretty["p_adj_FDR_within_model"].map(format_p)
    pretty = pretty[
        ["model", "Outcome", "n", "OR_95CI", "P_value", "FDR", "pseudo_R2", "aic", "converged"]
    ]
    pretty.to_csv(OUT / "supplementary_table_source_adjusted_GLM_main_effects.tsv", sep="\t", index=False)

    main_m2 = main[main["model"].eq("M2_length_mobility_genus")].copy()
    main_m3 = main[main["model"].eq("M3_length_mobility_genus_source")].copy()
    compare = main_m2.merge(
        main_m3,
        on="outcome",
        suffixes=("_M2", "_M3"),
    )
    compare["Outcome"] = compare["outcome"].map(OUTCOME_LABELS)
    compare["M2_OR_95CI"] = compare.apply(
        lambda r: f"{r['OR_M2']:.2f} ({r['CI_low_M2']:.2f}-{r['CI_high_M2']:.2f})",
        axis=1,
    )
    compare["M3_OR_95CI"] = compare.apply(
        lambda r: f"{r['OR_M3']:.2f} ({r['CI_low_M3']:.2f}-{r['CI_high_M3']:.2f})",
        axis=1,
    )
    compare["delta_log_OR_source_added"] = compare["coef_M3"] - compare["coef_M2"]
    compare["delta_OR_source_added"] = compare["OR_M3"] - compare["OR_M2"]
    compare[
        ["Outcome", "n_M3", "M2_OR_95CI", "M3_OR_95CI", "delta_log_OR_source_added", "delta_OR_source_added"]
    ].to_csv(OUT / "source_adjustment_comparison_table.tsv", sep="\t", index=False)

    paper = main_m3.copy()
    paper["Outcome"] = paper["outcome"].map(OUTCOME_LABELS)
    paper["Adjusted OR for multireplicon status (95% CI)"] = paper.apply(format_or_ci, axis=1)
    paper["P value"] = paper["p_value"].map(format_p)
    paper["FDR"] = paper["p_adj_FDR_within_model"].map(format_p)
    paper = paper[
        ["Outcome", "n", "Adjusted OR for multireplicon status (95% CI)", "P value", "FDR", "pseudo_R2"]
    ]
    paper.to_csv(OUT / "paper_table_main_source_adjusted_GLM.tsv", sep="\t", index=False)

def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--supplementary-dataset", required=True,
                        help="Supplementary Dataset 1 workbook.")
    parser.add_argument("--plasmids-data", required=True,
                        help="Workbook containing metadata and gene-count sheets.")
    parser.add_argument("--outdir", required=True)
    parser.add_argument("--min-genus-n", type=int, default=200)
    parser.add_argument("--min-mobility-n", type=int, default=20)
    return parser.parse_args()


def main():
    global OUT, SD1, PLASMIDS_DATA, MIN_GENUS_N, MIN_MOBILITY_N
    args = parse_args()
    OUT = Path(args.outdir)
    SD1 = Path(args.supplementary_dataset)
    PLASMIDS_DATA = Path(args.plasmids_data)
    MIN_GENUS_N = args.min_genus_n
    MIN_MOBILITY_N = args.min_mobility_n
    OUT.mkdir(parents=True, exist_ok=True)
    df = build_model_df()
    write_source_summary(df)
    main_results = run_models(df)
    write_tables(main_results)
    paper = pd.read_csv(OUT / "paper_table_main_source_adjusted_GLM.tsv", sep="\t")
    print(paper.to_string(index=False))
    print(f"\nWrote outputs to {OUT}")


if __name__ == "__main__":
    main()
