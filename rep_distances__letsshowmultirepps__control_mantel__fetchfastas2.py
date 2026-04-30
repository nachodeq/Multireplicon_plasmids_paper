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
        ".faa.gz", ".fna.gz", ".fasta.gz"
    ]:
        if name.endswith(ext):
            name = name[:-len(ext)]
    parts = name.split(".")
    if len(parts) > 1 and parts[-1].isdigit():
        name = ".".join(parts[:-1])
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
    """
    Prefer exact/clean token match in qseqid, fallback to rep_type string containment.
    """
    if "qseqid" not in blast_df.columns:
        raise ValueError("replicon_blast_results.txt lacks qseqid column")

    qseq = blast_df["qseqid"].astype(str)

    # strict contains on rep_type
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


# ============================================================
# LOAD INPUTS
# ============================================================
print("Loading usable control observations...")
usable = pd.read_csv(USABLE_FILE, sep="\t", dtype=str).fillna("")

required = {
    "ASSEMBLY_ACC", "pair", "repA", "repB",
    "repA_control_plasmid", "repB_control_plasmid"
}
missing = required - set(usable.columns)
if missing:
    raise ValueError(f"Missing required columns in usable table: {missing}")

print(f"Usable observations: {len(usable)}")

# index plasmid FASTAs
print("Indexing plasmid FASTAs...")
fasta_index = {}
for p in glob.glob(os.path.join(FASTAS_SRC, "*")):
    b = basename_noext(p)
    if b not in fasta_index:
        fasta_index[b] = p

print(f"Indexed {len(fasta_index)} FASTA entries")

rows_out = []
n_ok = 0
n_fail = 0

# ============================================================
# MAIN LOOP
# ============================================================
for i, row in usable.iterrows():
    assembly_acc = row["ASSEMBLY_ACC"]
    pair = row["pair"]
    repA = row["repA"]
    repB = row["repB"]
    plasmidA = row["repA_control_plasmid"]
    plasmidB = row["repB_control_plasmid"]

    pair_dir = os.path.join(OUT_DIR, pair)
    os.makedirs(pair_dir, exist_ok=True)

    try:
        # -------------------------
        # Extract repA from plasmidA
        # -------------------------
        analysis_dir_A = os.path.join(MOB_DIR, plasmidA + "_analysis")
        blast_file_A = os.path.join(analysis_dir_A, "replicon_blast_results.txt")
        if not os.path.exists(blast_file_A):
            raise FileNotFoundError(f"Missing blast file for plasmidA: {blast_file_A}")

        blast_df_A = pd.read_csv(blast_file_A, sep="\t", dtype=str)
        for c in ["sstart", "send", "bitscore"]:
            if c in blast_df_A.columns:
                blast_df_A[c] = pd.to_numeric(blast_df_A[c], errors="coerce")

        fasta_path_A = find_fasta_for_plasmid(plasmidA, fasta_index)
        if fasta_path_A is None:
            raise FileNotFoundError(f"FASTA not found for plasmidA: {plasmidA}")

        seq_record_A = load_single_contig_fasta(fasta_path_A)
        hit_A = find_best_hit_for_replicon(blast_df_A, repA)
        subseq_A, sstart_A, send_A, sstrand_A = extract_hit_sequence(seq_record_A, hit_A)

        outA = os.path.join(pair_dir, f"{assembly_acc}__{rep_tag(repA)}.fa")
        with open(outA, "w") as oh:
            oh.write(
                f">{assembly_acc}|{repA}|plasmid:{plasmidA}"
                f"|qseqid:{hit_A.get('qseqid','')}"
                f"|sseqid:{hit_A.get('sseqid','')}"
                f"|sstart:{sstart_A}|send:{send_A}|sstrand:{sstrand_A}\n"
            )
            oh.write(str(subseq_A) + "\n")

        rows_out.append({
            "ASSEMBLY_ACC": assembly_acc,
            "pair": pair,
            "replicon": repA,
            "source_plasmid": plasmidA,
            "source_fasta": fasta_path_A,
            "blast_file": blast_file_A,
            "qseqid": hit_A.get("qseqid", ""),
            "sseqid": hit_A.get("sseqid", ""),
            "sstart": sstart_A,
            "send": send_A,
            "sstrand": sstrand_A,
            "out_fasta": outA,
        })

        # -------------------------
        # Extract repB from plasmidB
        # -------------------------
        analysis_dir_B = os.path.join(MOB_DIR, plasmidB + "_analysis")
        blast_file_B = os.path.join(analysis_dir_B, "replicon_blast_results.txt")
        if not os.path.exists(blast_file_B):
            raise FileNotFoundError(f"Missing blast file for plasmidB: {blast_file_B}")

        blast_df_B = pd.read_csv(blast_file_B, sep="\t", dtype=str)
        for c in ["sstart", "send", "bitscore"]:
            if c in blast_df_B.columns:
                blast_df_B[c] = pd.to_numeric(blast_df_B[c], errors="coerce")

        fasta_path_B = find_fasta_for_plasmid(plasmidB, fasta_index)
        if fasta_path_B is None:
            raise FileNotFoundError(f"FASTA not found for plasmidB: {plasmidB}")

        seq_record_B = load_single_contig_fasta(fasta_path_B)
        hit_B = find_best_hit_for_replicon(blast_df_B, repB)
        subseq_B, sstart_B, send_B, sstrand_B = extract_hit_sequence(seq_record_B, hit_B)

        outB = os.path.join(pair_dir, f"{assembly_acc}__{rep_tag(repB)}.fa")
        with open(outB, "w") as oh:
            oh.write(
                f">{assembly_acc}|{repB}|plasmid:{plasmidB}"
                f"|qseqid:{hit_B.get('qseqid','')}"
                f"|sseqid:{hit_B.get('sseqid','')}"
                f"|sstart:{sstart_B}|send:{send_B}|sstrand:{sstrand_B}\n"
            )
            oh.write(str(subseq_B) + "\n")

        rows_out.append({
            "ASSEMBLY_ACC": assembly_acc,
            "pair": pair,
            "replicon": repB,
            "source_plasmid": plasmidB,
            "source_fasta": fasta_path_B,
            "blast_file": blast_file_B,
            "qseqid": hit_B.get("qseqid", ""),
            "sseqid": hit_B.get("sseqid", ""),
            "sstart": sstart_B,
            "send": send_B,
            "sstrand": sstrand_B,
            "out_fasta": outB,
        })

        n_ok += 1
        if n_ok % 100 == 0:
            print(f"Processed {n_ok} observations successfully")

    except Exception as e:
        n_fail += 1
        print(f"[FAIL] {assembly_acc} | {pair} | {plasmidA} | {plasmidB} -> {e}")

# ============================================================
# SAVE SUMMARY
# ============================================================
summary = pd.DataFrame(rows_out)
summary.to_csv(SUMMARY_OUT, sep="\t", index=False)

print(f"Done. Successful observations: {n_ok}")
print(f"Failed observations: {n_fail}")
print(f"Summary written to: {SUMMARY_OUT}")
