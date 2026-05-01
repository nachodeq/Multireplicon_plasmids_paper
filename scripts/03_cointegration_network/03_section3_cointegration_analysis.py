#!/usr/bin/env python3
"""
Section 3 analysis for Figure 3 and Supplementary Figure 6.

Manuscript section:
"Non-random assembly of multireplicon plasmids"

This script does NOT export final figures. It generates clean tables/statistics for:

Figure 3a:
- Replicon association network in six target genera.
- Nodes are replicons.
- Edges connect replicons co-occurring on the same multireplicon plasmid.
- Edge weight is absolute co-occurrence count.
- Louvain communities and soft membership are reported.

Figure 3b/c:
- Cell-level conditional cointegration:
    P(same plasmid | same genome)
- Global and genus-specific estimates.
- Exact Clopper–Pearson confidence intervals.
- Classification:
    STRONG_COINTEGRATION: rate >= 0.8 and ci_low >= 0.6
    STRONG_REPULSION:     rate <= 0.2 and ci_high <= 0.4
    MIXED:                all remaining pairs

Figure 3d:
- Table of conserved and genus-specific associations for heatmaps:
  all pair × genus rows for pairs that are strong in at least one genus or
  switch between STRONG_COINTEGRATION and STRONG_REPULSION across genera.

Supplementary Figure 6:
- Stability of cointegration rate across host genera:
    mean cointegration rate vs SD across genera.

Inputs:
- meta/nuccore.csv
- meta/assembly.csv
- meta/typing.csv
- Optional Supplementary_Dataset_1.xlsx to restrict the association network to deduplicated plasmids.

No plotting is performed here.
"""

from __future__ import annotations

import argparse
import ast
from collections import defaultdict
from itertools import combinations
from pathlib import Path
from typing import Iterable

import networkx as nx
import numpy as np
import pandas as pd
from statsmodels.stats.proportion import proportion_confint

try:
    from community import community_louvain
except Exception:
    community_louvain = None


TARGET_GENERA = [
    "Klebsiella",
    "Enterobacter",
    "Escherichia",
    "Salmonella",
    "Enterococcus",
    "Staphylococcus",
]

MIN_CELL_GLOBAL = 5
MIN_CELL_GENUS = 5
MIN_CELL_GENUS_FOR_VARIATION = 3


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


def clean_genus_from_description(x: object) -> str | float:
    if pd.isna(x):
        return np.nan
    s = str(x).strip()
    if not s:
        return np.nan
    tokens = s.split()
    if not tokens:
        return np.nan
    return tokens[0].capitalize()


def parse_replicons(x: object) -> list[str]:
    if pd.isna(x):
        return []
    s = str(x).strip()
    if not s or s.lower() in {"nan", "none", "-", "na"}:
        return []
    return sorted({r.strip() for r in s.split(",") if r.strip()})


def safe_eval_list(x: object) -> list:
    if pd.isna(x):
        return []
    if isinstance(x, list):
        return x
    if isinstance(x, str):
        try:
            value = ast.literal_eval(x)
            if isinstance(value, list):
                return value
            return [value]
        except Exception:
            return []
    return []


def classify_cointegration(rate: float, ci_low: float, ci_high: float) -> str:
    if rate >= 0.8 and ci_low >= 0.6:
        return "STRONG_COINTEGRATION"
    if rate <= 0.2 and ci_high <= 0.4:
        return "STRONG_REPULSION"
    return "MIXED"


def make_pair(a: str, b: str) -> str:
    a, b = sorted([a, b])
    return f"{a} | {b}"


# ============================================================
# LOAD INPUTS
# ============================================================

def load_deduplicated_ids(path: str | Path | None) -> set[str] | None:
    if path is None:
        return None
    df = read_table(path)
    id_col = first_existing(df.columns, ["plasmid_id", "NUCCORE_ACC", "nuccore_acc", "accession"])
    if id_col is None:
        raise SystemExit("Supplementary dataset needs plasmid_id or accession column.")
    return set(df[id_col].map(normalize_id))


