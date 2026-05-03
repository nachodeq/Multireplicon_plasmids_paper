#!/usr/bin/env python3
"""
Section 4 analysis for Figure 4 and Supplementary Figure 7.

Manuscript section:
"Stable associations of replicons show signs of coevolution"

This script is intentionally narrow. It generates only the analysis tables/statistical
summaries needed for Figure 4 and Supplementary Figure 7. It does not export final figures.

It covers:

Figure 4b:
- Observed distribution of relative topological distances.
- Random null distribution for relative distances.
- Kolmogorov-Smirnov test observed vs null.

Figure 4c:
- QCV/CQV of relative topological distances by replicon pair.
- Random-null QCV distribution.
- One-sided Mann-Whitney U test: observed QCV < null QCV.

Figure 4e:
- Relationship between spacing variability and coevolution:
    QCV_rel vs Mantel r
- Spearman correlation.

Figure 4f:
- Optional paired comparison of Mantel r for the same replicon pairs in
  multireplicon plasmids vs separate single-replicon plasmids.

Supplementary Figure 7:
- Relationship between median relative distance and Mantel r.
- Spearman correlation.

Two usage modes are supported:

A) If replicon_distances.tsv already exists:
    python 04_section4_spacing_coevolution_analysis.py \
      --distances replicon_distances.tsv \
      --cointegration replicon_cointegration_conditional.csv \
      --mantel mantel_results.tsv \
      --outdir section4_outputs

B) If distances need to be computed from MOB-typer output:
    python 04_section4_spacing_coevolution_analysis.py \
      --mobtyper-dir rep_distances/mobtyper \
      --plasmid-replicons data/plasmid_replicons.tsv \
      --cointegration replicon_cointegration_conditional.csv \
      --mantel mantel_results.tsv \
      --outdir section4_outputs

Required input for distance computation:
- MOB-typer output directory containing:
    {plasmid_id}_analysis/replicon_blast_results.txt
    {plasmid_id}_summary.txt
- plasmid_replicons.tsv with at least:
    plasmid_id, size_bp

Required precomputed inputs:
- cointegration table from Section 3, with:
    repA, repB, cointegration_rate
- Mantel table, with pair identifiers and Mantel r.
  Accepted column names are flexible:
    repA/repB or replicon_1/replicon_2 or rep1/rep2
    mantel_r or Mantel_r or r

Optional:
- control Mantel table for Figure 4f with multi/separate values.

No tree reconstruction, sequence extraction, alignment, or Mantel calculation is performed here.
Those are upstream analyses. This script only integrates their outputs.
"""

from __future__ import annotations

import argparse
from collections import defaultdict
from glob import glob
from pathlib import Path
from typing import Iterable

import numpy as np
import pandas as pd
from scipy.stats import ks_2samp, mannwhitneyu, spearmanr, wilcoxon


# ============================================================
# I/O AND HELPERS
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


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower_map = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower_map:
            return lower_map[c.lower()]
    return None


def normalize_id(x: object) -> str:
    s = str(x).strip().split("/")[-1]
    for ext in (".fasta", ".fa", ".fna", ".faa", ".gb", ".gbk", ".csv", ".tsv", ".xlsx", ".gz"):
        if s.endswith(ext):
            s = s[: -len(ext)]
    return s


def parse_replicons(x: object) -> list[str]:
    if pd.isna(x):
        return []
    s = str(x).strip()
    if not s or s.lower() in {"nan", "none", "-", "na"}:
        return []
    return [r.strip() for r in s.split(",") if r.strip()]


def make_pair(a: object, b: object) -> str:
    a = str(a).strip()
    b = str(b).strip()
    a, b = sorted([a, b])
    return f"{a} | {b}"


def split_pair_column(pair: str) -> tuple[str, str]:
    s = str(pair)
    for sep in [" | ", "||", "|", "--", "__"]:
        if sep in s:
            parts = [p.strip() for p in s.split(sep) if p.strip()]
            if len(parts) == 2:
                return tuple(sorted(parts))
    raise ValueError(f"Could not split pair column value: {pair}")


