#!/usr/bin/env python3
"""
04a_prepare_align_multireplicon_replicons.py

Prepare and align replicon sequences for the multireplicon Mantel analysis.

This consolidates the functions of:
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
import sys
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

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'shared'))
from replicon_markers import assigned_references,final_markers,native_path,native_functions,extract_sequence,write_provenance,resolve_cached_id,find_nucleotide_fasta


# ============================================================
# Helpers
# ============================================================

def clean_tag(s: object) -> str:
    return re.sub(r"[^A-Za-z0-9_]+", "_", str(s).strip())


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


def find_fasta(plasmid_id,fasta_index,fasta_dir):
    return find_nucleotide_fasta(plasmid_id,fasta_dir)


def read_single_sequence(fasta_path: Path):
    seqs = list(SeqIO.parse(str(fasta_path), "fasta"))
    if not seqs:
        raise ValueError(f"No sequences found in FASTA: {fasta_path}")
    if len(seqs) > 1:
        raise ValueError(f"Expected one nucleotide FASTA record: {fasta_path}")
    return seqs[0]


def map_type_to_accession(plasmid_reps: dict, plasmid_rep_accs: dict, plasmid_id: str, rep_type: str) -> str | None:
    types = plasmid_reps.get(plasmid_id, [])
    accs = plasmid_rep_accs.get(plasmid_id, [])

    for i, t in enumerate(types):
        if rep_type == t:
            if i < len(accs):
                return accs[i]
    return None


def extract_hit_sequence(seq_record,hit):
    sequence=extract_sequence(seq_record.seq,hit)
    return sequence,int(hit.sstart),int(hit.send),str(hit.sstrand)


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
    ap.add_argument("--mob-suite-utils", type=Path, help="Native MOB-suite 3.1.9 utils.py; otherwise use installed mob_suite.")
    ap.add_argument("--fasta-dir", required=True)
    ap.add_argument("--derep-representatives", required=True, help="TSV with column 'representative'.")
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--min-count", type=int, default=5)
    ap.add_argument("--threads", type=int, default=8)
    ap.add_argument("--aligner", choices=["auto", "muscle", "mafft"], default="auto")
    ap.add_argument("--skip-align", action="store_true", help="Extract and concatenate only; do not run aligner.")
    args = ap.parse_args()
    utils_path=native_path(args.mob_suite_utils)
    native=native_functions(str(utils_path))
    marker_cache={}

    mobtyper_dir = Path(args.mobtyper_dir)
    fasta_dir = Path(args.fasta_dir)
    outdir = Path(args.outdir)
    if outdir.exists() and any(outdir.iterdir()):
        raise SystemExit("Use a new or empty output directory; do not mix corrected markers with previous extraction outputs.")
    outdir.mkdir(parents=True, exist_ok=True)
    write_provenance(outdir,utils_path)

    derep = pd.read_csv(args.derep_representatives, sep="\t", dtype=str)
    if "representative" not in derep.columns:
        raise SystemExit("Derep representatives table must contain column: representative")

    def representative_accession(value):
        name=Path(str(value).strip()).name
        for suffix in ['.fasta','.fna','.fa']:
            if name.endswith(suffix):return name[:-len(suffix)]
        return name
    derep_ids=set(derep['representative'].dropna().map(representative_accession))
    available=[p.name[:-len('_summary.txt')] for p in mobtyper_dir.glob('*_summary.txt')]
    for identifier in list(derep_ids):
        if identifier not in available and not ('.' in identifier and identifier.rsplit('.',1)[1].isdigit()):
            derep_ids.remove(identifier);derep_ids.add(resolve_cached_id(identifier,mobtyper_dir))
    print(f"[info] dereplicated representatives: {len(derep_ids)}")

    fasta_index = index_fastas(fasta_dir)
    print(f"[info] indexed FASTAs: {len(fasta_index)}")

    plasmid_reps = {}
    plasmid_rep_accs = {}

    for summary_file in sorted(mobtyper_dir.glob("*_summary.txt")):
        plasmid_id = summary_file.name.replace("_summary.txt", "")
        if plasmid_id not in derep_ids:
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

    if not selected:
        pd.DataFrame(columns=["repA","repB","pair","n_plasmids"]).to_csv(outdir/"multireplicon_pair_counts.tsv",sep="\t",index=False)
        print("[done] No eligible distinct-type pairs.");return

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
                if plasmid_id not in marker_cache:
                    marker_cache[plasmid_id]=final_markers(mobtyper_dir,plasmid_id,native)
                assignments,chosen=marker_cache[plasmid_id]

                for rep_type in [repA, repB]:
                    rep_acc = map_type_to_accession(plasmid_reps, plasmid_rep_accs, plasmid_id, rep_type)
                    if not rep_acc:
                        extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "replicon": rep_type, "status": "missing_rep_accession"})
                        continue

                    hit = chosen.get(rep_type)
                    if assignments.get(rep_type)!=rep_acc:raise ValueError("Assigned summary reference changed during extraction")
                    if hit is None:
                        extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "replicon": rep_type, "rep_accession": rep_acc, "status": "missing_blast_hit"})
                        continue

                    subseq, sstart, send, sstrand = extract_hit_sequence(seq_record, hit)
                    tag = clean_tag(rep_type)
                    out_fa = pair_dir / f"{plasmid_id}__{tag}.fa"

                    with open(out_fa, "w") as oh:
                        oh.write(
                            f">{plasmid_id}|{rep_type}|qseqid:{hit.get('qseqid','')}|"
                            f"sstart:{sstart}|send:{send}|sstrand:{sstrand}|plasmid_length:{len(seq_record.seq)}|marker_selection:final_MOB_HSP\n"
                        )
                        oh.write(str(subseq) + "\n")

                    extraction_rows.append({
                        "pair": pair_name,
                        "plasmid_id": plasmid_id,
                        "replicon": rep_type,
                        "rep_accession": rep_acc,
                        "source_fasta": str(fasta_path),
                        "blast_file": str(blast_file),
                        "qseqid": str(hit.qseqid),
                        "bitscore": float(hit.bitscore),
                        "plasmid_length": len(seq_record.seq),
                        "sstart": sstart,
                        "send": send,
                        "sstrand": sstrand,
                        "out_fasta": str(out_fa),
                        "status": "ok",
                    })

            except Exception as e:
                extraction_rows.append({"pair": pair_name, "plasmid_id": plasmid_id, "status": "failed", "error": str(e)})

    pd.DataFrame(extraction_rows).to_csv(outdir / "multireplicon_extraction_summary.tsv", sep="\t", index=False)
    if any(row['status']!='ok' for row in extraction_rows):
        raise SystemExit('Corrected marker extraction failed; inspect multireplicon_extraction_summary.tsv. No alignment launched.')
    for (repA,repB),plasmids in selected.items():
        pair_name=f'{clean_tag(repA)}__{clean_tag(repB)}'
        pair_dir=outdir/pair_name
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

    pd.DataFrame(alignment_rows).to_csv(outdir / "multireplicon_alignment_summary.tsv", sep="\t", index=False)
    print("[done] Multireplicon FASTA extraction and alignment complete.")


if __name__ == "__main__":
    main()
