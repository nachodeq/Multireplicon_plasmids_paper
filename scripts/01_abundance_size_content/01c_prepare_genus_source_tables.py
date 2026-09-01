#!/usr/bin/env python3
"""Prepare publication-ready source data for genus prevalence figures."""

from pathlib import Path
import argparse

import numpy as np
import pandas as pd
from scipy.stats import beta


FIGURE_1A_GENERA = [
    "Klebsiella",
    "Enterobacter",
    "Escherichia",
    "Staphylococcus",
    "Salmonella",
    "Enterococcus",
]


def clopper_pearson(successes: int, total: int, alpha: float = 0.05) -> tuple[float, float]:
    """Return an exact binomial confidence interval as percentages."""
    low = 0.0 if successes == 0 else beta.ppf(alpha / 2, successes, total - successes + 1)
    high = 1.0 if successes == total else beta.ppf(1 - alpha / 2, successes + 1, total - successes)
    return 100 * low, 100 * high


def summarize(df: pd.DataFrame) -> pd.DataFrame:
    rows = []
    for genus, group in df.groupby("host_genus", sort=False):
        n_total = len(group)
        counts = group["n_replicons"].value_counts()
        n_rep1 = int(counts.get(1, 0))
        n_rep2 = int(counts.get(2, 0))
        n_rep3 = int(counts.get(3, 0))
        n_rep4plus = int((group["n_replicons"] >= 4).sum())
        n_multi = n_total - n_rep1
        ci_low, ci_high = clopper_pearson(n_multi, n_total)
        rows.append(
            {
                "genus": genus,
                "n_total": n_total,
                "n_single_replicon": n_rep1,
                "n_multireplicon": n_multi,
                "pct_multireplicon": 100 * n_multi / n_total,
                "multireplicon_CI95_low": ci_low,
                "multireplicon_CI95_high": ci_high,
                "n_1_replicon": n_rep1,
                "n_2_replicons": n_rep2,
                "n_3_replicons": n_rep3,
                "n_4plus_replicons": n_rep4plus,
                "pct_1_replicon": 100 * n_rep1 / n_total,
                "pct_2_replicons": 100 * n_rep2 / n_total,
                "pct_3_replicons": 100 * n_rep3 / n_total,
                "pct_4plus_replicons": 100 * n_rep4plus / n_total,
            }
        )
    summary = pd.DataFrame(rows).sort_values(
        ["n_total", "genus"], ascending=[False, True], ignore_index=True
    )
    summary.insert(1, "rank_by_n_total", np.arange(1, len(summary) + 1))
    summary.insert(2, "selected_for_Figure_1a", summary["genus"].isin(FIGURE_1A_GENERA))
    return summary


def to_long(summary: pd.DataFrame) -> pd.DataFrame:
    categories = [
        ("1 replicon", "n_1_replicon", "pct_1_replicon"),
        ("2 replicons", "n_2_replicons", "pct_2_replicons"),
        ("3 replicons", "n_3_replicons", "pct_3_replicons"),
        ("4+ replicons", "n_4plus_replicons", "pct_4plus_replicons"),
    ]
    rows = []
    for _, record in summary.iterrows():
        for order, (category, count_col, pct_col) in enumerate(categories, start=1):
            rows.append(
                {
                    "genus": record["genus"],
                    "rank_by_n_total": record["rank_by_n_total"],
                    "selected_for_Figure_1a": record["selected_for_Figure_1a"],
                    "n_total": record["n_total"],
                    "replicon_category": category,
                    "replicon_category_order": order,
                    "n_plasmids": record[count_col],
                    "percentage_of_genus_plasmids": record[pct_col],
                }
            )
    return pd.DataFrame(rows)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model-table", required=True,
                        help="Clean table produced by 01b_source_adjusted_glm.py.")
    parser.add_argument("--outdir", required=True)
    args = parser.parse_args()
    out = Path(args.outdir)
    out.mkdir(parents=True, exist_ok=True)
    df = pd.read_csv(
        args.model_table, sep="\t",
        usecols=["host_genus", "n_replicons", "source_model"],
    )
    df["n_replicons"] = pd.to_numeric(df["n_replicons"], errors="raise").astype(int)
    summary = summarize(df)
    overall_n = len(df)
    overall_multi = int((df["n_replicons"] >= 2).sum())
    overall_pct = 100 * overall_multi / overall_n

    top25 = summary.head(25).copy()
    selected = summary.set_index("genus").loc[FIGURE_1A_GENERA].reset_index()
    for table in (top25, selected):
        table["rank_by_pct_multireplicon_within_table"] = (
            table["pct_multireplicon"]
            .rank(method="first", ascending=False)
            .astype(int)
        )
        table["overall_pct_multireplicon_reference"] = overall_pct
    selected["figure_order"] = np.arange(1, len(selected) + 1)
    selected = selected[
        ["figure_order"] + [column for column in selected.columns if column != "figure_order"]
    ]

    selected.to_csv(
        out / "Figure_1a_selected_genera_multireplicon_source_data.tsv",
        sep="\t",
        index=False,
    )
    top25.to_csv(
        out / "Supplementary_top25_genera_multireplicon_source_data.tsv",
        sep="\t",
        index=False,
    )
    to_long(selected).to_csv(
        out / "Figure_1a_selected_genera_replicon_categories_long.tsv",
        sep="\t",
        index=False,
    )
    to_long(top25).to_csv(
        out / "Supplementary_top25_genera_replicon_categories_long.tsv",
        sep="\t",
        index=False,
    )
    overall_ci_low, overall_ci_high = clopper_pearson(overall_multi, overall_n)
    pd.DataFrame(
        [
            {
                "n_total": overall_n,
                "n_single_replicon": overall_n - overall_multi,
                "n_multireplicon": overall_multi,
                "pct_multireplicon": overall_pct,
                "multireplicon_CI95_low": overall_ci_low,
                "multireplicon_CI95_high": overall_ci_high,
            }
        ]
    ).to_csv(
        out / "Overall_multireplicon_prevalence_source_data.tsv",
        sep="\t",
        index=False,
    )
    genus_source = (
        df.assign(multireplicon=(df["n_replicons"] >= 2).astype(int))
        .groupby(["host_genus", "source_model"], as_index=False)
        .agg(n_total=("multireplicon", "size"), n_multireplicon=("multireplicon", "sum"))
        .rename(columns={"source_model": "source"})
    )
    genus_source["pct_multireplicon"] = (
        100 * genus_source["n_multireplicon"] / genus_source["n_total"]
    )
    genus_source.to_csv(
        out / "Supplementary_genus_by_source_multireplicon.tsv",
        sep="\t", index=False,
    )


if __name__ == "__main__":
    main()
