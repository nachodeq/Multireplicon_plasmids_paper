#!/usr/bin/env python3
"""
04a_prepare_align_multireplicon_replicons.py

Prepare and align replicon sequences for the multireplicon Mantel analysis.

This replaces the old combination of:
- fetchallpairs.py
- run_aligns.sh

It does only the upstream preparation needed for Figure 4 coevolution:
1. Read MOB-typer summaries for dereplicated plasmid representatives.
2. Identify unordered replicon pairs occurring in at least MIN_COUNT multireplicon plasmids.
3. Extract each replicon sequence from the source plasmid using MOB-typer
   replicon_blast_results.txt coordinates.
4. Concatenate sequences per replicon per pair.
5. Run MUSCLE or MAFFT to generate aligned FASTA files.

It does NOT:
- build trees
- calculate Mantel tests
- plot figures

Expected MOB-typer layout:
  MOBTYPER_DIR/
    <plasmid_id>_summary.txt
    <plasmid_id>_analysis/replicon_blast_results.txt

Expected derep representatives table:
  representatives_by_cluster_level.tsv
  with column: representative
"""

from __future__ import annotations

import argparse
import glob
import os
import re
import shutil
import subprocess
from collections import defaultdict
from itertools import combinations
from pathlib import Path
from typing import Iterable

import pandas as pd
from Bio import SeqIO


# ============================================================
# Helpers
# ============================================================

def clean_tag(s: object) -> str:
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", str(s).strip())


def basename_noext(x: object) -> str:
    name = str(x).split()[0]
    name = os.path.basename(name)
    for ext in [
        ".faa.gz", ".fna.gz", ".fasta.gz", ".fa.gz",
        ".faa", ".fna", ".ffn", ".gb", ".gbk", ".fasta", ".fa",
    ]:
        if name.endswith(ext):
            name = name[: -len(ext)]
            break
    parts = name.split(".")
    if len(parts) > 1 and parts[-1].isdigit():
        name = ".".join(parts[:-1])
    return name


def split_list(x: object) -> list[str]:
    if pd.isna(x):
        return []
    return [t.strip() for t in re.split(r"[,;]", str(x)) if t.strip()]


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower:
            return lower[c.lower()]
    return None


def index_fastas(fasta_dir: Path) -> dict[str, Path]:
    idx = {}
    for p in fasta_dir.iterdir():
        if p.is_file():
            b = basename_noext(p)
            idx.setdefault(b, p)
    return idx


def find_fasta(plasmid_id: str, fasta_index: dict[str, Path], fasta_dir: Path) -> Path | None:
    b = basename_noext(plasmid_id)
    if b in fasta_index:
        return fasta_index[b]
    matches = list(fasta_dir.glob(f"*{b}*"))
    return matches[0] if matches else None


def read_single_sequence(fasta_path: Path):
    seqs = list(SeqIO.parse(str(fasta_path), "fasta"))
    if not seqs:
        raise ValueError(f"No sequences found in FASTA: {fasta_path}")
    if len(seqs) > 1:
        print(f"[warn] {fasta_path} has {len(seqs)} records; using first record.")
    return seqs[0]


def map_type_to_accession(plasmid_reps: dict, plasmid_rep_accs: dict, plasmid_id: str, rep_type: str) -> str | None:
    types = plasmid_reps.get(plasmid_id, [])
    accs = plasmid_rep_accs.get(plasmid_id, [])

    for i, t in enumerate(types):
        if rep_type == t or rep_type in t or t in rep_type:
            if i < len(accs):
                return accs[i]
    return None


def find_best_hit(blast_df: pd.DataFrame, rep_accession: str) -> pd.Series | None:
    if "qseqid" not in blast_df.columns:
        raise ValueError("replicon_blast_results.txt lacks qseqid column")

    matches = blast_df[blast_df["qseqid"].astype(str).str.contains(rep_accession, na=False, regex=False)].copy()

    if matches.empty and "sseqid" in blast_df.columns:
        matches = blast_df[blast_df["sseqid"].astype(str).str.contains(rep_accession, na=False, regex=False)].copy()

    if matches.empty:
        return None

    if "bitscore" in matches.columns:
        matches["bitscore"] = pd.to_numeric(matches["bitscore"], errors="coerce")
        if matches["bitscore"].notna().any():
            return matches.loc[matches["bitscore"].idxmax()]

    return matches.iloc[0]


