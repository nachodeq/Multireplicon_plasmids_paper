#!/usr/bin/env python3
import os
import glob
import pandas as pd
from Bio import SeqIO

# ============================================================
# CONFIG
# ============================================================
BASE_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/control_mantel"

USABLE_FILE = os.path.join(BASE_DIR, "control_mantel_usable_observations.tsv")
MOB_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/mobtyper"
FASTAS_SRC = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/fasta"

OUT_DIR = os.path.join(BASE_DIR, "control_fastas")
os.makedirs(OUT_DIR, exist_ok=True)

SUMMARY_OUT = os.path.join(BASE_DIR, "control_fastas_summary.tsv")
FAIL_OUT = os.path.join(BASE_DIR, "control_fastas_failures.tsv")

# ============================================================
# HELPERS
# ============================================================
def basename_noext(x):
    if pd.isna(x):
        return x
    name = str(x).split()[0]
    name = os.path.basename(name)
    for ext in [
        ".faa", ".fna", ".ffn", ".gb", ".gbk",
        ".fasta", ".fa",
        ".faa.gz", ".fna.gz", ".fasta.gz", ".fa.gz"
    ]:
        if name.endswith(ext):
            name = name[:-len(ext)]
    return name

def rep_tag(rep_type):
    return (
        str(rep_type)
        .replace(",", "_")
        .replace(" ", "_")
        .replace("/", "_")
    )

def load_single_contig_fasta(fasta_path):
    with open(fasta_path) as fh:
        seqs = list(SeqIO.parse(fh, "fasta"))
    if len(seqs) == 0:
        raise ValueError(f"No sequences found in FASTA: {fasta_path}")
    if len(seqs) > 1:
        print(f"Warning: FASTA {fasta_path} has {len(seqs)} contigs; using first one")
    return seqs[0]

def find_fasta_for_plasmid(plasmid_acc, fasta_index):
    bacc = basename_noext(plasmid_acc)
    if bacc in fasta_index:
        return fasta_index[bacc]
    matches = glob.glob(os.path.join(FASTAS_SRC, f"*{bacc}*"))
    if matches:
        return matches[0]
    return None

def find_best_hit_for_replicon(blast_df, rep_type):
    if "qseqid" not in blast_df.columns:
        raise ValueError("replicon_blast_results.txt lacks qseqid column")

    qseq = blast_df["qseqid"].astype(str)
    matches = blast_df[qseq.str.contains(rep_type, na=False, regex=False)].copy()

    if matches.empty:
        raise ValueError(f"No blast hits found for replicon type '{rep_type}'")

    if "bitscore" in matches.columns:
        matches["bitscore"] = pd.to_numeric(matches["bitscore"], errors="coerce")
        if matches["bitscore"].notna().any():
            return matches.loc[matches["bitscore"].idxmax()]

    return matches.iloc[0]

def extract_hit_sequence(seq_record, hit):
    sstart = int(hit["sstart"])
    send = int(hit["send"])
    sstrand = str(hit.get("sstrand", "plus"))
    seq_len = len(seq_record.seq)

    if sstart < 1 or send < 1 or sstart > seq_len or send > seq_len:
        raise ValueError(
            f"Coordinates out of range: sstart={sstart}, send={send}, len={seq_len}"
        )

    a = min(sstart, send) - 1
    b = max(sstart, send)
    subseq = seq_record.seq[a:b]

    if sstrand.lower() == "minus":
        subseq = subseq.reverse_complement()

    return subseq, sstart, send, sstrand

def resolve_one(replicon, plasmid, fasta_index):
    analysis_dir = os.path.join(MOB_DIR, plasmid + "_analysis")
    blast_file = os.path.join(analysis_dir, "replicon_blast_results.txt")
    if not os.path.exists(blast_file):
        raise FileNotFoundError(f"Missing blast file: {blast_file}")

    blast_df = pd.read_csv(blast_file, sep="\t", dtype=str)
    for c in ["sstart", "send", "bitscore"]:
        if c in blast_df.columns:
            blast_df[c] = pd.to_numeric(blast_df[c], errors="coerce")

    fasta_path = find_fasta_for_plasmid(plasmid, fasta_index)
    if fasta_path is None:
        raise FileNotFoundError(f"FASTA not found for plasmid: {plasmid}")

    seq_record = load_single_contig_fasta(fasta_path)
    hit = find_best_hit_for_replicon(blast_df, replicon)
    subseq, sstart, send, sstrand = extract_hit_sequence(seq_record, hit)

    return {
        "replicon": replicon,
        "plasmid": plasmid,
        "fasta_path": fasta_path,
        "blast_file": blast_file,
        "hit": hit,
        "subseq": subseq,
        "sstart": sstart,
        "send": send,
        "sstrand": sstrand,
    }