def qcv(values: np.ndarray) -> float:
    values = np.asarray(values, dtype=float)
    values = values[np.isfinite(values)]
    if values.size == 0:
        return np.nan
    q1, q3 = np.percentile(values, [25, 75])
    denom = q3 + q1
    if denom == 0:
        return np.nan
    return (q3 - q1) / denom


# ============================================================
# STEP 1: DISTANCE COMPUTATION FROM MOB-TYPER
# ============================================================

def compute_replicon_distances_from_mobtyper(
    mobtyper_dir: Path,
    plasmid_replicons_path: Path | None,
    min_dist_bp: int = 10,
) -> pd.DataFrame:
    id2size = {}

    if plasmid_replicons_path is not None:
        plasmid_replicons = read_table(plasmid_replicons_path)
        id_col = first_existing(plasmid_replicons.columns, ["plasmid_id", "NUCCORE_ACC", "accession"])
        size_col = first_existing(plasmid_replicons.columns, ["size_bp", "length_bp", "length"])
        if id_col is not None and size_col is not None:
            tmp = plasmid_replicons[[id_col, size_col]].copy()
            tmp[id_col] = tmp[id_col].map(normalize_id)
            tmp[size_col] = pd.to_numeric(tmp[size_col], errors="coerce")
            id2size = dict(zip(tmp[id_col], tmp[size_col]))

    blast_cols = [
        "qseqid", "sseqid", "qlen", "slen", "qstart", "qend", "sstart", "send",
        "length", "mismatch", "pident", "qcovhsp", "qcovs", "sstrand", "evalue", "bitscore",
    ]

    folders = glob(str(mobtyper_dir / "*_analysis"))
    plasmid_ids = [Path(f).name.replace("_analysis", "") for f in folders]

    all_rows = []

    for plasmid_id in plasmid_ids:
        analysis_folder = mobtyper_dir / f"{plasmid_id}_analysis"
        blast_file = analysis_folder / "replicon_blast_results.txt"
        summary_file = mobtyper_dir / f"{plasmid_id}_summary.txt"

        if not blast_file.is_file() or not summary_file.is_file():
            continue

        try:
            summary = pd.read_csv(summary_file, sep="\t")
        except Exception:
            continue

        sample_col = first_existing(summary.columns, ["sample_id", "sample", "id"])
        rep_col = first_existing(summary.columns, ["rep_type(s)", "replicon_types", "rep_types"])
        acc_col = first_existing(summary.columns, ["rep_type_accession(s)", "rep_type_accessions", "rep_accession(s)"])

        if sample_col is None or rep_col is None or acc_col is None:
            continue

        row = summary[summary[sample_col].astype(str).map(normalize_id) == normalize_id(plasmid_id)]
        if row.empty:
            row = summary.iloc[[0]]

        rep_types = parse_replicons(row.iloc[0][rep_col])
        rep_accessions = parse_replicons(row.iloc[0][acc_col])

        if len(rep_types) < 2 or len(rep_accessions) < 2:
            continue
        if len(rep_types) != len(rep_accessions):
            continue

        try:
            blast = pd.read_csv(blast_file, sep="\t")
            if not {"qseqid", "sstart", "slen", "bitscore"}.issubset(blast.columns):
                blast = pd.read_csv(blast_file, sep="\t", names=blast_cols, header=0)
        except Exception:
            try:
                blast = pd.read_csv(blast_file, sep="\t", names=blast_cols, header=0)
            except Exception:
                continue

        if blast.empty:
            continue

        replicon_positions = []
        assigned_positions = []

        for rep_type, rep_acc in zip(rep_types, rep_accessions):
            hits = blast[blast["qseqid"].astype(str).str.contains(str(rep_acc), regex=False, na=False)].copy()
            if hits.empty:
                continue

            hits["bitscore"] = pd.to_numeric(hits["bitscore"], errors="coerce")
            hits = hits.sort_values("bitscore", ascending=False)

            assigned = False

            for hit in hits.itertuples(index=False):
                pos = int(getattr(hit, "sstart"))
                slen = int(getattr(hit, "slen"))

                too_close = False
                for prev in assigned_positions:
                    diff = abs(pos - prev)
                    dist = min(diff, slen - diff)
                    if dist < min_dist_bp:
                        too_close = True
                        break

                if not too_close:
                    replicon_positions.append({
                        "replicon": rep_type,
                        "accession": rep_acc,
                        "sstart": pos,
                        "slen": slen,
                    })
                    assigned_positions.append(pos)
                    assigned = True
                    break

            if not assigned and not hits.empty:
                hit = hits.iloc[0]
                pos = int(hit["sstart"])
                slen = int(hit["slen"])
                replicon_positions.append({
                    "replicon": rep_type,
                    "accession": rep_acc,
                    "sstart": pos,
                    "slen": slen,
                })
                assigned_positions.append(pos)

        if len(replicon_positions) < 2:
            continue

        for i in range(len(replicon_positions)):
            for j in range(i + 1, len(replicon_positions)):
                r1 = replicon_positions[i]
                r2 = replicon_positions[j]

                pos1 = int(r1["sstart"])
                pos2 = int(r2["sstart"])

                plasmid_len = int(r1["slen"])
                if not plasmid_len or plasmid_len <= 0:
                    plasmid_len = int(id2size.get(normalize_id(plasmid_id), np.nan))

                if not plasmid_len or not np.isfinite(plasmid_len) or plasmid_len <= 0:
                    continue

                diff = abs(pos2 - pos1)
                dist_abs = min(diff, plasmid_len - diff)
                dist_rel = dist_abs / plasmid_len

                all_rows.append({
                    "plasmid_id": normalize_id(plasmid_id),
                    "replicon_1": r1["replicon"],
                    "replicon_2": r2["replicon"],
                    "pair": make_pair(r1["replicon"], r2["replicon"]),
                    "pos_1": pos1,
                    "pos_2": pos2,
                    "plasmid_length": plasmid_len,
                    "distance_absolute": dist_abs,
                    "distance_relative": dist_rel,
                })

    return pd.DataFrame(all_rows)


