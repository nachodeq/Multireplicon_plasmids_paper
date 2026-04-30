#!/usr/bin/env python3

"""
Description:
Graph-based dereplication of PLSDB plasmids using Mash distances on predicted
amino acid sequences and Louvain clustering stratified by replicon count.

Inputs:
- plasmid_replicons.tsv with columns:
    plasmid_id
    replicon_types
    faa
    size_bp
    n_replicons
- predicted protein FASTA files (.faa)

Outputs:
- faa_nonempty.list
- plasmids_aa.msh
- mash_dist.tsv
- mash_dist.nozero.tsv
- cluster_assignments_by_level.tsv
- representatives_by_cluster_level.tsv
- to_keep_louvain_by_level.txt
- Supplementary_Dataset_1.xlsx

Notes:
- Plasmids lacking replicons are excluded.
- Plasmids are stratified by replicon count.
- Edges are defined by Mash distance <= 0.01.
- Isolated nodes are retained as singleton clusters.
- Representative plasmid is chosen as the largest plasmid in the cluster.
"""

import argparse
import csv
import gzip
import os
import subprocess
from collections import defaultdict
from pathlib import Path

import networkx as nx
import pandas as pd
from community import community_louvain


def parse_args():
    p = argparse.ArgumentParser(
        description="Dereplicate plasmids using Mash + Louvain by replicon count."
    )

    p.add_argument(
        "--plasmid-replicons",
        required=True,
        help="TSV with plasmid_id, replicon_types, faa, size_bp, n_replicons.",
    )
    p.add_argument(
        "--outdir",
        required=True,
        help="Output directory.",
    )
    p.add_argument(
        "--threads",
        type=int,
        default=8,
        help="Threads for mash dist.",
    )
    p.add_argument(
        "--mash-k",
        type=int,
        default=9,
        help="Mash k-mer size for amino acid mode.",
    )
    p.add_argument(
        "--mash-sketch",
        type=int,
        default=2000,
        help="Mash sketch size.",
    )
    p.add_argument(
        "--distance-threshold",
        type=float,
        default=0.01,
        help="Mash distance threshold for graph edges.",
    )
    p.add_argument(
        "--skip-mash",
        action="store_true",
        help="Skip Mash sketch/dist if mash_dist.tsv already exists.",
    )

    return p.parse_args()


def open_maybe_gzip(path: Path):
    return gzip.open(path, "rt") if str(path).endswith(".gz") else open(path, "r")


def has_fasta_header(path: Path) -> bool:
    try:
        with open(path, "r") as handle:
            for line in handle:
                if line.startswith(">"):
                    return True
        return False
    except Exception:
        return False


def tokens_csv(x):
    if not isinstance(x, str) or not x.strip():
        return []
    return [t.strip() for t in x.split(",") if t.strip()]


def norm_id(x: str) -> str:
    x = os.path.basename(str(x).strip())
    for ext in (".faa", ".fa", ".fna", ".fasta", ".gz"):
        if x.endswith(ext):
            x = x[: -len(ext)]
    return x


def aa_length_from_faa(path: Path) -> int:
    try:
        total = 0
        current = 0
        with open(path, "r") as handle:
            for line in handle:
                if line.startswith(">"):
                    total += current
                    current = 0
                else:
                    current += len(line.strip())
        total += current
        return total if total > 0 else -1
    except Exception:
        return -1


def size_metric(plasmid_id, id2sizebp, id2faa, cache):
    if plasmid_id in cache:
        return cache[plasmid_id]

    size_bp = id2sizebp.get(plasmid_id)
    if pd.notna(size_bp) and float(size_bp) > 0:
        cache[plasmid_id] = int(float(size_bp))
        return cache[plasmid_id]

    faa = id2faa.get(plasmid_id)
    if faa is not None:
        aa_len = aa_length_from_faa(faa)
        if aa_len > 0:
            cache[plasmid_id] = aa_len
            return aa_len
        try:
            cache[plasmid_id] = faa.stat().st_size
            return cache[plasmid_id]
        except Exception:
            pass

    cache[plasmid_id] = 0
    return 0


def run(cmd):
    print("[cmd]", " ".join(map(str, cmd)))
    subprocess.run(cmd, check=True)