# ============================================================
# LOAD INPUTS
# ============================================================
usable = pd.read_csv(USABLE_FILE, sep="\t", dtype=str).fillna("")
print(f"Usable observations: {len(usable)}")

fasta_index = {}
for p in glob.glob(os.path.join(FASTAS_SRC, "*")):
    b = basename_noext(p)
    if b not in fasta_index:
        fasta_index[b] = p

rows_out = []
fail_rows = []
n_ok = 0
n_fail = 0

# ============================================================
# MAIN LOOP
# ============================================================
for _, row in usable.iterrows():
    assembly_acc = row["ASSEMBLY_ACC"]
    pair = row["pair"]
    repA = row["repA"]
    repB = row["repB"]
    plasmidA = row["repA_control_plasmid"]
    plasmidB = row["repB_control_plasmid"]

    pair_dir = os.path.join(OUT_DIR, pair)
    os.makedirs(pair_dir, exist_ok=True)

    outA = os.path.join(pair_dir, f"{assembly_acc}__{rep_tag(repA)}.fa")
    outB = os.path.join(pair_dir, f"{assembly_acc}__{rep_tag(repB)}.fa")

    if os.path.exists(outA) and os.path.exists(outB):
        continue

    try:
        # resolve both first
        resA = resolve_one(repA, plasmidA, fasta_index)
        resB = resolve_one(repB, plasmidB, fasta_index)

        # write only if both succeeded
        with open(outA, "w") as oh:
            hitA = resA["hit"]
            oh.write(
                f">{assembly_acc}|{repA}|plasmid:{plasmidA}"
                f"|qseqid:{hitA.get('qseqid','')}"
                f"|sseqid:{hitA.get('sseqid','')}"
                f"|sstart:{resA['sstart']}|send:{resA['send']}|sstrand:{resA['sstrand']}\n"
            )
            oh.write(str(resA["subseq"]) + "\n")

        with open(outB, "w") as oh:
            hitB = resB["hit"]
            oh.write(
                f">{assembly_acc}|{repB}|plasmid:{plasmidB}"
                f"|qseqid:{hitB.get('qseqid','')}"
                f"|sseqid:{hitB.get('sseqid','')}"
                f"|sstart:{resB['sstart']}|send:{resB['send']}|sstrand:{resB['sstrand']}\n"
            )
            oh.write(str(resB["subseq"]) + "\n")

        rows_out.extend([
            {
                "ASSEMBLY_ACC": assembly_acc,
                "pair": pair,
                "replicon": repA,
                "source_plasmid": plasmidA,
                "source_fasta": resA["fasta_path"],
                "blast_file": resA["blast_file"],
                "qseqid": resA["hit"].get("qseqid", ""),
                "sseqid": resA["hit"].get("sseqid", ""),
                "sstart": resA["sstart"],
                "send": resA["send"],
                "sstrand": resA["sstrand"],
                "out_fasta": outA,
            },
            {
                "ASSEMBLY_ACC": assembly_acc,
                "pair": pair,
                "replicon": repB,
                "source_plasmid": plasmidB,
                "source_fasta": resB["fasta_path"],
                "blast_file": resB["blast_file"],
                "qseqid": resB["hit"].get("qseqid", ""),
                "sseqid": resB["hit"].get("sseqid", ""),
                "sstart": resB["sstart"],
                "send": resB["send"],
                "sstrand": resB["sstrand"],
                "out_fasta": outB,
            }
        ])

        n_ok += 1
        if n_ok % 100 == 0:
            print(f"Processed {n_ok} observations successfully")

    except Exception as e:
        n_fail += 1
        fail_rows.append({
            "ASSEMBLY_ACC": assembly_acc,
            "pair": pair,
            "repA": repA,
            "repB": repB,
            "plasmidA": plasmidA,
            "plasmidB": plasmidB,
            "error": str(e),
        })

# ============================================================
# SAVE OUTPUTS
# ============================================================
pd.DataFrame(rows_out).to_csv(SUMMARY_OUT, sep="\t", index=False)
pd.DataFrame(fail_rows).to_csv(FAIL_OUT, sep="\t", index=False)

print(f"Done. Successful observations: {n_ok}")
print(f"Failed observations: {n_fail}")
print(f"Summary written to: {SUMMARY_OUT}")
print(f"Failures written to: {FAIL_OUT}")