# ============================================================
# STEP 2: LOAD DISTANCES / EXTERNAL TABLES
# ============================================================

def load_distances(path: str | Path) -> pd.DataFrame:
    df = read_table(path)
    r1 = first_existing(df.columns, ["replicon_1", "repA", "rep1", "replicon_a"])
    r2 = first_existing(df.columns, ["replicon_2", "repB", "rep2", "replicon_b"])
    drel = first_existing(df.columns, ["distance_relative", "relative_distance", "dist_rel"])
    dabs = first_existing(df.columns, ["distance_absolute", "absolute_distance", "dist_abs"])

    if r1 is None or r2 is None or drel is None:
        raise SystemExit("Distance table needs replicon_1, replicon_2 and distance_relative columns.")

    out = df.copy()
    out["repA"] = out[r1].astype(str)
    out["repB"] = out[r2].astype(str)
    out["pair"] = [make_pair(a, b) for a, b in zip(out["repA"], out["repB"])]
    out["distance_relative"] = pd.to_numeric(out[drel], errors="coerce")

    if dabs is not None:
        out["distance_absolute"] = pd.to_numeric(out[dabs], errors="coerce")
    else:
        out["distance_absolute"] = np.nan

    pid_col = first_existing(out.columns, ["plasmid_id", "NUCCORE_ACC", "accession"])
    if pid_col is not None:
        out["plasmid_id"] = out[pid_col].map(normalize_id)

    out = out.dropna(subset=["distance_relative"])
    out = out[(out["distance_relative"] >= 0) & (out["distance_relative"] <= 0.5)].copy()
    return out


def load_cointegration(path: str | Path | None) -> pd.DataFrame:
    if path is None:
        return pd.DataFrame(columns=["pair", "cointegration_rate"])

    df = read_table(path)
    r1 = first_existing(df.columns, ["repA", "replicon_1", "rep1", "replicon_a"])
    r2 = first_existing(df.columns, ["repB", "replicon_2", "rep2", "replicon_b"])
    pair_col = first_existing(df.columns, ["pair", "rep_pair"])
    rate_col = first_existing(df.columns, ["cointegration_rate", "rate", "p_same_plasmid"])

    if rate_col is None:
        raise SystemExit("Cointegration table needs cointegration_rate column.")

    out = df.copy()
    if r1 is not None and r2 is not None:
        out["pair"] = [make_pair(a, b) for a, b in zip(out[r1], out[r2])]
    elif pair_col is not None:
        pairs = out[pair_col].apply(split_pair_column)
        out["pair"] = [make_pair(a, b) for a, b in pairs]
    else:
        raise SystemExit("Cointegration table needs repA/repB or pair column.")

    out["cointegration_rate"] = pd.to_numeric(out[rate_col], errors="coerce")

    keep_cols = ["pair", "cointegration_rate"]
    for c in ["category", "ci_low", "ci_high", "n_same_cell"]:
        if c in out.columns:
            keep_cols.append(c)

    return out[keep_cols].drop_duplicates("pair")