def extract_hit_sequence(seq_record, hit: pd.Series):
    for col in ["sstart", "send"]:
        if col not in hit.index:
            raise ValueError(f"BLAST hit lacks {col}")

    sstart = int(hit["sstart"])
    send = int(hit["send"])
    sstrand = str(hit.get("sstrand", "plus"))
    seq_len = len(seq_record.seq)

    if sstart < 1 or send < 1 or sstart > seq_len or send > seq_len:
        raise ValueError(f"Coordinates out of range: {sstart}-{send}; plasmid length={seq_len}")

    a = min(sstart, send) - 1
    b = max(sstart, send)
    subseq = seq_record.seq[a:b]

    if sstrand.lower() == "minus":
        subseq = subseq.reverse_complement()

    return subseq, sstart, send, sstrand


def run_alignment(input_fasta: Path, output_fasta: Path, threads: int = 8, aligner: str = "auto") -> str:
    output_fasta.parent.mkdir(parents=True, exist_ok=True)

    if aligner == "auto":
        if shutil.which("muscle"):
            aligner = "muscle"
        elif shutil.which("mafft"):
            aligner = "mafft"
        else:
            raise RuntimeError("Neither muscle nor mafft found in PATH.")

    if aligner == "muscle":
        # MUSCLE v5 syntax. If it fails, try legacy syntax.
        cmd = ["muscle", "-align", str(input_fasta), "-output", str(output_fasta)]
        try:
            subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError:
            cmd = ["muscle", "-in", str(input_fasta), "-out", str(output_fasta)]
            subprocess.run(cmd, check=True)
        return "muscle"

    if aligner == "mafft":
        with open(output_fasta, "w") as oh:
            subprocess.run(["mafft", "--auto", "--thread", str(threads), str(input_fasta)], stdout=oh, check=True)
        return "mafft"

    raise ValueError(f"Unsupported aligner: {aligner}")


def concatenate_fastas(fastas: list[Path], out_fasta: Path) -> int:
    out_fasta.parent.mkdir(parents=True, exist_ok=True)
    n = 0
    with open(out_fasta, "w") as oh:
        for fasta in sorted(fastas):
            text = fasta.read_text()
            if text.strip():
                oh.write(text)
                if not text.endswith("\n"):
                    oh.write("\n")
                n += 1
    return n