def load_nuccore(path: str | Path) -> pd.DataFrame:
    df = read_table(path)
    uid_col = first_existing(df.columns, ["NUCCORE_UID", "nuccore_uid"])
    acc_col = first_existing(df.columns, ["NUCCORE_ACC", "nuccore_acc", "plasmid_id"])
    desc_col = first_existing(df.columns, ["NUCCORE_Description", "description", "Description"])

    if uid_col is None or acc_col is None:
        raise SystemExit("nuccore table needs NUCCORE_UID and NUCCORE_ACC columns.")

    out = pd.DataFrame()
    out["NUCCORE_UID"] = df[uid_col].astype(str)
    out["NUCCORE_ACC"] = df[acc_col].map(normalize_id)

    if desc_col is not None:
        out["GENUS"] = df[desc_col].map(clean_genus_from_description)
    else:
        genus_col = first_existing(df.columns, ["GENUS", "genus", "Genus"])
        if genus_col is None:
            out["GENUS"] = np.nan
        else:
            out["GENUS"] = df[genus_col].astype(str).str.strip().str.capitalize()

    return out.drop_duplicates(["NUCCORE_UID", "NUCCORE_ACC"])


def load_assembly(path: str | Path) -> pd.DataFrame:
    df = read_table(path)
    assembly_col = first_existing(df.columns, ["ASSEMBLY_ACC", "assembly_acc", "assembly"])
    uid_col = first_existing(df.columns, ["NUCCORE_UID", "nuccore_uid"])

    if assembly_col is None or uid_col is None:
        raise SystemExit("assembly table needs ASSEMBLY_ACC and NUCCORE_UID columns.")

    out = pd.DataFrame()
    out["ASSEMBLY_ACC"] = df[assembly_col].astype(str)
    out["NUCCORE_UID"] = df[uid_col].apply(safe_eval_list)
    out = out.explode("NUCCORE_UID").dropna(subset=["NUCCORE_UID"])
    out["NUCCORE_UID"] = out["NUCCORE_UID"].astype(str)
    return out


def load_typing(path: str | Path) -> pd.DataFrame:
    df = read_table(path)
    acc_col = first_existing(df.columns, ["NUCCORE_ACC", "nuccore_acc", "plasmid_id", "accession"])
    rep_col = first_existing(df.columns, ["rep_type(s)", "replicon_types", "rep_types", "replicons"])

    if acc_col is None or rep_col is None:
        raise SystemExit("typing table needs NUCCORE_ACC and rep_type(s) columns.")

    out = pd.DataFrame()
    out["NUCCORE_ACC"] = df[acc_col].map(normalize_id)
    out["rep_type(s)"] = df[rep_col].astype(str)
    out["rep_types"] = out["rep_type(s)"].apply(parse_replicons)
    return out.drop_duplicates("NUCCORE_ACC")


def build_plasmid_level_table(nuccore: pd.DataFrame, typing: pd.DataFrame) -> pd.DataFrame:
    df = nuccore[["NUCCORE_ACC", "GENUS"]].drop_duplicates().merge(
        typing[["NUCCORE_ACC", "rep_types"]],
        on="NUCCORE_ACC",
        how="left",
    )
    df["rep_types"] = df["rep_types"].apply(lambda x: x if isinstance(x, list) else [])
    df["n_replicons"] = df["rep_types"].map(len)
    return df


def build_cell_level_table(assembly: pd.DataFrame, nuccore: pd.DataFrame, typing: pd.DataFrame) -> pd.DataFrame:
    df = assembly.merge(
        nuccore[["NUCCORE_UID", "NUCCORE_ACC", "GENUS"]],
        on="NUCCORE_UID",
        how="left",
    )
    df = df.merge(
        typing[["NUCCORE_ACC", "rep_types"]],
        on="NUCCORE_ACC",
        how="left",
    )
    df["rep_types"] = df["rep_types"].apply(lambda x: x if isinstance(x, list) else [])
    return df.dropna(subset=["ASSEMBLY_ACC", "NUCCORE_ACC"])


