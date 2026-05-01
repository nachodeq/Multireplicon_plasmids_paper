#!/usr/bin/env python3
"""
Section 1 analysis for Figure 1 and Supplementary Figures 1–3.

This script does NOT export final figures. It generates the clean tables and
statistical summaries needed for:

Figure 1a:
- Multireplicon prevalence by genus.

Figure 1b:
- Plasmid size distribution by number of replicons.

Figure 1c:
- Plasmid size vs number of replicons, global Spearman correlation.

Figure 1d:
- Observed vs expected additive plasmid length.

Figure 1e:
- Proportion of plasmids carrying AMR, metal/biocide, or virulence genes.
- Fisher exact tests, single-replicon vs multi-replicon.

Figure 1f:
- AMR gene density by class, genes/kb.
- Mann–Whitney U tests, single-replicon vs multi-replicon.

Supplementary Figure 1:
- Plasmid size distributions by number of replicons across genera.

Supplementary Figure 2:
- Plasmid size vs number of replicons across genera, Spearman correlations.

Supplementary Figure 3:
- Metal/biocide and virulence gene density by class.
- Top 5 classes by abundance in multi-replicon plasmids + Other.
- Mann–Whitney U tests with FDR correction.

Main input:
- Supplementary_Dataset_1.xlsx with:
    plasmid_id, n_replicons, cluster_id, cluster_size, length_bp

Optional inputs:
- Metadata table, e.g. meta/nuccore.csv, with NUCCORE_ACC and either genus or description.
- Typing table, e.g. meta/typing.csv, with NUCCORE_ACC and rep_type(s).
- Functional annotation table, e.g. Plasmids_data_ok.tsv, with:
    NUCCORE_ACC, group, class, drug_class
  and optionally:
    size, Replicon_Status, replicon_status_2, rep_type(s)

No plotting is performed here.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path
from typing import Iterable

import numpy as np
import pandas as pd
from scipy.stats import fisher_exact, mannwhitneyu, spearmanr
from statsmodels.stats.multitest import multipletests


# ============================================================
# I/O AND NORMALIZATION
# ============================================================

def read_table(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    suffix = "".join(path.suffixes).lower()
    if suffix.endswith(".xlsx") or suffix.endswith(".xls"):
        return pd.read_excel(path)
    if suffix.endswith(".csv"):
        return pd.read_csv(path)
    return pd.read_csv(path, sep="\t")


def write_table(df: pd.DataFrame, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if df is None or df.empty:
        print(f"[skip] {path.name}: no data")
        return
    df.to_csv(path, sep="\t", index=False)
    print(f"[out] {path}")


def normalize_id(x: object) -> str:
    s = str(x).strip().split("/")[-1]
    for ext in (".fasta", ".fa", ".fna", ".faa", ".gb", ".gbk", ".csv", ".tsv", ".xlsx", ".gz"):
        if s.endswith(ext):
            s = s[: -len(ext)]
    return s


def standardize_columns(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out.columns = out.columns.str.strip()
    return out


def lower_columns(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out.columns = out.columns.str.strip().str.lower()
    return out


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower_map = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower_map:
            return lower_map[c.lower()]
    return None


def parse_replicons(x: object) -> list[str]:
    if pd.isna(x):
        return []
    s = str(x).strip()
    if not s or s.lower() in {"nan", "none"}:
        return []
    return sorted({r.strip() for r in s.split(",") if r.strip()})


def clean_genus_from_description(x: object) -> str | float:
    if pd.isna(x):
        return np.nan
    s = str(x).strip()
    if not s:
        return np.nan
    s = re.sub(r"\s*\([^)]*\)\s*$", "", s)
    tokens = s.split()
    return tokens[0].capitalize() if tokens else np.nan


def add_replicon_status(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["n_replicons"] = pd.to_numeric(df["n_replicons"], errors="coerce")
    df["length_bp"] = pd.to_numeric(df["length_bp"], errors="coerce")
    df = df.dropna(subset=["plasmid_id", "n_replicons", "length_bp"])
    df["n_replicons"] = df["n_replicons"].astype(int)
    df["replicon_status"] = np.where(
        df["n_replicons"] >= 2,
        "Multi-replicon",
        "Single-replicon",
    )
    return df


# ============================================================
# INPUT LOADERS
# ============================================================

def load_supplementary_dataset(path: str | Path) -> pd.DataFrame:
    df = standardize_columns(read_table(path))

    required = {"plasmid_id", "n_replicons", "cluster_id", "cluster_size", "length_bp"}
    missing = required - set(df.columns)
    if missing:
        raise SystemExit(f"Supplementary Dataset 1 is missing columns: {sorted(missing)}")

    df = df.copy()
    df["plasmid_id"] = df["plasmid_id"].map(normalize_id)
    return add_replicon_status(df)


def load_metadata(path: str | Path) -> pd.DataFrame:
    meta = standardize_columns(read_table(path))

    id_col = first_existing(
        meta.columns,
        ["plasmid_id", "NUCCORE_ACC", "nuccore_acc", "accession", "acc", "id"],
    )
    if id_col is None:
        raise SystemExit("Metadata table needs plasmid_id or NUCCORE_ACC column.")

    genus_col = first_existing(
        meta.columns,
        ["genus", "GENUS", "Genus", "Genus_from_description"],
    )
    desc_col = first_existing(
        meta.columns,
        ["NUCCORE_Description", "description", "Description", "title"],
    )

    out = pd.DataFrame()
    out["plasmid_id"] = meta[id_col].map(normalize_id)

    if genus_col is not None:
        out["genus"] = (
            meta[genus_col]
            .replace("", np.nan)
            .astype(str)
            .str.strip()
            .str.capitalize()
        )
    elif desc_col is not None:
        out["genus"] = meta[desc_col].map(clean_genus_from_description)
    else:
        raise SystemExit("Metadata table needs genus or description column.")

    out = out.dropna(subset=["plasmid_id", "genus"])
    return out.drop_duplicates("plasmid_id")


def load_typing(path: str | Path) -> pd.DataFrame:
    typing = standardize_columns(read_table(path))

    id_col = first_existing(
        typing.columns,
        ["plasmid_id", "NUCCORE_ACC", "nuccore_acc", "accession", "acc", "id"],
    )
    rep_col = first_existing(
        typing.columns,
        ["rep_type(s)", "replicon_types", "rep_types", "replicons"],
    )

    if id_col is None or rep_col is None:
        raise SystemExit("Typing table needs plasmid id and replicon columns.")

    out = pd.DataFrame()
    out["plasmid_id"] = typing[id_col].map(normalize_id)
    out["replicon_types"] = typing[rep_col].astype(str)
    out["replicon_list"] = out["replicon_types"].map(parse_replicons)
    out["replicon_combo"] = out["replicon_list"].map(lambda xs: ",".join(xs))

    return out.drop_duplicates("plasmid_id")


def load_functional_table(path: str | Path) -> pd.DataFrame:
    df = lower_columns(read_table(path))

    id_col = first_existing(df.columns, ["nuccore_acc", "plasmid_id", "accession", "acc", "id"])
    if id_col is None:
        raise SystemExit("Functional table needs nuccore_acc or plasmid_id column.")

    if "group" not in df.columns:
        raise SystemExit("Functional table needs a group column.")

    out = df.copy()
    out["plasmid_id"] = out[id_col].map(normalize_id)

    # Standardize useful columns.
    if "size" in out.columns and "length_bp" not in out.columns:
        out["length_bp_from_functional"] = pd.to_numeric(out["size"], errors="coerce")

    if "replicon_status_2" in out.columns:
        out["replicon_status_from_functional"] = out["replicon_status_2"]
    elif "replicon_status" in out.columns:
        out["replicon_status_from_functional"] = out["replicon_status"]

    return out


# ============================================================
# FIGURE 1A–D AND SUPP FIGURES 1–2
# ============================================================

def overall_counts(master: pd.DataFrame) -> pd.DataFrame:
    n_total = len(master)
    n_multi = int((master["n_replicons"] >= 2).sum())
    n_three_plus = int((master["n_replicons"] >= 3).sum())

    return pd.DataFrame([{
        "n_total": n_total,
        "n_single_replicon": int((master["n_replicons"] == 1).sum()),
        "n_multi_replicon": n_multi,
        "pct_multi_replicon": 100 * n_multi / n_total if n_total else np.nan,
        "n_three_or_more_replicons": n_three_plus,
        "pct_three_or_more_replicons": 100 * n_three_plus / n_total if n_total else np.nan,
    }])


def prevalence_by_genus(master: pd.DataFrame) -> pd.DataFrame:
    if "genus" not in master.columns:
        return pd.DataFrame()

    rows = []
    for genus, sub in master.dropna(subset=["genus"]).groupby("genus"):
        n = len(sub)
        n_multi = int((sub["n_replicons"] >= 2).sum())
        n_three_plus = int((sub["n_replicons"] >= 3).sum())
        rows.append({
            "genus": genus,
            "n_plasmids": n,
            "n_multi_replicon": n_multi,
            "pct_multi_replicon": 100 * n_multi / n if n else np.nan,
            "n_three_or_more_replicons": n_three_plus,
            "pct_three_or_more_replicons": 100 * n_three_plus / n if n else np.nan,
        })

    return pd.DataFrame(rows).sort_values("pct_multi_replicon", ascending=False)


def size_distribution_table(master: pd.DataFrame) -> pd.DataFrame:
    cols = ["plasmid_id", "n_replicons", "replicon_status", "length_bp"]
    if "genus" in master.columns:
        cols.append("genus")
    return master[cols].copy()


def spearman_global(master: pd.DataFrame) -> pd.DataFrame:
    tmp = master[["n_replicons", "length_bp"]].dropna()
    rho, p = spearmanr(tmp["n_replicons"], tmp["length_bp"])
    return pd.DataFrame([{
        "comparison": "length_bp_vs_n_replicons",
        "n": int(tmp.shape[0]),
        "spearman_rho": rho,
        "p_value": p,
    }])


def spearman_by_genus(master: pd.DataFrame) -> pd.DataFrame:
    if "genus" not in master.columns:
        return pd.DataFrame()

    rows = []
    for genus, sub in master.dropna(subset=["genus"]).groupby("genus"):
        tmp = sub[["n_replicons", "length_bp"]].dropna()
        if tmp.shape[0] < 3 or tmp["n_replicons"].nunique() < 2:
            continue
        rho, p = spearmanr(tmp["n_replicons"], tmp["length_bp"])
        rows.append({
            "genus": genus,
            "n": int(tmp.shape[0]),
            "spearman_rho": rho,
            "p_value": p,
        })

    return pd.DataFrame(rows).sort_values("genus")


def length_additivity(master: pd.DataFrame) -> pd.DataFrame:
    required = {"genus", "replicon_list", "replicon_combo"}
    if not required.issubset(master.columns):
        return pd.DataFrame()

    df = master.dropna(subset=["genus"]).copy()
    df = df[df["replicon_list"].map(lambda xs: isinstance(xs, list) and len(xs) > 0)].copy()

    single = df[df["n_replicons"] == 1].copy()
    single["replicon"] = single["replicon_list"].map(lambda xs: xs[0] if len(xs) == 1 else np.nan)
    single = single.dropna(subset=["replicon"])

    baseline = (
        single.groupby(["genus", "replicon"])
        .agg(
            baseline_n=("plasmid_id", "nunique"),
            baseline_median_length_bp=("length_bp", "median"),
        )
        .reset_index()
    )
    baseline = baseline[baseline["baseline_n"] >= 10].copy()

    baseline_map = {
        (r.genus, r.replicon): r.baseline_median_length_bp
        for r in baseline.itertuples(index=False)
    }

    multi = df[df["n_replicons"] >= 2].copy()
    combo_support = (
        multi.groupby(["genus", "replicon_combo"])
        .size()
        .reset_index(name="combo_support")
    )
    multi = multi.merge(combo_support, on=["genus", "replicon_combo"], how="left")
    multi = multi[multi["combo_support"] >= 5].copy()

    rows = []
    for r in multi.itertuples(index=False):
        expected_parts = []
        missing_replicons = []

        for rep in r.replicon_list:
            key = (r.genus, rep)
            if key in baseline_map:
                expected_parts.append(float(baseline_map[key]))
            else:
                missing_replicons.append(rep)

        if missing_replicons:
            continue

        expected = float(np.sum(expected_parts))
        observed = float(r.length_bp)

        rows.append({
            "plasmid_id": r.plasmid_id,
            "genus": r.genus,
            "n_replicons": r.n_replicons,
            "replicon_combo": r.replicon_combo,
            "combo_support": r.combo_support,
            "observed_length_bp": observed,
            "expected_additive_length_bp": expected,
            "observed_over_expected": observed / expected if expected > 0 else np.nan,
            "delta_observed_minus_expected_bp": observed - expected,
        })

    return pd.DataFrame(rows)


# ============================================================
# FUNCTIONAL GENE LOGIC FROM NOTEBOOKS
# ============================================================

def is_amr_group(x: object) -> bool:
    """
    Notebook logic:
    - includes group entries split by ';'
    - AMR and AMR; Biocide count as AMR
    """
    if pd.isna(x):
        return False
    parts = [p.strip().lower() for p in str(x).split(";")]
    return "amr" in parts


def is_virulence_group(x: object) -> bool:
    return str(x).strip().lower() == "virulence genes"


def is_metal_biocide_group(x: object) -> bool:
    """
    Notebook logic:
    - Metal Tolerance
    - AMR; Biocide
    Also accepts generic Biocide-containing entries.
    """
    s = str(x).strip().lower()
    return s in {"metal tolerance", "amr; biocide"} or "biocide" in s


def clean_amr_classes(x: object) -> list[str]:
    """
    Notebook logic for AMR:
    - split class by '/'
    - remove Biocide
    """
    if pd.isna(x):
        return []
    parts = [p.strip() for p in str(x).split("/") if p.strip()]
    return [p for p in parts if p.lower() != "biocide"]


def clean_metal_biocide_class(x: object) -> str:
    """
    Notebook logic:
    - use drug_class
    - anything containing '/Biocides' or ending with Biocides becomes Biocides
    """
    if pd.isna(x):
        return ""
    s = str(x).strip()
    if not s:
        return ""
    if "/biocides" in s.lower() or s.lower().endswith("biocides"):
        return "Biocides"
    return s


def clean_virulence_class(x: object) -> str:
    """
    Notebook logic:
    - use drug_class as class.
    """
    if pd.isna(x):
        return ""
    return str(x).strip()


def build_functional_presence(master: pd.DataFrame, functional: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    """
    Figure 1e:
    Presence/absence per plasmid for AMR, metal/biocide, virulence,
    then Fisher exact test SR vs MR.
    """
    df = functional.copy()
    df["is_amr"] = df["group"].apply(is_amr_group)
    df["is_metal_biocide"] = df["group"].apply(is_metal_biocide_group)
    df["is_virulence"] = df["group"].apply(is_virulence_group)

    counts = (
        df.groupby("plasmid_id")
        .agg(
            N_AMR=("is_amr", "sum"),
            N_Metal_Biocide=("is_metal_biocide", "sum"),
            N_Virulence=("is_virulence", "sum"),
        )
        .reset_index()
    )

    plasmids = master[["plasmid_id", "replicon_status", "length_bp"]].copy()
    out = plasmids.merge(counts, on="plasmid_id", how="left")
    for col in ["N_AMR", "N_Metal_Biocide", "N_Virulence"]:
        out[col] = out[col].fillna(0).astype(int)

    out["AMR_present"] = out["N_AMR"] > 0
    out["Metal_Biocide_present"] = out["N_Metal_Biocide"] > 0
    out["Virulence_present"] = out["N_Virulence"] > 0

    summary_rows = []
    stats_rows = []

    tests = [
        ("AMR", "AMR_present"),
        ("Metal/Biocide", "Metal_Biocide_present"),
        ("Virulence", "Virulence_present"),
    ]

    for label, col in tests:
        for status, sub in out.groupby("replicon_status"):
            n = len(sub)
            n_positive = int(sub[col].sum())
            summary_rows.append({
                "feature": label,
                "replicon_status": status,
                "n_plasmids": n,
                "n_positive": n_positive,
                "pct_positive": 100 * n_positive / n if n else np.nan,
            })

        sr = out[out["replicon_status"] == "Single-replicon"]
        mr = out[out["replicon_status"] == "Multi-replicon"]

        sr_pos = int(sr[col].sum())
        sr_neg = int((~sr[col]).sum())
        mr_pos = int(mr[col].sum())
        mr_neg = int((~mr[col]).sum())

        # Keep the notebook orientation: [[SR pos, SR neg], [MR pos, MR neg]]
        odds_ratio, p_value = fisher_exact(
            [[sr_pos, sr_neg], [mr_pos, mr_neg]],
            alternative="two-sided",
        )

        stats_rows.append({
            "feature": label,
            "test": "Fisher exact test",
            "SR_positive": sr_pos,
            "SR_negative": sr_neg,
            "MR_positive": mr_pos,
            "MR_negative": mr_neg,
            "odds_ratio_SR_vs_MR_orientation": odds_ratio,
            "p_value": p_value,
        })

    return out, pd.DataFrame(summary_rows), pd.DataFrame(stats_rows)


def functional_density_by_class(
    master: pd.DataFrame,
    functional: pd.DataFrame,
    category: str,
    top_n: int | None,
) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Density analysis used for Figure 1f and Supplementary Figure 3.

    category:
    - AMR: group contains AMR, class column split by '/', Biocide removed, top 10 + Other by default.
    - Metal/Biocide: group is Metal Tolerance or AMR; Biocide, drug_class normalized.
    - Virulence: group is Virulence Genes, drug_class used as class.

    Returns:
    - long table with one row per plasmid x class
    - stats table with Mann–Whitney U and FDR
    """
    df = functional.copy()

    if category == "AMR":
        class_source_col = "class"
        if class_source_col not in df.columns:
            raise SystemExit("Functional table needs 'class' column for AMR analysis.")
        sub = df[df["group"].apply(is_amr_group)].copy()
        sub["class_clean_list"] = sub[class_source_col].apply(clean_amr_classes)
        sub = sub.explode("class_clean_list")
        sub = sub.rename(columns={"class_clean_list": "class_clean"})

    elif category == "Metal/Biocide":
        class_source_col = "drug_class"
        if class_source_col not in df.columns:
            raise SystemExit("Functional table needs 'drug_class' column for metal/biocide analysis.")
        sub = df[df["group"].apply(is_metal_biocide_group)].copy()
        sub["class_clean"] = sub[class_source_col].apply(clean_metal_biocide_class)

    elif category == "Virulence":
        class_source_col = "drug_class"
        if class_source_col not in df.columns:
            raise SystemExit("Functional table needs 'drug_class' column for virulence analysis.")
        sub = df[df["group"].apply(is_virulence_group)].copy()
        sub["class_clean"] = sub[class_source_col].apply(clean_virulence_class)

    else:
        raise ValueError(f"Unknown category: {category}")

    sub = sub[sub["class_clean"].notna()].copy()
    sub["class_clean"] = sub["class_clean"].astype(str).str.strip()
    sub = sub[sub["class_clean"] != ""].copy()

    plasmids = master[["plasmid_id", "replicon_status", "length_bp"]].copy()

    if sub.empty:
        return pd.DataFrame(), pd.DataFrame()

    counts = (
        sub.groupby(["plasmid_id", "class_clean"])
        .size()
        .reset_index(name="n_genes")
    )

    if top_n is not None:
        # For AMR, notebook uses top classes globally.
        # For Supp Fig 3, manuscript says top classes ranked by abundance in multi-replicon plasmids.
        counts_with_status = counts.merge(
            plasmids[["plasmid_id", "replicon_status"]],
            on="plasmid_id",
            how="left",
        )

        if category in {"Metal/Biocide", "Virulence"}:
            ranking_source = counts_with_status[
                counts_with_status["replicon_status"] == "Multi-replicon"
            ]
        else:
            ranking_source = counts_with_status

        top_classes = (
            ranking_source.groupby("class_clean")["n_genes"]
            .sum()
            .sort_values(ascending=False)
            .head(top_n)
            .index
            .tolist()
        )

        counts["class_grouped"] = np.where(
            counts["class_clean"].isin(top_classes),
            counts["class_clean"],
            "Other",
        )

        counts = (
            counts.groupby(["plasmid_id", "class_grouped"])["n_genes"]
            .sum()
            .reset_index()
            .rename(columns={"class_grouped": "class_clean"})
        )

        all_classes = top_classes + (["Other"] if "Other" in counts["class_clean"].values else [])
    else:
        all_classes = sorted(counts["class_clean"].dropna().unique())

    # Complete base including zero counts for all plasmid x class combinations.
    base = (
        plasmids.assign(key=1)
        .merge(pd.DataFrame({"class_clean": all_classes, "key": 1}), on="key")
        .drop(columns="key")
    )

    density = (
        base.merge(counts, on=["plasmid_id", "class_clean"], how="left")
        .fillna({"n_genes": 0})
    )
    density["n_genes"] = density["n_genes"].astype(int)
    density["genes_per_kb"] = density["n_genes"] / (density["length_bp"] / 1000)
    density["category"] = category

    rows = []
    for cls in all_classes:
        tmp = density[density["class_clean"] == cls]

        sr = tmp.loc[tmp["replicon_status"] == "Single-replicon", "genes_per_kb"]
        mr = tmp.loc[tmp["replicon_status"] == "Multi-replicon", "genes_per_kb"]

        if len(sr) > 0 and len(mr) > 0:
            # Notebook orientation: mannwhitneyu(sr, mr), two-sided.
            u, p_value = mannwhitneyu(sr, mr, alternative="two-sided")
        else:
            u, p_value = np.nan, np.nan

        rows.append({
            "category": category,
            "class": cls,
            "test": "Mann-Whitney U",
            "Mean_SR": sr.mean(),
            "Median_SR": sr.median(),
            "N_SR": int(sr.shape[0]),
            "Mean_MR": mr.mean(),
            "Median_MR": mr.median(),
            "N_MR": int(mr.shape[0]),
            "U_stat": u,
            "p_value": p_value,
        })

    stats = pd.DataFrame(rows)

    if stats["p_value"].notna().any():
        valid = stats["p_value"].notna()
        stats.loc[valid, "p_FDR"] = multipletests(
            stats.loc[valid, "p_value"],
            method="fdr_bh",
        )[1]
    else:
        stats["p_FDR"] = np.nan

    stats["Significant_FDR_0.05"] = stats["p_FDR"] < 0.05
    stats["Significant_FDR_0.001"] = stats["p_FDR"] < 0.001

    return density, stats