def load_mantel(path: str | Path | None) -> pd.DataFrame:
    if path is None:
        return pd.DataFrame(columns=["pair", "mantel_r", "mantel_p"])

    df = read_table(path)

    r1 = first_existing(df.columns, ["repA", "replicon_1", "rep1", "replicon_a", "rep_a"])
    r2 = first_existing(df.columns, ["repB", "replicon_2", "rep2", "replicon_b", "rep_b"])
    pair_col = first_existing(df.columns, ["pair", "rep_pair"])
    r_col = first_existing(df.columns, ["mantel_r", "Mantel_r", "mantelR", "r", "correlation", "mirror_tree_r"])
    p_col = first_existing(df.columns, ["mantel_p", "Mantel_p", "p_value", "p", "pval"])

    if r_col is None:
        raise SystemExit("Mantel table needs a Mantel r column, e.g. mantel_r.")

    out = df.copy()
    if r1 is not None and r2 is not None:
        out["pair"] = [make_pair(a, b) for a, b in zip(out[r1], out[r2])]
    elif pair_col is not None:
        pairs = out[pair_col].apply(split_pair_column)
        out["pair"] = [make_pair(a, b) for a, b in pairs]
    else:
        raise SystemExit("Mantel table needs repA/repB or pair column.")

    out["mantel_r"] = pd.to_numeric(out[r_col], errors="coerce")
    if p_col is not None:
        out["mantel_p"] = pd.to_numeric(out[p_col], errors="coerce")
    else:
        out["mantel_p"] = np.nan

    return out[["pair", "mantel_r", "mantel_p"]].drop_duplicates("pair")


def load_mantel_control(path: str | Path | None) -> pd.DataFrame:
    if path is None:
        return pd.DataFrame()

    df = read_table(path)

    pair_col = first_existing(df.columns, ["pair", "rep_pair"])
    r1 = first_existing(df.columns, ["repA", "replicon_1", "rep1"])
    r2 = first_existing(df.columns, ["repB", "replicon_2", "rep2"])

    if r1 is not None and r2 is not None:
        df["pair"] = [make_pair(a, b) for a, b in zip(df[r1], df[r2])]
    elif pair_col is not None:
        pairs = df[pair_col].apply(split_pair_column)
        df["pair"] = [make_pair(a, b) for a, b in pairs]
    else:
        raise SystemExit("Mantel control table needs repA/repB or pair column.")

    multi_col = first_existing(df.columns, ["mantel_r_multi", "multi_mantel_r", "mr_mantel_r", "mantel_multi"])
    single_col = first_existing(df.columns, ["mantel_r_single", "single_mantel_r", "separate_mantel_r", "control_mantel_r", "mantel_single"])

    if multi_col is not None and single_col is not None:
        out = df[["pair", multi_col, single_col]].copy()
        out = out.rename(columns={multi_col: "mantel_r_multireplicon", single_col: "mantel_r_separate"})
        out["mantel_r_multireplicon"] = pd.to_numeric(out["mantel_r_multireplicon"], errors="coerce")
        out["mantel_r_separate"] = pd.to_numeric(out["mantel_r_separate"], errors="coerce")
        return out.dropna(subset=["mantel_r_multireplicon", "mantel_r_separate"]).drop_duplicates("pair")

    context_col = first_existing(df.columns, ["context", "status", "comparison", "group"])
    r_col = first_existing(df.columns, ["mantel_r", "Mantel_r", "r", "correlation"])

    if context_col is None or r_col is None:
        raise SystemExit(
            "Mantel control table must be either wide "
            "(mantel_r_multi + mantel_r_single) or long (context + mantel_r)."
        )

    tmp = df[["pair", context_col, r_col]].copy()
    tmp[context_col] = tmp[context_col].astype(str).str.lower()
    tmp["mantel_r"] = pd.to_numeric(tmp[r_col], errors="coerce")

    def context_type(x: str) -> str | None:
        if "multi" in x or x == "mr":
            return "mantel_r_multireplicon"
        if "single" in x or "separate" in x or "control" in x:
            return "mantel_r_separate"
        return None

    tmp["context_type"] = tmp[context_col].map(context_type)
    tmp = tmp.dropna(subset=["context_type", "mantel_r"])

    wide = (
        tmp.pivot_table(index="pair", columns="context_type", values="mantel_r", aggfunc="mean")
        .reset_index()
    )

    if not {"mantel_r_multireplicon", "mantel_r_separate"}.issubset(wide.columns):
        return pd.DataFrame()

    return wide.dropna(subset=["mantel_r_multireplicon", "mantel_r_separate"])