# ============================================================
# FIGURE 3A: ASSOCIATION NETWORK ON DEDUPLICATED PLASMIDS
# ============================================================

def build_replicon_association_network(
    plasmids: pd.DataFrame,
    deduplicated_ids: set[str] | None,
) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    df = plasmids.copy()

    if deduplicated_ids is not None:
        df = df[df["NUCCORE_ACC"].isin(deduplicated_ids)].copy()

    df = df[df["GENUS"].isin(TARGET_GENERA)].copy()
    df = df[df["rep_types"].map(len) >= 2].copy()

    edge_counts = defaultdict(int)
    node_counts = defaultdict(int)
    node_genera = defaultdict(set)

    for row in df.itertuples(index=False):
        reps = sorted(set(row.rep_types))
        for rep in reps:
            node_counts[rep] += 1
            node_genera[rep].add(row.GENUS)

        for a, b in combinations(reps, 2):
            edge_counts[(a, b)] += 1

    edge_rows = [
        {"repA": a, "repB": b, "weight": w}
        for (a, b), w in edge_counts.items()
        if w > 0
    ]
    edges = pd.DataFrame(edge_rows).sort_values("weight", ascending=False) if edge_rows else pd.DataFrame()

    G = nx.Graph()
    for rep, count in node_counts.items():
        G.add_node(rep, plasmid_count=count, genera=";".join(sorted(node_genera[rep])))

    for row in edge_rows:
        G.add_edge(row["repA"], row["repB"], weight=int(row["weight"]))

    isolates = list(nx.isolates(G))
    G.remove_nodes_from(isolates)

    if G.number_of_nodes() > 0 and G.number_of_edges() > 0 and community_louvain is not None:
        partition = community_louvain.best_partition(G, weight="weight")
    else:
        partition = {node: 0 for node in G.nodes()}

    # Soft membership in the two largest Louvain communities, following the Methods.
    comms = defaultdict(list)
    for node, comm in partition.items():
        comms[comm].append(node)

    comms_sorted = sorted(comms.values(), key=len, reverse=True)
    main_communities = [set(x) for x in comms_sorted[:2]]

    def strength_to_community(node: str, community: set[str]) -> float:
        return sum(
            G[node][nbr]["weight"]
            for nbr in G.neighbors(node)
            if nbr in community
        )

    node_rows = []
    for node in G.nodes():
        degree = G.degree(node)
        strength = G.degree(node, weight="weight")
        assigned = []

        if main_communities:
            total_to_main = sum(strength_to_community(node, c) for c in main_communities)
            for idx, community in enumerate(main_communities, start=1):
                s = strength_to_community(node, community)
                frac = s / total_to_main if total_to_main > 0 else 0
                if frac >= 0.25:
                    assigned.append(f"C{idx}")

        node_rows.append({
            "replicon": node,
            "degree": degree,
            "strength": strength,
            "plasmid_count": G.nodes[node].get("plasmid_count", np.nan),
            "genera": G.nodes[node].get("genera", ""),
            "louvain_community": partition.get(node, np.nan),
            "soft_community": ";".join(assigned) if assigned else "",
        })

    nodes = pd.DataFrame(node_rows).sort_values(["degree", "strength"], ascending=False)

    graph_summary = pd.DataFrame([{
        "n_plasmids_used": int(df["NUCCORE_ACC"].nunique()),
        "n_nodes": G.number_of_nodes(),
        "n_edges": G.number_of_edges(),
        "n_isolates_removed": len(isolates),
        "density": nx.density(G) if G.number_of_nodes() > 1 else np.nan,
        "mean_degree": float(np.mean([d for _, d in G.degree()])) if G.number_of_nodes() > 0 else np.nan,
        "mean_strength": float(np.mean([d for _, d in G.degree(weight='weight')])) if G.number_of_nodes() > 0 else np.nan,
        "average_clustering_weighted": nx.average_clustering(G, weight="weight") if G.number_of_nodes() > 0 else np.nan,
    }])

    return nodes, edges, graph_summary


