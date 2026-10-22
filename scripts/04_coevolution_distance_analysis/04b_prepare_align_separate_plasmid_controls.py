#!/usr/bin/env python3
"""
04b_prepare_align_separate_plasmid_controls.py

Prepare and align replicon sequences for the separate-plasmid control Mantel analysis.

This consolidates the functions of:
- buildusablepairs.py
- fetchfastas2.py
- control alignment helper scripts

It does only the upstream preparation needed for Figure 4f:
1. Load Mantel pairs observed in multireplicon plasmids.
2. Search assemblies where those same replicon pairs coexist in the same assembly.
3. Retain observations where repA and repB occur on two separate plasmids
   with a unique source plasmid for each replicon.
4. Extract the corresponding replicon sequences using MOB-typer BLAST coordinates.
5. Concatenate sequences per replicon per pair.
6. Run MUSCLE or MAFFT to generate aligned FASTA files.

It does NOT:
- build trees
- calculate Mantel tests
- plot figures
"""

from __future__ import annotations

import argparse
import sys
import ast
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


def safe_eval_list(x: object) -> list:
    if pd.isna(x):
        return []
    if isinstance(x, list):
        return x
    if isinstance(x, str):
        try:
            value = ast.literal_eval(x)
            return value if isinstance(value, list) else [value]
        except Exception:
            return []
    return []


def parse_reps(x: object) -> list[str]:
    if pd.isna(x):
        return []
    return [r.strip() for r in str(x).split(",") if r.strip()]


def canon_pair(a: object, b: object) -> str:
    a, b = sorted([str(a).strip(), str(b).strip()])
    return f"{clean_tag(a)}__{clean_tag(b)}"


def clean_mantel_rep(x: object) -> str:
    s = str(x).strip()
    for suffix in ["_all_aligned.fasta", "_all_aligned.fa", "_aligned.fasta", "_aligned.fa", ".fasta", ".fa"]:
        if s.endswith(suffix):
            s = s[: -len(suffix)]
    return s


def first_existing(columns: Iterable[str], candidates: Iterable[str]) -> str | None:
    cols = set(columns)
    lower = {c.lower(): c for c in columns}
    for c in candidates:
        if c in cols:
            return c
        if c.lower() in lower:
            return lower[c.lower()]
    return None