# ============================================================
# Main pipeline
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(description="Prepare and align multireplicon replicon pairs for Mantel analysis.")
    ap.add_argument("--mobtyper-dir", required=True)
    ap.add_argument("--fasta-dir", required=True)
    ap.add_argument("--derep-representatives", required=True, help="TSV with column 'representative'.")
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--min-count", type=int, default=5)
    ap.add_argument("--threads", type=int, default=8)
    ap.add_argument("--aligner", choices=["auto", "muscle", "mafft"], default="auto")
    ap.add_argument("--skip-align", action="store_true", help="Extract and concatenate only; do not run aligner.")
    args = ap.parse_args()

    mobtyper_dir = Path(args.mobtyper_dir)
    fasta_dir = Path(args.fasta_dir)
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)

    derep = pd.read_csv(args.derep_representatives, sep="\t", dtype=str)
    if "representative" not in derep.columns:
        raise SystemExit("Derep representatives table must contain column: representative")

    derep_ids = set(derep["representative"].dropna().astype(str).map(basename_noext))
    print(f"[info] dereplicated representatives: {len(derep_ids)}")

    fasta_index = index_fastas(fasta_dir)
    print(f"[info] indexed FASTAs: {len(fasta_index)}")

    plasmid_reps = {}
    plasmid_rep_accs = {}

    for summary_file in sorted(mobtyper_dir.glob("*_summary.txt")):
        plasmid_id = summary_file.name.replace("_summary.txt", "")
        if basename_noext(plasmid_id) not in derep_ids:
            continue

        df = pd.read_csv(summary_file, sep="\t", dtype=str, keep_default_na=False)
        if df.empty:
            continue

        rep_col = first_existing(df.columns, ["rep_type(s)", "replicon_types", "rep_types"])
        acc_col = first_existing(df.columns, ["rep_type_accession(s)", "rep_type_accessions", "rep_accession(s)"])
        if rep_col is None or acc_col is None:
            continue

        row = df.iloc[0]
        reps = split_list(row.get(rep_col, ""))
        accs = split_list(row.get(acc_col, ""))

        if len(reps) >= 2:
            plasmid_reps[plasmid_id] = reps
            plasmid_rep_accs[plasmid_id] = accs

    print(f"[info] representative plasmids with >=2 replicons: {len(plasmid_reps)}")

    pair_to_plasmids = defaultdict(list)
    for plasmid_id, reps in plasmid_reps.items():
        for a, b in combinations(sorted(set(reps)), 2):
            pair_to_plasmids[(a, b)].append(plasmid_id)

    selected = {k: v for k, v in pair_to_plasmids.items() if len(v) >= args.min_count}
    print(f"[info] pairs with count >= {args.min_count}: {len(selected)}")

    pair_summary = pd.DataFrame([
        {"repA": a, "repB": b, "pair": f"{clean_tag(a)}__{clean_tag(b)}", "n_plasmids": len(v)}
        for (a, b), v in selected.items()
    ]).sort_values("n_plasmids", ascending=False)
    pair_summary.to_csv(outdir / "multireplicon_pair_counts.tsv", sep="\t", index=False)

    extraction_rows = []
    alignment_rows = []

    for (repA, repB), plasmids in selected.items():
        pair_name = f"{clean_tag(repA)}__{clean_tag(repB)}"
        pair_dir = outdir / pair_name
        pair_dir.mkdir(parents=True, exist_ok=True)

        for plasmid_id in plasmids:
            analysis_dir = mobtyper_dir / f"{plasmid_id}_analysis"
            blast_file = analysis_dir / "replicon_blast_results.txt"
            if not blast_file.exists():
                extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "status": "missing_blast"})
                continue

            fasta_path = find_fasta(plasmid_id, fasta_index, fasta_dir)
            if fasta_path is None:
                extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "status": "missing_fasta"})
                continue

            try:
                seq_record = read_single_sequence(fasta_path)
                blast_df = pd.read_csv(blast_file, sep="\t", dtype=str, keep_default_na=False)
                for c in ["sstart", "send", "bitscore"]:
                    if c in blast_df.columns:
                        blast_df[c] = pd.to_numeric(blast_df[c], errors="coerce")

                for rep_type in [repA, repB]:
                    rep_acc = map_type_to_accession(plasmid_reps, plasmid_rep_accs, plasmid_id, rep_type)
                    if not rep_acc:
                        extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "replicon": rep_type, "status": "missing_rep_accession"})
                        continue

                    hit = find_best_hit(blast_df, rep_acc)
                    if hit is None:
                        extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "replicon": rep_type, "rep_accession": rep_acc, "status": "missing_blast_hit"})
                        continue

                    subseq, sstart, send, sstrand = extract_hit_sequence(seq_record, hit)
                    tag = clean_tag(rep_type)
                    out_fa = pair_dir / f"{plasmid_id}__{tag}.fa"

                    with open(out_fa, "w") as oh:
                        oh.write(
                            f">{plasmid_id}|{rep_type}|qseqid:{hit.get('qseqid','')}|"
                            f"sstart:{sstart}|send:{send}|sstrand:{sstrand}\n"
                        )
                        oh.write(str(subseq) + "\n")

                    extraction_rows.append({
                        "pair": pair_name,
                        "plasmid_id": plasmid_id,
                        "replicon": rep_type,
                        "rep_accession": rep_acc,
                        "source_fasta": str(fasta_path),
                        "blast_file": str(blast_file),
                        "sstart": sstart,
                        "send": send,
                        "sstrand": sstrand,
                        "out_fasta": str(out_fa),
                        "status": "ok",
                    })

            except Exception as e:
                extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "status": "failed", "error": str(e)})

        for rep_type in [repA, repB]:
            tag = clean_tag(rep_type)
            files = list(pair_dir.glob(f"*__{tag}.fa"))
            concat = pair_dir / f"{tag}_all.fa"
            aligned = pair_dir / f"{tag}_all_aligned.fasta"
            nseq = concatenate_fastas(files, concat)

            status = "not_run"
            used_aligner = ""
            if nseq >= 4 and not args.skip_align:
                try:
                    used_aligner = run_alignment(concat, aligned, threads=args.threads, aligner=args.aligner)
                    status = "aligned"
                except Exception as e:
                    status = "alignment_failed"
                    used_aligner = str(e)
            elif nseq < 4:
                status = "too_few_sequences"

            alignment_rows.append({
                "pair": pair_name,
                "replicon": rep_type,
                "n_sequences": nseq,
                "concat_fasta": str(concat),
                "aligned_fasta": str(aligned),
                "status": status,
                "aligner": used_aligner,
            })

    pd.DataFrame(extraction_rows).to_csv(outdir / "multireplicon_extraction_summary.tsv", sep="\t", index=False)
    pd.DataFrame(alignment_rows).to_csv(outdir / "multireplicon_alignment_summary.tsv", sep="\t", index=False)
    print("[done] Multireplicon FASTA extraction and alignment complete.")


if __name__ == "__main__":
    main()
