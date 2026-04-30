#!/usr/bin/env python3

import os
import re
import pandas as pd

# ============================================================
# PATHS
# ============================================================

ALIGN_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3/ALIGNBREAKPOINTS"
BASE_DIR  = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"

SUMMARY_PATH = os.path.join(ALIGN_DIR, "FULL_hyper_blast_bestlen_summary.tsv")

HW = 1000
THRESHOLD = 100

OUT_QUERY_FASTA   = os.path.join(ALIGN_DIR, f"best_hsp_query_hw{HW}_ge{THRESHOLD}.fa")
OUT_SUBJECT_FASTA = os.path.join(ALIGN_DIR, f"best_hsp_subject_hw{HW}_ge{THRESHOLD}.fa")
OUT_BOTH_FASTA    = os.path.join(ALIGN_DIR, f"best_hsp_both_hw{HW}_ge{THRESHOLD}.fa")
OUT_TABLE         = os.path.join(ALIGN_DIR, f"best_hsp_table_hw{HW}_ge{THRESHOLD}.tsv")

BLAST_COLS = [
    "qseqid", "sseqid",
    "qstart", "qend",
    "sstart", "send",
    "length", "pident",
    "mismatch", "gapopen",
    "evalue", "bitscore"
]

# ============================================================
# HELPERS
# ============================================================

def read_fasta_seq(path):
    seq = []
    with open(path) as f:
        for line in f:
            if not line.startswith(">"):
                seq.append(line.strip())
    return "".join(seq)

def revcomp(seq):
    table = str.maketrans("ACGTacgtNn", "TGCAtgcaNn")
    return seq.translate(table)[::-1]

def subseq_1based(seq, start, end):
    a = min(start, end)
    b = max(start, end)
    return seq[a-1:b]

def wrap_fasta(seq, width=80):
    return "\n".join(seq[i:i+width] for i in range(0, len(seq), width))

def pick_best_hit(tsv_path):
    if (not os.path.exists(tsv_path)) or os.path.getsize(tsv_path) == 0:
        return None

    hits = pd.read_csv(tsv_path, sep="\t", names=BLAST_COLS)
    if hits.empty:
        return None

    best = hits.sort_values(
        ["length", "bitscore", "pident"],
        ascending=[False, False, False]
    ).iloc[0]

    return best

# ============================================================
# MAIN
# ============================================================

summary = pd.read_csv(SUMMARY_PATH, sep="\t")

sub = summary[
    (summary["window_hw"] == HW) &
    (summary["category"] == "bp") &
    (summary["best_len"] >= THRESHOLD)
].copy()

print("Selected pairs:", len(sub))

rows = []

with open(OUT_QUERY_FASTA, "w") as fq, open(OUT_SUBJECT_FASTA, "w") as fs, open(OUT_BOTH_FASTA, "w") as fb:

    for _, row in sub.iterrows():
        pair_id = int(row["pair_id"])

        bp1 = pair_id * 2
        bp2 = pair_id * 2 + 1

        fa1 = f"{BASE_DIR}/FULL_hyper_{HW}/bp_{bp1}.fa"
        fa2 = f"{BASE_DIR}/FULL_hyper_{HW}/bp_{bp2}.fa"
        blast_tsv = row["blast_tsv"]

        if not os.path.exists(fa1) or not os.path.exists(fa2):
            continue

        best = pick_best_hit(blast_tsv)
        if best is None:
            continue

        seq1 = read_fasta_seq(fa1)
        seq2 = read_fasta_seq(fa2)

        qseq = subseq_1based(seq1, int(best["qstart"]), int(best["qend"]))
        sseq = subseq_1based(seq2, int(best["sstart"]), int(best["send"]))

        q_orient = "+" if int(best["qstart"]) <= int(best["qend"]) else "-"
        s_orient = "+" if int(best["sstart"]) <= int(best["send"]) else "-"

        # Normalizamos subject a orientación forward del alineamiento
        if s_orient == "-":
            sseq = revcomp(sseq)

        if q_orient == "-":
            qseq = revcomp(qseq)

        header_base = (
            f"pair{pair_id}"
            f"|len{int(best['length'])}"
            f"|pid{float(best['pident']):.1f}"
            f"|q{int(best['qstart'])}-{int(best['qend'])}"
            f"|s{int(best['sstart'])}-{int(best['send'])}"
        )

        fq.write(f">{header_base}|side=query\n{wrap_fasta(qseq)}\n")
        fs.write(f">{header_base}|side=subject\n{wrap_fasta(sseq)}\n")
        fb.write(f">{header_base}|side=query\n{wrap_fasta(qseq)}\n")
        fb.write(f">{header_base}|side=subject\n{wrap_fasta(sseq)}\n")

        rows.append({
            "pair_id": pair_id,
            "bp1_index": bp1,
            "bp2_index": bp2,
            "fa1": fa1,
            "fa2": fa2,
            "blast_tsv": blast_tsv,
            "best_len": int(best["length"]),
            "best_pident": float(best["pident"]),
            "best_bitscore": float(best["bitscore"]),
            "qstart": int(best["qstart"]),
            "qend": int(best["qend"]),
            "sstart": int(best["sstart"]),
            "send": int(best["send"]),
            "q_orient": q_orient,
            "s_orient": s_orient,
            "query_hsp_seq": qseq,
            "subject_hsp_seq": sseq
        })

pd.DataFrame(rows).to_csv(OUT_TABLE, sep="\t", index=False)

print("Written:")
print(" ", OUT_QUERY_FASTA)
print(" ", OUT_SUBJECT_FASTA)
print(" ", OUT_BOTH_FASTA)
print(" ", OUT_TABLE)
