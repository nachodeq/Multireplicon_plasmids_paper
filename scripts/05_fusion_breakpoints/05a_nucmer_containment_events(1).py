#!/usr/bin/env python3
"""
05a_nucmer_containment_events.py

Section 5 / Figure 5 upstream analysis:
Identify simple plasmid-containment relationships consistent with plasmid fusion events.

This script implements the manuscript step:

- Stratify plasmids by replicon number.
- Align plasmids carrying N replicons against plasmids carrying >N replicons using
  NUCmer/MUMmer4 with --maxmatch.
- Parse show-coords output.
- Retain only simple containment events:
    coverage of the smaller plasmid >= 90%
    nucleotide identity >= 90%
    one continuous alignment hit per plasmid pair
    the smaller plasmid carries fewer replicons than the larger plasmid
- Export one row per inferred event, with breakpoint coordinates on the larger plasmid.

This script does not extract breakpoint windows, does not run BLASTn between
breakpoints, and does not run digIS. Those steps are downstream scripts.

Inputs
------
--plasmid-table:
    TSV/CSV/XLSX containing at least:
        plasmid_id
        n_replicons
    Optional:
        length_bp / size_bp
        fasta
    If 'fasta' is missing, --fasta-dir is used to find files by plasmid_id.

--fasta-dir:
    Directory containing plasmid FASTA files. Required if plasmid-table lacks fasta paths.

Outputs
-------
outdir/
  level_fastas/
    level<N>_queries.fasta
    level_gt<N>_targets.fasta
  nucmer/
    level<N>_vs_gt<N>.delta
    level<N>_vs_gt<N>.coords.tsv
  containment_events.tsv
  containment_pairs_all_hits.tsv
  containment_summary.tsv
"""

from __future__ import annotations

import argparse
import os
import subprocess
from pathlib import Path
from typing import Iterable

import pandas as pd
from Bio import SeqIO


# ============================================================
# Helpers
# ============================================================

