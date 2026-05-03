#!/usr/bin/env python3
"""
05b_breakpoint_homology_analysis.py

Section 5 / Figure 5a and Supplementary Figures 8-10:
Extract fusion-breakpoint windows and quantify homology between paired breakpoints.

This script implements the manuscript step:

- Use containment_events.tsv from 05a.
- Treat the start and end of the alignment interval on the larger plasmid as the two
  fusion breakpoints.
- Extract ±500 bp windows around each breakpoint by default.
- Compare the two breakpoint windows with BLASTn:
    dust masking disabled
    soft masking disabled
    minimum nucleotide identity 95%
- Retain only the single best local hit per breakpoint pair, ranked by alignment length.
- Assign 0 bp when no alignment meets the threshold.
- Generate a matched random control by sampling two random positions in the same plasmid
  for each event and applying the same window extraction and BLASTn procedure.
- Optionally cluster homologous tracts across events with cd-hit-est at 95% identity.

Outputs
-------
outdir/
  breakpoints_master.tsv
  breakpoints_windows.fa
  real_best_homology.tsv
  homologous_tracts.fa
  random_windows_master.tsv
  random_windows.fa
  random_best_homology.tsv
  real_vs_random_merged.tsv
  homology_length_categories.tsv
  cdhit/homologous_tracts_cdhit_95.fa  [optional]
  cdhit/homologous_tracts_cdhit_95.clstr [optional]
  homologous_tract_cluster_sizes.tsv [optional]
"""

from __future__ import annotations

import argparse
import os
import random
import subprocess
import tempfile
from pathlib import Path
from typing import Iterable

import pandas as pd
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord


# ============================================================
# Helpers
# ============================================================