# ============================================================
# STEP 3: DISTANCE/QCV ANALYSES
# ============================================================

def observed_distance_distribution(dist: pd.DataFrame) -> pd.DataFrame:
    cols = ["pair", "repA", "repB", "distance_relative", "distance_absolute"]
    if "plasmid_id" in dist.columns:
        cols = ["plasmid_id"] + cols
    return dist[cols].copy()


def generate_random_distances(
    dist: pd.DataFrame,
    seed: int,
    n_random_per_observed: int = 1,
) -> pd.DataFrame:
    rng = np.random.default_rng(seed)
    n = len(dist) * n_random_per_observed

    x = rng.random(n)
    y = rng.random(n)
    d = np.abs(x - y)
    rel = np.minimum(d, 1 - d)

    if n_random_per_observed == 1:
        pair_values = dist["pair"].values
    else:
        pair_values = np.repeat(dist["pair"].values, n_random_per_observed)

    return pd.DataFrame({
        "pair": pair_values,
        "distance_relative": rel,
        "source": "null",
    })


def pair_distance_metrics(dist: pd.DataFrame, min_n: int) -> pd.DataFrame:
    rows = []
    for pair, sub in dist.groupby("pair"):
        values = sub["distance_relative"].dropna().values
        if len(values) < min_n:
            continue
        try:
            repA, repB = split_pair_column(pair)
        except Exception:
            repA, repB = np.nan, np.nan
        q1, q3 = np.percentile(values, [25, 75])
        rows.append({
            "pair": pair,
            "repA": repA,
            "repB": repB,
            "N": int(len(values)),
            "median_rel": float(np.median(values)),
            "mean_rel": float(np.mean(values)),
            "Q1_rel": float(q1),
            "Q3_rel": float(q3),
            "IQR_rel": float(q3 - q1),
            "QCV_rel": float(qcv(values)),
        })
    return pd.DataFrame(rows).sort_values("QCV_rel") if rows else pd.DataFrame()


def random_pair_qcv(
    dist: pd.DataFrame,
    min_n: int,
    n_iterations: int,
    seed: int,
) -> pd.DataFrame:
    rng = np.random.default_rng(seed)

    pair_sizes = (
        dist.groupby("pair")
        .size()
        .reset_index(name="N")
    )
    pair_sizes = pair_sizes[pair_sizes["N"] >= min_n].copy()

    rows = []
    for iteration in range(n_iterations):
        for r in pair_sizes.itertuples(index=False):
            x = rng.random(r.N)
            y = rng.random(r.N)
            d = np.abs(x - y)
            rel = np.minimum(d, 1 - d)
            rows.append({
                "iteration": iteration,
                "pair": r.pair,
                "N": int(r.N),
                "QCV_rel_null": float(qcv(rel)),
                "median_rel_null": float(np.median(rel)),
            })

    return pd.DataFrame(rows)