# ============================================================
# FIGURE 3B/C: CELL-LEVEL COINTEGRATION
# ============================================================

def cointegration_from_cell_table(
    cell_df: pd.DataFrame,
    min_cell: int,
    genus: str | None = None,
) -> pd.DataFrame:
    if genus is not None:
        df = cell_df[cell_df["GENUS"] == genus].copy()
    else:
        df = cell_df.copy()

    records = defaultdict(list)

    for assembly_acc, sub in df.groupby("ASSEMBLY_ACC"):
        plasmids = (
            sub.groupby("NUCCORE_ACC")["rep_types"]
            .apply(lambda x: set().union(*[set(v) for v in x if isinstance(v, list)]))
            .to_dict()
        )

        plasmids = {p: reps for p, reps in plasmids.items() if reps}
        if not plasmids:
            continue

        reps_in_cell = set.union(*plasmids.values())
        if len(reps_in_cell) < 2:
            continue

        for a, b in combinations(sorted(reps_in_cell), 2):
            same_plasmid = any({a, b}.issubset(reps) for reps in plasmids.values())
            records[(a, b)].append(int(same_plasmid))

    rows = []
    for (a, b), vals in records.items():
        n = len(vals)
        if n < min_cell:
            continue

        k = int(sum(vals))
        rate = k / n

        ci_low, ci_high = proportion_confint(
            count=k,
            nobs=n,
            alpha=0.05,
            method="beta",
        )

        rows.append({
            "repA": a,
            "repB": b,
            "pair": make_pair(a, b),
            "n_same_cell": n,
            "n_cell_same_plasmid": k,
            "cointegration_rate": rate,
            "ci_low": ci_low,
            "ci_high": ci_high,
            "category": classify_cointegration(rate, ci_low, ci_high),
        })

    out = pd.DataFrame(rows)
    if genus is not None and not out.empty:
        out["genus"] = genus

    return out.sort_values(["category", "cointegration_rate"], ascending=[True, False]) if not out.empty else out


def cointegration_by_genus(cell_df: pd.DataFrame, min_cell: int) -> pd.DataFrame:
    tables = []
    for genus in TARGET_GENERA:
        gdf = cointegration_from_cell_table(cell_df, min_cell=min_cell, genus=genus)
        if not gdf.empty:
            tables.append(gdf)
    return pd.concat(tables, ignore_index=True) if tables else pd.DataFrame()


def category_summary(df: pd.DataFrame, group_col: str | None = None) -> pd.DataFrame:
    if df.empty:
        return pd.DataFrame()

    if group_col and group_col in df.columns:
        out = (
            df.groupby([group_col, "category"])
            .size()
            .reset_index(name="n_pairs")
        )
        out["percent"] = out.groupby(group_col)["n_pairs"].transform(lambda x: 100 * x / x.sum())
    else:
        out = df.groupby("category").size().reset_index(name="n_pairs")
        out["percent"] = 100 * out["n_pairs"] / out["n_pairs"].sum()

    return out


# ============================================================
# FIGURE 3D AND SUPPLEMENTARY FIGURE 6
# ============================================================

def heatmap_pairs_table(by_genus: pd.DataFrame) -> pd.DataFrame:
    if by_genus.empty:
        return pd.DataFrame()

    df = by_genus.copy()

    pair_to_categories = df.groupby("pair")["category"].apply(set)

    strong_pairs = set(
        df[df["category"].isin(["STRONG_COINTEGRATION", "STRONG_REPULSION"])]["pair"]
    )

    opposite_pairs = set(
        pair_to_categories[
            pair_to_categories.apply(
                lambda cats: (
                    "STRONG_COINTEGRATION" in cats and
                    "STRONG_REPULSION" in cats
                )
            )
        ].index
    )

    keep_pairs = strong_pairs | opposite_pairs

    out = df[df["pair"].isin(keep_pairs)].copy()
    out["is_mixed_opposite"] = out["pair"].isin(opposite_pairs)

    return out.sort_values(["pair", "genus"])