def read_table(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    if path.suffix.lower() in {".xlsx", ".xls"}:
        return pd.read_excel(path)
    if path.suffix.lower() == ".csv":
        return pd.read_csv(path)
    return pd.read_csv(path, sep="\t")


def normalize_id(x: object) -> str:
    s = str(x).strip().split()[0]
    s = os.path.basename(s)
    for ext in [
        ".fna.gz", ".fa.gz", ".fasta.gz",
        ".fna", ".fa", ".fasta", ".gb", ".gbk",
    ]:
        if s.endswith(ext):
            s = s[: -len(ext)]
            break
    return s


def index_fastas(fasta_dir: Path) -> dict[str, Path]:
    idx = {}
    for p in fasta_dir.iterdir():
        if p.is_file() and p.name.endswith((".fa", ".fna", ".fasta", ".fa.gz", ".fna.gz", ".fasta.gz")):
            idx.setdefault(normalize_id(p.name), p)
    return idx


def find_fasta(plasmid_id: str, idx: dict[str, Path], fasta_dir: Path) -> Path | None:
    pid = normalize_id(plasmid_id)
    if pid in idx:
        return idx[pid]
    matches = list(fasta_dir.glob(f"{pid}*"))
    return matches[0] if matches else None


def read_plasmid_sequence(path: Path):
    records = list(SeqIO.parse(str(path), "fasta"))
    if not records:
        raise ValueError(f"No FASTA records found in {path}")
    if len(records) > 1:
        print(f"[warn] {path} has {len(records)} records; using first record.")
    return records[0].seq


def circular_subseq(seq, center: int, half_window: int):
    L = len(seq)
    center0 = (int(center) - 1) % L
    positions = [(center0 - half_window + i) % L for i in range(2 * half_window)]
    return "".join(str(seq[p]) for p in positions)


def fasta_header(pair_id: int, plasmid: str, kind: str, pos: int, hw: int, dataset: str = "real") -> str:
    return f"pair={pair_id}|plasmid={plasmid}|kind={kind}|pos={pos}|hw={hw}|dataset={dataset}"


def write_fasta(records: list[SeqRecord], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w") as oh:
        SeqIO.write(records, oh, "fasta")


def run_blastn(query_fa: Path, subject_fa: Path, blastn: str) -> pd.DataFrame:
    outfmt = "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
    cmd = [
        blastn,
        "-query", str(query_fa),
        "-subject", str(subject_fa),
        "-task", "blastn",
        "-dust", "no",
        "-soft_masking", "false",
        "-outfmt", outfmt,
    ]
    res = subprocess.run(cmd, check=True, capture_output=True, text=True)
    if not res.stdout.strip():
        return pd.DataFrame(columns=outfmt.split()[1:])
    rows = [x.split("\t") for x in res.stdout.strip().splitlines()]
    cols = outfmt.split()[1:]
    df = pd.DataFrame(rows, columns=cols)
    for c in ["pident", "length", "qstart", "qend", "sstart", "send", "evalue", "bitscore"]:
        df[c] = pd.to_numeric(df[c], errors="coerce")
    return df


def best_blast_hit(query_seq: str, subject_seq: str, pair_id: int, blastn: str, min_pid: float):
    with tempfile.TemporaryDirectory() as td:
        q = Path(td) / "q.fa"
        s = Path(td) / "s.fa"
        q.write_text(f">q\n{query_seq}\n")
        s.write_text(f">s\n{subject_seq}\n")

        hits = run_blastn(q, s, blastn)
        hits = hits[hits["pident"] >= min_pid].copy()
        if hits.empty:
            return {
                "pair_id": pair_id,
                "best_length": 0,
                "pident": pd.NA,
                "qstart": pd.NA,
                "qend": pd.NA,
                "sstart": pd.NA,
                "send": pd.NA,
                "bitscore": pd.NA,
                "homologous_tract_seq": "",
            }

        hit = hits.sort_values(["length", "bitscore", "pident"], ascending=[False, False, False]).iloc[0]
        qstart = int(hit["qstart"])
        qend = int(hit["qend"])
        a = min(qstart, qend) - 1
        b = max(qstart, qend)
        tract = query_seq[a:b]

        return {
            "pair_id": pair_id,
            "best_length": int(hit["length"]),
            "pident": float(hit["pident"]),
            "qstart": int(hit["qstart"]),
            "qend": int(hit["qend"]),
            "sstart": int(hit["sstart"]),
            "send": int(hit["send"]),
            "bitscore": float(hit["bitscore"]),
            "homologous_tract_seq": tract,
        }


def categorize_length(x: int) -> str:
    x = int(x)
    if x == 0:
        return "0"
    if x <= 20:
        return "1-20"
    if x <= 450:
        return "21-450"
    if x <= 650:
        return "451-650"
    return ">650"


def run_cdhit(input_fa: Path, output_prefix: Path, cdhit_est: str, identity: float) -> bool:
    if not input_fa.exists() or input_fa.stat().st_size == 0:
        return False
    output_prefix.parent.mkdir(parents=True, exist_ok=True)
    cmd = [
        cdhit_est,
        "-i", str(input_fa),
        "-o", str(output_prefix),
        "-c", str(identity),
        "-n", "8",
        "-d", "0",
    ]
    try:
        subprocess.run(cmd, check=True)
        return True
    except Exception as e:
        print(f"[warn] cd-hit-est failed/skipped: {e}")
        return False


def parse_cdhit_clusters(clstr_path: Path) -> pd.DataFrame:
    rows = []
    if not clstr_path.exists():
        return pd.DataFrame()
    cluster = None
    members = []
    with open(clstr_path) as fh:
        for line in fh:
            line = line.strip()
            if line.startswith(">Cluster"):
                if cluster is not None:
                    rows.append({"cluster": cluster, "cluster_size": len(members), "members": ";".join(members)})
                cluster = line.replace(">", "")
                members = []
            else:
                parts = line.split(">")
                if len(parts) > 1:
                    member = parts[1].split("...")[0]
                    members.append(member)
    if cluster is not None:
        rows.append({"cluster": cluster, "cluster_size": len(members), "members": ";".join(members)})
    return pd.DataFrame(rows)


# ============================================================
# Main
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(description="Extract breakpoint windows and quantify homologous tracts.")
    ap.add_argument("--containment-events", required=True)
    ap.add_argument("--fasta-dir", required=True)
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--half-window", type=int, default=500)
    ap.add_argument("--min-pident", type=float, default=95.0)
    ap.add_argument("--blastn", default="blastn")
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument("--run-cdhit", action="store_true")
    ap.add_argument("--cdhit-est", default="cd-hit-est")
    ap.add_argument("--cdhit-identity", type=float, default=0.95)
    args = ap.parse_args()

    rng = random.Random(args.seed)
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    events = read_table(args.containment_events)
    required = {"event_id", "big_id", "big_start", "big_end", "big_len"}
    missing = required - set(events.columns)
    if missing:
        raise SystemExit(f"containment-events missing columns: {sorted(missing)}")

    fasta_dir = Path(args.fasta_dir)
    fasta_index = index_fastas(fasta_dir)

    real_master = []
    random_master = []
    real_records = []
    random_records = []
    real_homology = []
    random_homology = []
    tract_records = []

    for row in events.itertuples(index=False):
        pair_id = int(row.event_id)
        plasmid = str(row.big_id)
        fasta = find_fasta(plasmid, fasta_index, fasta_dir)
        if fasta is None:
            print(f"[warn] missing FASTA for {plasmid}")
            continue

        seq = read_plasmid_sequence(fasta)
        L = len(seq)

        bp_start = int(row.big_start)
        bp_end = int(row.big_end)

        start_seq = circular_subseq(seq, bp_start, args.half_window)
        end_seq = circular_subseq(seq, bp_end, args.half_window)

        for kind, pos, wseq in [
            ("start", bp_start, start_seq),
            ("end", bp_end, end_seq),
        ]:
            sid = fasta_header(pair_id, plasmid, kind, pos, args.half_window, dataset="real")
            real_master.append({
                "pair_id": pair_id,
                "plasmid": plasmid,
                "bp_kind": kind,
                "breakpoint_pos": pos,
                "window_hw": args.half_window,
                "sid": sid,
                "plasmid_len": L,
            })
            real_records.append(SeqRecord(seq=wseq, id=sid, description=""))

        best = best_blast_hit(start_seq, end_seq, pair_id, args.blastn, args.min_pident)
        best.update({
            "plasmid": plasmid,
            "bp_start_pos": bp_start,
            "bp_end_pos": bp_end,
            "plasmid_len": L,
            "condition": "real",
        })
        real_homology.append(best)

        if best["best_length"] > 0 and best["homologous_tract_seq"]:
            tract_records.append(SeqRecord(
                seq=best["homologous_tract_seq"],
                id=f"pair_{pair_id:05d}|plasmid={plasmid}|length={best['best_length']}",
                description="",
            ))

        # Random matched control: two random points in the same plasmid.
        r1 = rng.randint(1, L)
        r2 = rng.randint(1, L)
        rseq1 = circular_subseq(seq, r1, args.half_window)
        rseq2 = circular_subseq(seq, r2, args.half_window)

        for kind, pos, wseq in [
            ("start", r1, rseq1),
            ("end", r2, rseq2),
        ]:
            sid = fasta_header(pair_id, plasmid, kind, pos, args.half_window, dataset="random")
            random_master.append({
                "pair_id": pair_id,
                "plasmid": plasmid,
                "bp_kind": kind,
                "breakpoint_pos": pos,
                "window_hw": args.half_window,
                "sid": sid,
                "plasmid_len": L,
            })
            random_records.append(SeqRecord(seq=wseq, id=sid, description=""))

        rbest = best_blast_hit(rseq1, rseq2, pair_id, args.blastn, args.min_pident)
        rbest.update({
            "plasmid": plasmid,
            "random_start_pos": r1,
            "random_end_pos": r2,
            "plasmid_len": L,
            "condition": "random",
        })
        random_homology.append(rbest)

    real_master_df = pd.DataFrame(real_master)
    random_master_df = pd.DataFrame(random_master)
    real_df = pd.DataFrame(real_homology)
    random_df = pd.DataFrame(random_homology)

    real_master_df.to_csv(outdir / "breakpoints_master.tsv", sep="\t", index=False)
    random_master_df.to_csv(outdir / "random_windows_master.tsv", sep="\t", index=False)

    write_fasta(real_records, outdir / "breakpoints_windows.fa")
    write_fasta(random_records, outdir / "random_windows.fa")
    write_fasta(tract_records, outdir / "homologous_tracts.fa")

    real_df.to_csv(outdir / "real_best_homology.tsv", sep="\t", index=False)
    random_df.to_csv(outdir / "random_best_homology.tsv", sep="\t", index=False)

    merged = real_df.drop(columns=["homologous_tract_seq"], errors="ignore").merge(
        random_df.drop(columns=["homologous_tract_seq"], errors="ignore"),
        on=["pair_id", "plasmid", "plasmid_len"],
        how="outer",
        suffixes=("_real", "_random"),
    )
    merged.to_csv(outdir / "real_vs_random_merged.tsv", sep="\t", index=False)

    long = pd.concat([
        real_df[["pair_id", "plasmid", "best_length"]].assign(condition="real"),
        random_df[["pair_id", "plasmid", "best_length"]].assign(condition="random"),
    ], ignore_index=True)
    long["category"] = long["best_length"].fillna(0).astype(int).map(categorize_length)

    cat_summary = (
        long.groupby(["condition", "category"])
        .size()
        .reset_index(name="n_pairs")
    )
    totals = long.groupby("condition").size().reset_index(name="total_pairs")
    cat_summary = cat_summary.merge(totals, on="condition", how="left")
    cat_summary["fraction"] = cat_summary["n_pairs"] / cat_summary["total_pairs"]
    cat_summary["percentage"] = 100 * cat_summary["fraction"]
    cat_summary.to_csv(outdir / "homology_length_categories.tsv", sep="\t", index=False)

    if args.run_cdhit:
        cdhit_dir = outdir / "cdhit"
        cdhit_out = cdhit_dir / "homologous_tracts_cdhit_95.fa"
        ok = run_cdhit(outdir / "homologous_tracts.fa", cdhit_out, args.cdhit_est, args.cdhit_identity)
        if ok:
            clusters = parse_cdhit_clusters(Path(str(cdhit_out) + ".clstr"))
            clusters.to_csv(outdir / "homologous_tract_cluster_sizes.tsv", sep="\t", index=False)

    print("[done] Breakpoint homology analysis complete.")


if __name__ == "__main__":
    main()