def distance_distribution_tests(obs: pd.DataFrame, null: pd.DataFrame) -> pd.DataFrame:
    obs_vals = obs["distance_relative"].dropna().values
    null_vals = null["distance_relative"].dropna().values

    if len(obs_vals) == 0 or len(null_vals) == 0:
        return pd.DataFrame()

    ks = ks_2samp(obs_vals, null_vals, alternative="two-sided")

    return pd.DataFrame([{
        "comparison": "observed_relative_distance_vs_random_null",
        "test": "Kolmogorov-Smirnov",
        "n_observed": int(len(obs_vals)),
        "n_null": int(len(null_vals)),
        "statistic": float(ks.statistic),
        "p_value": float(ks.pvalue),
    }])


def qcv_distribution_tests(obs_metrics: pd.DataFrame, null_qcv: pd.DataFrame) -> pd.DataFrame:
    if obs_metrics.empty or null_qcv.empty:
        return pd.DataFrame()

    obs = obs_metrics["QCV_rel"].dropna().values
    null = null_qcv["QCV_rel_null"].dropna().values

    if len(obs) == 0 or len(null) == 0:
        return pd.DataFrame()

    u = mannwhitneyu(obs, null, alternative="less")

    return pd.DataFrame([{
        "comparison": "observed_QCV_rel_less_than_random_null",
        "test": "one-sided Mann-Whitney U",
        "alternative": "observed < null",
        "n_observed_pairs": int(len(obs)),
        "n_null_values": int(len(null)),
        "median_observed_QCV_rel": float(np.median(obs)),
        "median_null_QCV_rel": float(np.median(null)),
        "u_statistic": float(u.statistic),
        "p_value": float(u.pvalue),
    }])


# ============================================================
# STEP 4: COEVOLUTION INTEGRATION
# ============================================================

def integrate_pair_metrics(
    qcv_metrics: pd.DataFrame,
    cointegration: pd.DataFrame,
    mantel: pd.DataFrame,
) -> pd.DataFrame:
    out = qcv_metrics.copy()

    if not cointegration.empty:
        out = out.merge(cointegration, on="pair", how="left")

    if not mantel.empty:
        out = out.merge(mantel, on="pair", how="left")

    return out


def spearman_table(
    df: pd.DataFrame,
    x_col: str,
    y_col: str,
    comparison: str,
) -> pd.DataFrame:
    if df.empty or x_col not in df.columns or y_col not in df.columns:
        return pd.DataFrame()

    tmp = df[[x_col, y_col]].dropna()
    if tmp.shape[0] < 3:
        return pd.DataFrame()

    rho, p = spearmanr(tmp[x_col], tmp[y_col])

    return pd.DataFrame([{
        "comparison": comparison,
        "x": x_col,
        "y": y_col,
        "n": int(tmp.shape[0]),
        "spearman_rho": float(rho),
        "p_value": float(p),
    }])


