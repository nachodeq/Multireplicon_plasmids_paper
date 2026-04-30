#!/usr/bin/env python3

import os
import re
import csv
import random
import subprocess
import pandas as pd
from collections import defaultdict

# ============================================================
# CONFIG
# ============================================================

BASE_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"
NUCMER_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/nucmer"
GRAPH_DIR = os.path.join(NUCMER_DIR, "graph_cov90_noclose")
CONTAINMENT_FILE = os.path.join(GRAPH_DIR, "containment_NUC_levelup_strictlen.tsv")

PLASMID_FASTA_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/raw_fastas"
CHROM_FASTA = os.path.join(BASE_DIR, "3224_28_S81.fna")

SAMTOOLS = "/home/nacho/mambaforge/envs/samtools/bin/samtools"
MEFINDER = "/home/nacho/.local/bin/mefinder"

HALF_WINDOW = 2000
SEED = 42
random.seed(SEED)

N_TEST = 50

# ============================================================
# UTILITIES
# ============================================================

def parse_cov90_line(line):
    toks = re.split(r'\s+', line.strip())
    if len(toks) < 14:
        return None
    return {
        "s1": int(toks[0]),
        "e1": int(toks[1]),
        "s2": int(toks[2]),
        "e2": int(toks[3]),
        "lenR": int(toks[7]),
        "lenQ": int(toks[8]),
        "ref": toks[11],
        "qry": toks[12]
    }

def circular_window(center, L, hw):
    start = center - hw
    end = center + hw

    if start >= 1 and end <= L:
        return [(start, end)]
    if start < 1:
        return [(L + start + 1, L), (1, end)]
    if end > L:
        return [(start, L), (1, end - L)]

    return [(max(1, start), min(L, end))]

def linear_window(center, L, hw):
    start = center - hw
    end = center + hw
    if start < 1 or end > L:
        return None
    return [(start, end)]

def get_fasta_path(chrom):
    for fname in os.listdir(PLASMID_FASTA_DIR):
        if fname.endswith((".fna", ".fa", ".fasta")):
            if fname.startswith(chrom) or chrom in fname:
                return os.path.join(PLASMID_FASTA_DIR, fname)
    return None

def get_lengths(fasta):
    fai = fasta + ".fai"
    if not os.path.exists(fai):
        subprocess.run([SAMTOOLS, "faidx", fasta], check=True)

    lengths = {}
    with open(fai) as f:
        for line in f:
            fields = line.split("\t")
            lengths[fields[0]] = int(fields[1])
    return lengths

def extract_seq(fasta, chrom, parts, outpath):
    seq = ""
    for s, e in parts:
        region = f"{chrom}:{s}-{e}"
        out = subprocess.check_output([SAMTOOLS, "faidx", fasta, region]).decode()
        seq += "".join(out.split("\n")[1:])
    with open(outpath, "w") as o:
        o.write(f">{chrom}\n{seq}\n")

def run_mefinder(fa_path, prefix):
    subprocess.run([MEFINDER, "find", "--contig", fa_path, prefix], check=True)
    csv_file = prefix + ".csv"
    if not os.path.exists(csv_file):
        return False
    if os.path.getsize(csv_file) < 50:
        return False
    df = pd.read_csv(csv_file, sep=",", comment="#")
    return df.shape[0] > 0

# ============================================================
# LOAD BREAKPOINTS
# ============================================================

breakpoints = []

with open(CONTAINMENT_FILE) as f:
    rdr = csv.DictReader(f, delimiter="\t")
    for row in rdr:

        query = row["query_id"]
        target = row["target_id"]
        src = row["source_file"]

        cov_path = os.path.join(NUCMER_DIR, src)
        if not os.path.exists(cov_path):
            continue

        with open(cov_path) as fh:
            for line in fh:
                parsed = parse_cov90_line(line)
                if not parsed:
                    continue

                if (parsed["ref"] == target and parsed["qry"] == query) or \
                   (parsed["ref"] == query and parsed["qry"] == target):

                    if parsed["ref"] == target:
                        L = parsed["lenR"]
                        s = min(parsed["s1"], parsed["e1"])
                        e = max(parsed["s1"], parsed["e1"])
                    else:
                        L = parsed["lenQ"]
                        s = min(parsed["s2"], parsed["e2"])
                        e = max(parsed["s2"], parsed["e2"])

                    breakpoints.append((target, s, L))
                    breakpoints.append((target, e, L))
                    break

print("Total real breakpoints:", len(breakpoints))

bp_sample = random.sample(breakpoints, N_TEST)

workdir = os.path.join(BASE_DIR, "test_50_2000")
os.makedirs(workdir, exist_ok=True)

bp_hits = 0
bg_hits = 0
chr_hits = 0

# ============================================================
# BREAKPOINT WINDOWS
# ============================================================

for i, (chrom, pos, L) in enumerate(bp_sample):

    fasta = get_fasta_path(chrom)
    parts = circular_window(pos, L, HALF_WINDOW)

    tmp = os.path.join(workdir, f"bp_{i}.fa")
    prefix = os.path.join(workdir, f"bp_{i}")

    extract_seq(fasta, chrom, parts, tmp)

    if run_mefinder(tmp, prefix):
        bp_hits += 1

# ============================================================
# RANDOM PLASMID WINDOWS
# ============================================================

for i in range(N_TEST):

    chrom, _, L = random.choice(breakpoints)
    fasta = get_fasta_path(chrom)

    rand_pos = random.randint(1, L)
    parts = circular_window(rand_pos, L, HALF_WINDOW)

    tmp = os.path.join(workdir, f"bg_{i}.fa")
    prefix = os.path.join(workdir, f"bg_{i}")

    extract_seq(fasta, chrom, parts, tmp)

    if run_mefinder(tmp, prefix):
        bg_hits += 1

# ============================================================
# RANDOM CHROMOSOME WINDOWS
# ============================================================

chrom_lengths = get_lengths(CHROM_FASTA)
contigs = list(chrom_lengths.keys())

for i in range(N_TEST):

    contig = random.choice(contigs)
    L = chrom_lengths[contig]

    if L < 2 * HALF_WINDOW:
        continue

    center = random.randint(HALF_WINDOW+1, L-HALF_WINDOW)
    parts = linear_window(center, L, HALF_WINDOW)

    tmp = os.path.join(workdir, f"chr_{i}.fa")
    prefix = os.path.join(workdir, f"chr_{i}")

    extract_seq(CHROM_FASTA, contig, parts, tmp)

    if run_mefinder(tmp, prefix):
        chr_hits += 1

# ============================================================
# RESULTS
# ============================================================

print("\nRESULTS (±2000bp)")
print("Breakpoints:", bp_hits, "/", N_TEST)
print("Random plasmid:", bg_hits, "/", N_TEST)
print("Chromosome:", chr_hits, "/", N_TEST)