def host_variation(by_genus: pd.DataFrame) -> pd.DataFrame:
    if by_genus.empty:
        return pd.DataFrame()

    rows = []
    eps = 1e-3

    for (repA, repB, pair), sub in by_genus.groupby(["repA", "repB", "pair"]):
        p = sub["cointegration_rate"].values
        z = np.log((p + eps) / (1 - p + eps))

        rows.append({
            "repA": repA,
            "repB": repB,
            "pair": pair,
            "n_genus": int(len(p)),
            "mean_p": float(np.mean(p)),
            "sd_p": float(np.std(p, ddof=1)) if len(p) > 1 else 0.0,
            "mad_p": float(np.median(np.abs(p - np.median(p)))),
            "sd_logit_p": float(np.std(z, ddof=1)) if len(z) > 1 else 0.0,
            "genera": ";".join(sorted(sub["genus"].astype(str).unique())),
        })

    out = pd.DataFrame(rows)
    out = out.query("n_genus >= 3 and mean_p > 0").copy()
    return out.sort_values(["sd_p", "mean_p"], ascending=[False, False])


# ============================================================
# MAIN
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(
        description="Generate Figure 3 / Supplementary Figure 6 analysis tables."
    )

    ap.add_argument("--nuccore", required=True, help="meta/nuccore.csv")
    ap.add_argument("--assembly", required=True, help="meta/assembly.csv")
    ap.add_argument("--typing", required=True, help="meta/typing.csv")
    ap.add_argument("--supplementary-dataset", default=None, help="Optional Supplementary_Dataset_1.xlsx for deduplicated network.")
    ap.add_argument("--outdir", required=True, help="Output directory.")
    ap.add_argument("--min-cell-global", type=int, default=MIN_CELL_GLOBAL)
    ap.add_argument("--min-cell-genus", type=int, default=MIN_CELL_GENUS)

    args = ap.parse_args()
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    nuccore = load_nuccore(args.nuccore)
    assembly = load_assembly(args.assembly)
    typing = load_typing(args.typing)
    dedup_ids = load_deduplicated_ids(args.supplementary_dataset)

    plasmids = build_plasmid_level_table(nuccore, typing)
    cell_df = build_cell_level_table(assembly, nuccore, typing)

    write_table(plasmids, outdir / "section3_plasmid_level_table.tsv")
    write_table(cell_df, outdir / "section3_cell_level_table.tsv")

    # Figure 3a
    nodes, edges, graph_summary = build_replicon_association_network(plasmids, dedup_ids)
    write_table(nodes, outdir / "fig3a_replicon_network_nodes.tsv")
    write_table(edges, outdir / "fig3a_replicon_network_edges.tsv")
    write_table(graph_summary, outdir / "fig3a_replicon_network_summary.tsv")

    # Figure 3b/c global.
    global_cointegration = cointegration_from_cell_table(
        cell_df,
        min_cell=args.min_cell_global,
        genus=None,
    )
    write_table(global_cointegration, outdir / "fig3bc_cointegration_global.tsv")
    write_table(category_summary(global_cointegration), outdir / "fig3bc_cointegration_global_category_counts.tsv")

    # Figure 3c/d by genus.
    by_genus = cointegration_by_genus(cell_df, min_cell=args.min_cell_genus)
    write_table(by_genus, outdir / "fig3cd_cointegration_by_genus.tsv")
    write_table(category_summary(by_genus, group_col="genus"), outdir / "fig3c_cointegration_by_genus_category_counts.tsv")

    # Figure 3d heatmap support table.
    heatmap_table = heatmap_pairs_table(by_genus)
    write_table(heatmap_table, outdir / "fig3d_relevant_pairs_heatmap_table.tsv")

    # Supplementary Figure 6.
    variation = host_variation(by_genus)
    write_table(variation, outdir / "suppfig6_cointegration_host_variation.tsv")

    print("[done] Section 3 analysis tables generated.")


if __name__ == "__main__":
    main()