def mantel_control_test(control: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    if control.empty:
        return pd.DataFrame(), pd.DataFrame()

    tmp = control.dropna(subset=["mantel_r_multireplicon", "mantel_r_separate"]).copy()
    if tmp.empty:
        return pd.DataFrame(), pd.DataFrame()

    try:
        w = wilcoxon(
            tmp["mantel_r_multireplicon"],
            tmp["mantel_r_separate"],
            alternative="greater",
            zero_method="wilcox",
        )
        p_value = float(w.pvalue)
        statistic = float(w.statistic)
    except Exception:
        p_value = np.nan
        statistic = np.nan

    summary = pd.DataFrame([{
        "comparison": "multireplicon_mantel_r_greater_than_separate_single_replicon",
        "test": "paired Wilcoxon signed-rank",
        "alternative": "multireplicon > separate",
        "n_pairs": int(tmp.shape[0]),
        "median_mantel_r_multireplicon": float(tmp["mantel_r_multireplicon"].median()),
        "median_mantel_r_separate": float(tmp["mantel_r_separate"].median()),
        "statistic": statistic,
        "p_value": p_value,
    }])

    return tmp, summary


# ============================================================
# MAIN
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(
        description="Generate Figure 4 / Supplementary Figure 7 analysis tables."
    )

    ap.add_argument("--distances", default=None, help="Existing replicon_distances.tsv.")
    ap.add_argument("--mobtyper-dir", default=None, help="MOB-typer output directory for distance computation.")
    ap.add_argument("--plasmid-replicons", default=None, help="Optional plasmid_replicons.tsv for size fallback in distance computation.")

    ap.add_argument("--cointegration", default=None, help="Section 3 cointegration table.")
    ap.add_argument("--mantel", default=None, help="Precomputed Mantel results table.")
    ap.add_argument("--mantel-control", default=None, help="Optional Mantel control table for Figure 4f.")

    ap.add_argument("--outdir", required=True, help="Output directory.")
    ap.add_argument("--min-pair-n", type=int, default=5, help="Minimum observations per replicon pair for QCV.")
    ap.add_argument("--min-dist-bp", type=int, default=10, help="Minimum distance between assigned replicon hits when computing coordinates.")
    ap.add_argument("--random-seed", type=int, default=123)
    ap.add_argument("--random-per-observed", type=int, default=1)
    ap.add_argument("--qcv-null-iterations", type=int, default=1000)

    args = ap.parse_args()
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    if args.distances:
        dist = load_distances(args.distances)
    elif args.mobtyper_dir:
        dist = compute_replicon_distances_from_mobtyper(
            mobtyper_dir=Path(args.mobtyper_dir),
            plasmid_replicons_path=Path(args.plasmid_replicons) if args.plasmid_replicons else None,
            min_dist_bp=args.min_dist_bp,
        )
        if dist.empty:
            raise SystemExit("No distances were computed from MOB-typer outputs.")
    else:
        raise SystemExit("Provide either --distances or --mobtyper-dir.")

    write_table(dist, outdir / "fig4_replicon_distances.tsv")
    write_table(observed_distance_distribution(dist), outdir / "fig4b_observed_relative_distances.tsv")

    null_dist = generate_random_distances(
        dist,
        seed=args.random_seed,
        n_random_per_observed=args.random_per_observed,
    )
    write_table(null_dist, outdir / "fig4b_null_relative_distances.tsv")
    write_table(distance_distribution_tests(dist, null_dist), outdir / "fig4b_distance_distribution_ks_test.tsv")

    qcv_metrics = pair_distance_metrics(dist, min_n=args.min_pair_n)
    write_table(qcv_metrics, outdir / "fig4c_pair_spacing_qcv.tsv")

    null_qcv = random_pair_qcv(
        dist,
        min_n=args.min_pair_n,
        n_iterations=args.qcv_null_iterations,
        seed=args.random_seed,
    )
    write_table(null_qcv, outdir / "fig4c_null_pair_spacing_qcv.tsv")
    write_table(qcv_distribution_tests(qcv_metrics, null_qcv), outdir / "fig4c_qcv_mannwhitney_test.tsv")

    cointegration = load_cointegration(args.cointegration)
    mantel = load_mantel(args.mantel)
    pair_metrics = integrate_pair_metrics(qcv_metrics, cointegration, mantel)
    write_table(pair_metrics, outdir / "fig4_pair_metrics_integrated.tsv")

    write_table(
        spearman_table(
            pair_metrics,
            x_col="QCV_rel",
            y_col="mantel_r",
            comparison="spacing_variability_QCV_rel_vs_coevolution_mantel_r",
        ),
        outdir / "fig4e_qcv_vs_mantel_spearman.tsv",
    )

    write_table(
        spearman_table(
            pair_metrics,
            x_col="QCV_rel",
            y_col="cointegration_rate",
            comparison="spacing_variability_QCV_rel_vs_cointegration_rate",
        ),
        outdir / "fig4_aux_qcv_vs_cointegration_spearman.tsv",
    )

    write_table(
        spearman_table(
            pair_metrics,
            x_col="median_rel",
            y_col="mantel_r",
            comparison="median_relative_distance_vs_mantel_r",
        ),
        outdir / "suppfig7_median_distance_vs_mantel_spearman.tsv",
    )

    if args.mantel_control:
        control = load_mantel_control(args.mantel_control)
        control_table, control_stats = mantel_control_test(control)
        write_table(control_table, outdir / "fig4f_mantel_multireplicon_vs_separate_pairs.tsv")
        write_table(control_stats, outdir / "fig4f_mantel_paired_wilcoxon.tsv")
    else:
        print("[info] No --mantel-control provided; skipping Figure 4f paired control.")

    print("[done] Section 4 analysis tables generated.")


if __name__ == "__main__":
    main()