def read_table(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    if path.suffix.lower() in {".xlsx", ".xls"}:
        return pd.read_excel(path)
    if path.suffix.lower() == ".csv":
        return pd.read_csv(path)
    return pd.read_csv(path, sep="\t")


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
# Build usable control observations
# ============================================================

def load_mantel_pairs(path: Path) -> pd.DataFrame:
    df = read_table(path)
    repA_col = first_existing(df.columns, ["repA", "replicon_1", "rep1", "rep_a"])
    repB_col = first_existing(df.columns, ["repB", "replicon_2", "rep2", "rep_b"])
    pair_col = first_existing(df.columns, ["pair", "rep_pair", "pair_clean"])

    if repA_col and repB_col:
        out = df.copy()
        out["repA"] = out[repA_col].map(clean_mantel_rep)
        out["repB"] = out[repB_col].map(clean_mantel_rep)
        out["pair"] = out.apply(lambda r: canon_pair(r["repA"], r["repB"]), axis=1)
    elif pair_col:
        rows = []
        for x in df[pair_col].astype(str):
            y = x.replace(" | ", "__").replace("||", "__")
            parts = [clean_mantel_rep(p) for p in y.split("__") if p]
            if len(parts) == 2:
                rows.append({"repA": parts[0], "repB": parts[1], "pair": canon_pair(parts[0], parts[1])})
        out = pd.DataFrame(rows)
    else:
        raise SystemExit("Mantel results require repA/repB or pair column.")

    return out[["repA", "repB", "pair"]].drop_duplicates("pair")


def build_control_table(nuccore_path: Path, assembly_path: Path, typing_path: Path, mantel_pairs: pd.DataFrame):
    nuccore = pd.read_csv(nuccore_path)
    assembly = pd.read_csv(assembly_path)
    typing = pd.read_csv(typing_path)

    n_uid = first_existing(nuccore.columns, ["NUCCORE_UID"])
    n_acc = first_existing(nuccore.columns, ["NUCCORE_ACC"])
    a_acc = first_existing(assembly.columns, ["ASSEMBLY_ACC"])
    a_uid = first_existing(assembly.columns, ["NUCCORE_UID"])
    t_acc = first_existing(typing.columns, ["NUCCORE_ACC"])
    t_rep = first_existing(typing.columns, ["rep_type(s)", "replicon_types", "rep_types"])

    required = [n_uid, n_acc, a_acc, a_uid, t_acc, t_rep]
    if any(x is None for x in required):
        raise SystemExit("Missing required columns in nuccore/assembly/typing tables.")

    nuccore2 = pd.DataFrame({
        "NUCCORE_UID": nuccore[n_uid].astype(str),
        "NUCCORE_ACC": nuccore[n_acc].map(basename_noext),
    }).drop_duplicates()

    assembly2 = pd.DataFrame({
        "ASSEMBLY_ACC": assembly[a_acc].astype(str),
        "NUCCORE_UID": assembly[a_uid].apply(safe_eval_list),
    })
    assembly2 = assembly2.explode("NUCCORE_UID").dropna(subset=["NUCCORE_UID"])
    assembly2["NUCCORE_UID"] = assembly2["NUCCORE_UID"].astype(str)

    typing2 = pd.DataFrame({
        "NUCCORE_ACC": typing[t_acc].map(basename_noext),
        "rep_type(s)": typing[t_rep].astype(str),
    }).drop_duplicates("NUCCORE_ACC")

    df = assembly2.merge(nuccore2, on="NUCCORE_UID", how="left")
    df = df.merge(typing2, on="NUCCORE_ACC", how="left")
    df["rep_types"] = df["rep_type(s)"].apply(parse_reps)
    df_long = df.explode("rep_types").dropna(subset=["rep_types"]).reset_index(drop=True)

    target_pairs = set(mantel_pairs["pair"])
    rows = []

    for assembly_acc, sub in df_long.groupby("ASSEMBLY_ACC"):
        plasmids = sub.groupby("NUCCORE_ACC")["rep_types"].apply(lambda x: set(x)).to_dict()
        if not plasmids:
            continue

        reps_in_cell = set().union(*plasmids.values())
        for a, b in combinations(sorted(reps_in_cell), 2):
            pair = canon_pair(a, b)
            if pair not in target_pairs:
                continue

            plasmids_with_a = sorted([p for p, reps in plasmids.items() if a in reps])
            plasmids_with_b = sorted([p for p, reps in plasmids.items() if b in reps])

            shared = sorted(set(plasmids_with_a) & set(plasmids_with_b))
            a_only = sorted(set(plasmids_with_a) - set(shared))
            b_only = sorted(set(plasmids_with_b) - set(shared))

            same_plasmid = len(shared) > 0
            has_separated = len(a_only) > 0 and len(b_only) > 0
            unique_separated = len(a_only) == 1 and len(b_only) == 1

            if same_plasmid and not has_separated:
                status = "same_plasmid_only"
            elif (not same_plasmid) and unique_separated:
                status = "separated_unique"
            elif (not same_plasmid) and has_separated:
                status = "separated_ambiguous"
            elif same_plasmid and has_separated:
                status = "mixed_same_and_separated"
            else:
                status = "other"

            rows.append({
                "ASSEMBLY_ACC": assembly_acc,
                "pair": pair,
                "repA": a,
                "repB": b,
                "same_plasmid": int(same_plasmid),
                "has_separated": int(has_separated),
                "status": status,
                "plasmids_with_repA": ";".join(plasmids_with_a),
                "plasmids_with_repB": ";".join(plasmids_with_b),
                "shared_plasmids": ";".join(shared),
                "repA_separate_plasmids": ";".join(a_only),
                "repB_separate_plasmids": ";".join(b_only),
                "repA_control_plasmid": a_only[0] if len(a_only) == 1 else "",
                "repB_control_plasmid": b_only[0] if len(b_only) == 1 else "",
            })

    master = pd.DataFrame(rows)
    usable = master[master["status"] == "separated_unique"].copy() if not master.empty else pd.DataFrame()
    return master, usable


# ============================================================
# Main
# ============================================================

def main() -> None:
    ap = argparse.ArgumentParser(description="Prepare and align separate-plasmid control replicon pairs for Mantel analysis.")
    ap.add_argument("--nuccore", required=True)
    ap.add_argument("--assembly", required=True)
    ap.add_argument("--typing", required=True)
    ap.add_argument("--mantel-results", required=True, help="Multireplicon Mantel results; used to identify target pairs.")
    ap.add_argument("--mobtyper-dir", required=True)
    ap.add_argument("--mob-suite-utils", type=Path, help="Native MOB-suite 3.1.9 utils.py; otherwise use installed mob_suite.")
    ap.add_argument("--fasta-dir", required=True)
    ap.add_argument("--outdir", required=True)
    ap.add_argument("--threads", type=int, default=8)
    ap.add_argument("--aligner", choices=["auto", "muscle", "mafft"], default="auto")
    ap.add_argument("--skip-align", action="store_true")
    args = ap.parse_args()
    utils_path=native_path(args.mob_suite_utils)
    native=native_functions(str(utils_path))
    marker_cache={}

    outdir = Path(args.outdir)
    if outdir.exists() and any(outdir.iterdir()):
        raise SystemExit("Use a new or empty output directory; do not mix corrected markers with previous extraction outputs.")
    outdir.mkdir(parents=True, exist_ok=True)
    write_provenance(outdir,utils_path)

    mobtyper_dir = Path(args.mobtyper_dir)
    fasta_dir = Path(args.fasta_dir)

    mantel_pairs = load_mantel_pairs(Path(args.mantel_results))
    master, usable = build_control_table(
        Path(args.nuccore),
        Path(args.assembly),
        Path(args.typing),
        mantel_pairs,
    )

    master.to_csv(outdir / "control_mantel_cell_contexts.tsv", sep="\t", index=False)
    usable.to_csv(outdir / "control_mantel_usable_observations.tsv", sep="\t", index=False)

    if usable.empty:
        print("[done] No usable separated controls found.")
        return

    pair_summary = (
        usable.groupby(["pair", "repA", "repB"], as_index=False)
        .agg(n_usable_observations=("ASSEMBLY_ACC", "nunique"))
        .sort_values("n_usable_observations", ascending=False)
    )
    pair_summary.to_csv(outdir / "control_mantel_pair_summary.tsv", sep="\t", index=False)

    fasta_index = index_fastas(fasta_dir)
    extraction_rows = []
    alignment_rows = []

    for row in usable.itertuples(index=False):
        pair_dir = outdir / row.pair
        pair_dir.mkdir(parents=True, exist_ok=True)

        jobs = [
            ("repA", row.repA, row.repA_control_plasmid),
            ("repB", row.repB, row.repB_control_plasmid),
        ]

        for label, rep, plasmid_id in jobs:
            try:
                plasmid_id=resolve_cached_id(plasmid_id,mobtyper_dir)
                blast_file = mobtyper_dir / f"{plasmid_id}_analysis" / "replicon_blast_results.txt"
                if not blast_file.exists():
                    raise FileNotFoundError(f"Missing BLAST file: {blast_file}")

                fasta_path = find_fasta(plasmid_id, fasta_index, fasta_dir)
                if fasta_path is None:
                    raise FileNotFoundError(f"Missing FASTA for plasmid: {plasmid_id}")

                seq_record = read_single_sequence(fasta_path)
                if plasmid_id not in marker_cache:
                    marker_cache[plasmid_id]=final_markers(mobtyper_dir,plasmid_id,native)
                assignments,chosen=marker_cache[plasmid_id]
                if rep not in assignments:raise ValueError(f'Cached final MOB summary does not assign type {rep}')
                hit=chosen[rep]

                subseq, sstart, send, sstrand = extract_hit_sequence(seq_record, hit)
                tag = clean_tag(rep)
                out_fa = pair_dir / f"{row.ASSEMBLY_ACC}__{tag}.fa"

                with open(out_fa, "w") as oh:
                    oh.write(
                        f">{row.ASSEMBLY_ACC}|{rep}|plasmid:{plasmid_id}|"
                        f"qseqid:{hit.get('qseqid','')}|sstart:{sstart}|send:{send}|sstrand:{sstrand}|plasmid_length:{len(seq_record.seq)}|marker_selection:final_MOB_HSP\n"
                    )
                    oh.write(str(subseq) + "\n")

                extraction_rows.append({
                    "pair": row.pair,
                    "ASSEMBLY_ACC": row.ASSEMBLY_ACC,
                    "replicon": rep,
                    "source_plasmid": plasmid_id,
                    "source_fasta": str(fasta_path),
                    "blast_file": str(blast_file),
                    "rep_accession": assignments[rep],
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
                extraction_rows.append({
                    "pair": row.pair,
                    "ASSEMBLY_ACC": row.ASSEMBLY_ACC,
                    "replicon": rep,
                    "source_plasmid": plasmid_id,
                    "status": "failed",
                    "error": str(e),
                })

    pd.DataFrame(extraction_rows).to_csv(outdir / "control_extraction_summary.tsv", sep="\t", index=False)

    if any(row['status']!='ok' for row in extraction_rows):
        raise SystemExit('Corrected marker extraction failed; inspect control_extraction_summary.tsv. No alignment launched.')

    for pair, sub in usable.groupby("pair"):
        pair_dir = outdir / pair
        for rep in sorted(set(sub["repA"]) | set(sub["repB"])):
            tag = clean_tag(rep)
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
                "pair": pair,
                "replicon": rep,
                "n_sequences": nseq,
                "concat_fasta": str(concat),
                "aligned_fasta": str(aligned),
                "status": status,
                "aligner": used_aligner,
            })

    pd.DataFrame(alignment_rows).to_csv(outdir / "control_alignment_summary.tsv", sep="\t", index=False)
    print("[done] Separate-plasmid control FASTA extraction and alignment complete.")


if __name__ == "__main__":
    main()