# ============================================================
# MAIN
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(
        description="Generate Section 1 analysis tables and statistics."
    )

    ap.add_argument(
        "--supplementary-dataset",
        required=True,
        help="Supplementary_Dataset_1.xlsx/tsv/csv.",
    )
    ap.add_argument(
        "--outdir",
        required=True,
        help="Output directory for tables.",
    )
    ap.add_argument(
        "--metadata",
        default=None,
        help="Optional metadata table, e.g. meta/nuccore.csv.",
    )
    ap.add_argument(
        "--typing",
        default=None,
        help="Optional MOB-typer table, e.g. meta/typing.csv.",
    )
    ap.add_argument(
        "--functional-table",
        default=None,
        help="Optional functional table, e.g. Plasmids_data_ok.tsv.",
    )
    ap.add_argument(
        "--amr-top-n",
        type=int,
        default=10,
        help="Number of AMR classes to keep before grouping remaining as Other for Figure 1f.",
    )
    ap.add_argument(
        "--supp-top-n",
        type=int,
        default=5,
        help="Number of metal/biocide and virulence classes to keep before grouping remaining as Other.",
    )

    args = ap.parse_args()
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    master = load_supplementary_dataset(args.supplementary_dataset)

    if args.metadata:
        meta = load_metadata(args.metadata)
        master = master.merge(meta, on="plasmid_id", how="left")

    if args.typing:
        typing = load_typing(args.typing)
        master = master.merge(typing, on="plasmid_id", how="left")

    write_table(master, outdir / "section1_master_table.tsv")

    # Figure 1a–d and Supplementary Figures 1–2 inputs/stats.
    write_table(overall_counts(master), outdir / "fig1_overall_counts.tsv")
    write_table(prevalence_by_genus(master), outdir / "fig1a_prevalence_by_genus.tsv")
    write_table(size_distribution_table(master), outdir / "fig1b_size_distribution_table.tsv")
    write_table(spearman_global(master), outdir / "fig1c_spearman_global.tsv")
    write_table(length_additivity(master), outdir / "fig1d_length_additivity.tsv")
    write_table(size_distribution_table(master), outdir / "suppfig1_size_distribution_by_genus_table.tsv")
    write_table(spearman_by_genus(master), outdir / "suppfig2_spearman_by_genus.tsv")

    if not args.functional_table:
        print("[info] No functional table provided; skipping Figure 1e, Figure 1f, and Supplementary Figure 3.")
        return

    functional = load_functional_table(args.functional_table)

    # Keep only deduplicated plasmids from Supplementary Dataset 1.
    functional = functional[functional["plasmid_id"].isin(set(master["plasmid_id"]))].copy()
    write_table(functional, outdir / "section1_functional_table_deduplicated.tsv")

    # Figure 1e.
    presence_plasmids, presence_summary, fisher_stats = build_functional_presence(master, functional)
    write_table(presence_plasmids, outdir / "fig1e_functional_presence_by_plasmid.tsv")
    write_table(presence_summary, outdir / "fig1e_functional_presence_summary.tsv")
    write_table(fisher_stats, outdir / "fig1e_fisher_exact_tests.tsv")

    # Figure 1f: AMR density by class.
    amr_density, amr_stats = functional_density_by_class(
        master,
        functional,
        category="AMR",
        top_n=args.amr_top_n,
    )
    write_table(amr_density, outdir / "fig1f_amr_density_by_class_long.tsv")
    write_table(amr_stats, outdir / "fig1f_amr_density_by_class_stats.tsv")

    # Supplementary Figure 3: metal/biocide and virulence density by class.
    metal_density, metal_stats = functional_density_by_class(
        master,
        functional,
        category="Metal/Biocide",
        top_n=args.supp_top_n,
    )
    vir_density, vir_stats = functional_density_by_class(
        master,
        functional,
        category="Virulence",
        top_n=args.supp_top_n,
    )

    supp_density = pd.concat(
        [x for x in [metal_density, vir_density] if not x.empty],
        ignore_index=True,
    ) if (not metal_density.empty or not vir_density.empty) else pd.DataFrame()

    supp_stats = pd.concat(
        [x for x in [metal_stats, vir_stats] if not x.empty],
        ignore_index=True,
    ) if (not metal_stats.empty or not vir_stats.empty) else pd.DataFrame()

    write_table(metal_density, outdir / "suppfig3_metal_biocide_density_by_class_long.tsv")
    write_table(metal_stats, outdir / "suppfig3_metal_biocide_density_by_class_stats.tsv")
    write_table(vir_density, outdir / "suppfig3_virulence_density_by_class_long.tsv")
    write_table(vir_stats, outdir / "suppfig3_virulence_density_by_class_stats.tsv")
    write_table(supp_density, outdir / "suppfig3_density_by_class_long.tsv")
    write_table(supp_stats, outdir / "suppfig3_density_by_class_stats.tsv")

    if "genus" not in master.columns:
        print("[warn] No metadata/genus provided; Figure 1a and genus-stratified summaries are empty.")

    if not {"replicon_list", "replicon_combo"}.issubset(master.columns):
        print("[warn] No typing/replicon identities provided; Figure 1d additivity is empty.")


if __name__ == "__main__":
    main()