def read_table(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    suffix = "".join(path.suffixes).lower()
    if suffix.endswith(".xlsx") or suffix.endswith(".xls"):
        return pd.read_excel(path)
    if suffix.endswith(".csv"):
        return pd.read_csv(path)
    return pd.read_csv(path, sep="\t")


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower:
            return lower[c.lower()]
    return None


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


def find_fasta(plasmid_id: str, fasta_dir: Path) -> Path | None:
    pid = normalize_id(plasmid_id)
    for ext in ["*.fna", "*.fa", "*.fasta", "*.fna.gz", "*.fa.gz", "*.fasta.gz"]:
        matches = list(fasta_dir.glob(ext))
        for p in matches:
            if normalize_id(p.name) == pid:
                return p
    # fallback substring search
    matches = list(fasta_dir.glob(f"{pid}*"))
    return matches[0] if matches else None


def fasta_length(path: Path) -> int:
    total = 0
    for rec in SeqIO.parse(str(path), "fasta"):
        total += len(rec.seq)
    return total


def write_concat_fasta(plasmids: pd.DataFrame, out_fasta: Path, id_col: str, fasta_col: str) -> int:
    out_fasta.parent.mkdir(parents=True, exist_ok=True)
    n = 0
    with open(out_fasta, "w") as oh:
        for row in plasmids.itertuples(index=False):
            pid = getattr(row, id_col)
            fp = Path(getattr(row, fasta_col))
            if not fp.exists():
                continue
            records = list(SeqIO.parse(str(fp), "fasta"))
            if not records:
                continue

            # Most PLSDB plasmids are single-record FASTA files. If multiple records are present,
            # concatenate is not attempted; only the first record is used and a warning is printed.
            if len(records) > 1:
                print(f"[warn] {fp} has {len(records)} records; using first record.")

            rec = records[0]
            rec.id = str(pid)
            rec.name = str(pid)
            rec.description = str(pid)
            SeqIO.write(rec, oh, "fasta")
            n += 1
    return n


def run_cmd(cmd: list[str], dry_run: bool = False, stdout_path: Path | None = None) -> None:
    print("[cmd]", " ".join(map(str, cmd)))
    if dry_run:
        return
    if stdout_path is None:
        subprocess.run(cmd, check=True)
    else:
        stdout_path.parent.mkdir(parents=True, exist_ok=True)
        with open(stdout_path, "w") as oh:
            subprocess.run(cmd, check=True, stdout=oh)


def parse_show_coords(path: Path, source_file: str) -> pd.DataFrame:
    """
    Parse show-coords -THrcl output.

    Expected columns after -THrcl:
    S1 E1 S2 E2 LEN1 LEN2 %IDY LENR LENQ COVR COVQ TAGR TAGQ
    """
    rows = []
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            toks = line.split("\t")
            if len(toks) < 13:
                toks = line.split()
            if len(toks) < 13:
                continue

            try:
                rows.append({
                    "s1": int(toks[0]),
                    "e1": int(toks[1]),
                    "s2": int(toks[2]),
                    "e2": int(toks[3]),
                    "len1": int(float(toks[4])),
                    "len2": int(float(toks[5])),
                    "pident": float(toks[6]),
                    "lenR": int(float(toks[7])),
                    "lenQ": int(float(toks[8])),
                    "covR": float(toks[9]),
                    "covQ": float(toks[10]),
                    "ref": toks[11],
                    "qry": toks[12],
                    "source_file": source_file,
                })
            except Exception:
                continue

    return pd.DataFrame(rows)


# ============================================================
# Main
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(description="Run NUCmer containment search and filter simple fusion-like events.")
    ap.add_argument("--plasmid-table", required=True)
    ap.add_argument("--fasta-dir", default=None)
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--threads", type=int, default=30)
    ap.add_argument("--min-coverage", type=float, default=0.90)
    ap.add_argument("--min-identity", type=float, default=90.0)
    ap.add_argument("--nucmer", default="nucmer")
    ap.add_argument("--show-coords", default="show-coords")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--skip-nucmer", action="store_true", help="Parse existing coords files only.")
    args = ap.parse_args()

    outdir = Path(args.outdir)
    fasta_outdir = outdir / "level_fastas"
    nucmer_outdir = outdir / "nucmer"
    fasta_outdir.mkdir(parents=True, exist_ok=True)
    nucmer_outdir.mkdir(parents=True, exist_ok=True)

    meta = read_table(args.plasmid_table)

    id_col = first_existing(meta.columns, ["plasmid_id", "NUCCORE_ACC", "accession", "id"])
    rep_col = first_existing(meta.columns, ["n_replicons", "replicon_count", "level"])
    len_col = first_existing(meta.columns, ["length_bp", "size_bp", "length"])
    fasta_col = first_existing(meta.columns, ["fasta", "fasta_path", "path"])

    if id_col is None or rep_col is None:
        raise SystemExit("plasmid-table must contain plasmid_id and n_replicons columns.")

    meta = meta.copy()
    meta["plasmid_id"] = meta[id_col].map(normalize_id)
    meta["n_replicons"] = pd.to_numeric(meta[rep_col], errors="coerce")
    meta = meta.dropna(subset=["plasmid_id", "n_replicons"]).copy()
    meta["n_replicons"] = meta["n_replicons"].astype(int)
    meta = meta[meta["n_replicons"] > 0].copy()

    if fasta_col is not None:
        meta["fasta_path"] = meta[fasta_col].astype(str)
    else:
        if args.fasta_dir is None:
            raise SystemExit("--fasta-dir is required if plasmid-table lacks a fasta column.")
        fasta_dir = Path(args.fasta_dir)
        meta["fasta_path"] = [
            str(find_fasta(pid, fasta_dir) or "")
            for pid in meta["plasmid_id"]
        ]

    meta = meta[meta["fasta_path"].astype(str).str.len() > 0].copy()
    meta = meta[meta["fasta_path"].map(lambda x: Path(x).exists())].copy()

    if len_col is not None:
        meta["length_bp"] = pd.to_numeric(meta[len_col], errors="coerce")
    else:
        meta["length_bp"] = pd.NA

    missing_len = meta["length_bp"].isna()
    if missing_len.any():
        print(f"[info] computing FASTA lengths for {missing_len.sum()} plasmids")
        meta.loc[missing_len, "length_bp"] = meta.loc[missing_len, "fasta_path"].map(lambda x: fasta_length(Path(x)))

    meta = meta[["plasmid_id", "n_replicons", "length_bp", "fasta_path"]].drop_duplicates("plasmid_id")
    meta = meta.rename(columns={"plasmid_id": "pid"})
    id2n = dict(zip(meta["pid"], meta["n_replicons"]))
    id2len = dict(zip(meta["pid"], meta["length_bp"]))

    levels = sorted(meta["n_replicons"].unique())
    all_hits = []

    for level in levels:
        queries = meta[meta["n_replicons"] == level].copy()
        targets = meta[meta["n_replicons"] > level].copy()
        if queries.empty or targets.empty:
            continue

        q_fa = fasta_outdir / f"level{level}_queries.fasta"
        t_fa = fasta_outdir / f"level_gt{level}_targets.fasta"

        n_q = write_concat_fasta(queries, q_fa, "pid", "fasta_path")
        n_t = write_concat_fasta(targets, t_fa, "pid", "fasta_path")

        if n_q == 0 or n_t == 0:
            continue

        prefix = nucmer_outdir / f"level{level}_vs_gt{level}"
        delta = Path(str(prefix) + ".delta")
        coords = Path(str(prefix) + ".coords.tsv")

        if not args.skip_nucmer:
            run_cmd(
                [args.nucmer, "--maxmatch", "-t", str(args.threads), "-p", str(prefix), str(t_fa), str(q_fa)],
                dry_run=args.dry_run,
            )
            run_cmd(
                [args.show_coords, "-THrcl", str(delta)],
                dry_run=args.dry_run,
                stdout_path=coords,
            )

        if coords.exists():
            df = parse_show_coords(coords, source_file=coords.name)
            all_hits.append(df)

    if not all_hits:
        raise SystemExit("No show-coords hits parsed.")

    hits = pd.concat(all_hits, ignore_index=True)
    hits["ref"] = hits["ref"].map(normalize_id)
    hits["qry"] = hits["qry"].map(normalize_id)

    # Determine small/large by true length, not by reference/query role.
    rows = []
    for r in hits.itertuples(index=False):
        ref_len = int(id2len.get(r.ref, r.lenR))
        qry_len = int(id2len.get(r.qry, r.lenQ))
        ref_n = int(id2n.get(r.ref, -1))
        qry_n = int(id2n.get(r.qry, -1))

        if ref_len >= qry_len:
            big_id, small_id = r.ref, r.qry
            big_len, small_len = ref_len, qry_len
            big_n, small_n = ref_n, qry_n
            big_start, big_end = int(r.s1), int(r.e1)
            small_start, small_end = int(r.s2), int(r.e2)
            big_role = "ref"
        else:
            big_id, small_id = r.qry, r.ref
            big_len, small_len = qry_len, ref_len
            big_n, small_n = qry_n, ref_n
            big_start, big_end = int(r.s2), int(r.e2)
            small_start, small_end = int(r.s1), int(r.e1)
            big_role = "qry"

        aligned_len_on_small = abs(small_end - small_start) + 1
        small_coverage = aligned_len_on_small / small_len if small_len else 0

        rows.append({
            "big_id": big_id,
            "small_id": small_id,
            "big_len": big_len,
            "small_len": small_len,
            "big_n_replicons": big_n,
            "small_n_replicons": small_n,
            "big_start": min(big_start, big_end),
            "big_end": max(big_start, big_end),
            "small_start": min(small_start, small_end),
            "small_end": max(small_start, small_end),
            "orientation": "+" if (big_end - big_start) * (small_end - small_start) >= 0 else "-",
            "pident": float(r.pident),
            "small_coverage": float(small_coverage),
            "source_file": r.source_file,
            "big_role": big_role,
        })

    pairs = pd.DataFrame(rows)
    pairs.to_csv(outdir / "containment_pairs_all_hits.tsv", sep="\t", index=False)

    # Simple continuous events: exactly one retained hit for a pair after thresholds.
    filt = pairs[
        (pairs["small_coverage"] >= args.min_coverage) &
        (pairs["pident"] >= args.min_identity) &
        (pairs["small_n_replicons"] < pairs["big_n_replicons"])
    ].copy()

    counts = filt.groupby(["small_id", "big_id"]).size().reset_index(name="n_hits_pair")
    filt = filt.merge(counts, on=["small_id", "big_id"], how="left")
    events = filt[filt["n_hits_pair"] == 1].copy()
    events = events.sort_values(["big_id", "small_id"]).reset_index(drop=True)
    events.insert(0, "event_id", range(1, len(events) + 1))

    events.to_csv(outdir / "containment_events.tsv", sep="\t", index=False)

    summary = pd.DataFrame([{
        "n_plasmids_with_fasta": len(meta),
        "n_raw_hits": len(hits),
        "n_hits_after_thresholds": len(filt),
        "n_simple_containment_events": len(events),
        "min_coverage": args.min_coverage,
        "min_identity": args.min_identity,
    }])
    summary.to_csv(outdir / "containment_summary.tsv", sep="\t", index=False)

    print(f"[out] {outdir / 'containment_events.tsv'}")
    print("[done]")


if __name__ == "__main__":
    main()