def main():
    args = parse_args()

    plasmid_replicons = Path(args.plasmid_replicons).resolve()
    outdir = Path(args.outdir).resolve()
    outdir.mkdir(parents=True, exist_ok=True)

    faa_list = outdir / "faa_nonempty.list"
    mash_prefix = outdir / "plasmids_aa"
    mash_dist = outdir / "mash_dist.tsv"
    mash_dist_nozero = outdir / "mash_dist.nozero.tsv"

    assign_path = outdir / "cluster_assignments_by_level.tsv"
    repr_path = outdir / "representatives_by_cluster_level.tsv"
    keep_path = outdir / "to_keep_louvain_by_level.txt"
    supp_xlsx = outdir / "Supplementary_Dataset_1.xlsx"

    rep = pd.read_csv(plasmid_replicons, sep="\t", dtype=str)

    required = {"plasmid_id", "replicon_types", "faa", "size_bp", "n_replicons"}
    missing = required - set(rep.columns)
    if missing:
        raise SystemExit(f"Missing required columns: {sorted(missing)}")

    rep["plasmid_id"] = rep["plasmid_id"].astype(str)
    rep["faa"] = rep["faa"].astype(str)
    rep["size_bp"] = pd.to_numeric(rep["size_bp"], errors="coerce")
    rep["n_replicons"] = (
        pd.to_numeric(rep["n_replicons"], errors="coerce")
        .fillna(0)
        .astype(int)
    )
    rep["n_from_types"] = rep["replicon_types"].apply(lambda x: len(tokens_csv(x)))
    rep["level"] = rep[["n_replicons", "n_from_types"]].max(axis=1)

    # Exclude plasmids without replicons.
    rep = rep[rep["level"] > 0].copy()

    # Keep only valid FAA files.
    rep["faa_path"] = rep["faa"].apply(lambda x: Path(x).resolve())
    rep["faa_exists"] = rep["faa_path"].apply(lambda p: p.exists())
    rep["faa_nonempty"] = rep["faa_path"].apply(lambda p: has_fasta_header(p) if p.exists() else False)

    valid = rep[rep["faa_nonempty"]].copy()
    if valid.empty:
        raise SystemExit("No valid .faa files with FASTA headers were found.")

    valid["faa_path"].astype(str).sort_values().to_csv(
        faa_list, index=False, header=False
    )

    print(f"[INFO] Valid FAA files: {valid.shape[0]}")
    print(f"[OUT] {faa_list}")

    if not args.skip_mash:
        run([
            "mash", "sketch",
            "-a",
            "-k", str(args.mash_k),
            "-s", str(args.mash_sketch),
            "-o", str(mash_prefix),
            "-l", str(faa_list),
        ])

        with open(mash_dist, "w") as out:
            subprocess.run(
                [
                    "mash", "dist",
                    "-p", str(args.threads),
                    str(mash_prefix) + ".msh",
                    str(mash_prefix) + ".msh",
                ],
                check=True,
                stdout=out,
            )

    if not mash_dist.exists():
        raise SystemExit(f"Missing Mash distance file: {mash_dist}")

    # Remove exact self-comparisons only.
    with open_maybe_gzip(mash_dist) as inp, open(mash_dist_nozero, "w") as out:
        for line in inp:
            if not line.strip():
                continue
            parts = line.rstrip("\n").split("\t")
            if len(parts) < 3:
                parts = line.split()
            if len(parts) < 3:
                continue
            q, r = parts[0], parts[1]
            if q == r:
                continue
            out.write(line)

    print(f"[OUT] {mash_dist_nozero}")

    levels = sorted(valid["level"].unique().tolist())
    print(f"[INFO] Levels: {levels}")

    id2level = dict(zip(valid["plasmid_id"], valid["level"]))
    id2faa = dict(zip(valid["plasmid_id"], valid["faa_path"]))
    id2sizebp = dict(zip(valid["plasmid_id"], valid["size_bp"]))

    graphs = {level: nx.Graph() for level in levels}
    for level in levels:
        ids = valid.loc[valid["level"] == level, "plasmid_id"].tolist()
        graphs[level].add_nodes_from(ids)

    stats = {
        "total": 0,
        "kept": 0,
        "skipped_threshold": 0,
        "skipped_unknown": 0,
        "skipped_different_level": 0,
        "skipped_format": 0,
    }

    with open_maybe_gzip(mash_dist_nozero) as handle:
        for line in handle:
            stats["total"] += 1
            line = line.strip()
            if not line:
                continue

            parts = line.split("\t")
            if len(parts) < 3:
                parts = line.split()
            if len(parts) < 3:
                stats["skipped_format"] += 1
                continue

            q_raw, r_raw, d_raw = parts[0], parts[1], parts[2]

            try:
                d = float(d_raw)
            except Exception:
                stats["skipped_format"] += 1
                continue

            if d > args.distance_threshold:
                stats["skipped_threshold"] += 1
                continue

            q = norm_id(q_raw)
            r = norm_id(r_raw)

            lq = id2level.get(q)
            lr = id2level.get(r)

            if lq is None or lr is None:
                stats["skipped_unknown"] += 1
                continue

            if lq != lr:
                stats["skipped_different_level"] += 1
                continue

            graphs[lq].add_edge(q, r, weight=1.0 - d)
            stats["kept"] += 1

    print("[BUILD] Mash edge stats:", stats)

    assignments = []
    representatives = []
    cache = {}

    for level in levels:
        graph = graphs[level]
        print(
            f"[LOUVAIN] level={level} nodes={graph.number_of_nodes()} edges={graph.number_of_edges()}"
        )

        if graph.number_of_nodes() == 0:
            continue

        if graph.number_of_edges() > 0:
            partition = community_louvain.best_partition(graph, weight="weight")
        else:
            partition = {}

        next_cluster = max(partition.values()) + 1 if partition else 0

        # Ensure isolated nodes are retained.
        for node in graph.nodes():
            if node not in partition:
                partition[node] = next_cluster
                next_cluster += 1

        clusters = defaultdict(list)
        for node, cluster_id in partition.items():
            clusters[cluster_id].append(node)
            assignments.append((node, level, cluster_id))

        for cluster_id, members in clusters.items():
            representative = sorted(
                members,
                key=lambda x: (-size_metric(x, id2sizebp, id2faa, cache), x),
            )[0]

            representatives.append(
                (
                    level,
                    cluster_id,
                    representative,
                    size_metric(representative, id2sizebp, id2faa, cache),
                    len(members),
                )
            )

    with open(assign_path, "w", newline="") as handle:
        writer = csv.writer(handle, delimiter="\t")
        writer.writerow(["plasmid_id", "n_replicons", "cluster_id"])
        for row in sorted(assignments, key=lambda x: (x[1], x[2], x[0])):
            writer.writerow(row)

    with open(repr_path, "w", newline="") as handle:
        writer = csv.writer(handle, delimiter="\t")
        writer.writerow([
            "n_replicons",
            "cluster_id",
            "representative",
            "rep_size_metric",
            "cluster_size",
        ])
        for row in sorted(representatives, key=lambda x: (x[0], x[1], x[2])):
            writer.writerow(row)

    with open(keep_path, "w") as handle:
        for level, cluster_id, representative, *_ in sorted(
            representatives,
            key=lambda x: (x[0], x[1], x[2]),
        ):
            handle.write(representative + "\n")

    reps_df = pd.DataFrame(
        representatives,
        columns=[
            "n_replicons",
            "cluster_id",
            "plasmid_id",
            "rep_size_metric",
            "cluster_size",
        ],
    )

    supp = reps_df.merge(
        valid[["plasmid_id", "size_bp"]],
        on="plasmid_id",
        how="left",
    )

    supp = supp.rename(columns={"size_bp": "length_bp"})
    supp = supp[[
        "plasmid_id",
        "n_replicons",
        "cluster_id",
        "cluster_size",
        "length_bp",
    ]].sort_values(["n_replicons", "cluster_id", "plasmid_id"])

    supp.to_excel(supp_xlsx, index=False)

    print(f"[OUT] {assign_path}")
    print(f"[OUT] {repr_path}")
    print(f"[OUT] {keep_path}")
    print(f"[OUT] {supp_xlsx}")
    print(f"[SUMMARY] retained={supp.shape[0]} original_valid={valid.shape[0]}")


if __name__ == "__main__":
    main()
