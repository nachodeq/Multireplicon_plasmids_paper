#!/usr/bin/env python3

import os
import re
import csv
import random
import subprocess
import pandas as pd
import tempfile
import shutil
from multiprocessing import Pool, cpu_count

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

HALF_WINDOWS = [500,1000,1500,2000,2500]
N_TEST = 100
SEED = 42
random.seed(SEED)

N_CORES = max(1, cpu_count() - 2)

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
        return [(start,end)]
    if start < 1:
        return [(L + start + 1, L),(1,end)]
    if end > L:
        return [(start,L),(1,end-L)]
    return None

def linear_window(center, L, hw):
    start = center - hw
    end = center + hw
    if start < 1 or end > L:
        return None
    return [(start,end)]

def get_fasta_path(chrom):
    for fname in os.listdir(PLASMID_FASTA_DIR):
        if fname.endswith((".fna",".fa",".fasta")) and fname.startswith(chrom):
            return os.path.join(PLASMID_FASTA_DIR,fname)
    return None

def get_length_from_fasta(fasta):
    fai = fasta + ".fai"
    if not os.path.exists(fai):
        subprocess.run([SAMTOOLS,"faidx",fasta],check=True)
    with open(fai) as f:
        return int(f.readline().split("\t")[1])

def extract_seq(fasta, chrom, parts, outpath):
    seq=""
    for s,e in parts:
        region=f"{chrom}:{s}-{e}"
        try:
            out=subprocess.check_output([SAMTOOLS,"faidx",fasta,region]).decode()
            seq+="".join(out.split("\n")[1:])
        except:
            return False
    if not seq:
        return False
    with open(outpath,"w") as o:
        o.write(f">{chrom}\n{seq}\n")
    return True

# ============================================================
# PARALLEL SAFE MEFINDER
# ============================================================

def run_mefinder_job(args):
    fa_path, prefix = args

    tmpdir = tempfile.mkdtemp(prefix="mge_tmp_")
    env = os.environ.copy()
    env["TMPDIR"] = tmpdir

    try:
        subprocess.run(
            [MEFINDER,"find","--contig",fa_path,prefix],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            env=env
        )
    except:
        shutil.rmtree(tmpdir)
        return 0

    csv_file = prefix + ".csv"
    result = 0

    if os.path.exists(csv_file) and os.path.getsize(csv_file) > 50:
        try:
            df = pd.read_csv(csv_file, sep=",", comment="#")
            if df.shape[0] > 0:
                result = 1
        except:
            pass

    shutil.rmtree(tmpdir)
    return result

# ============================================================
# LOAD BREAKPOINTS (REAL LENGTH)
# ============================================================

print("Loading breakpoints (real FASTA lengths)...")

breakpoints=[]

with open(CONTAINMENT_FILE) as f:
    rdr=csv.DictReader(f,delimiter="\t")
    for row in rdr:

        big_len=int(row["big_len"])
        cov_path=os.path.join(NUCMER_DIR,row["source_file"])
        if not os.path.exists(cov_path):
            continue

        with open(cov_path) as fh:
            for line in fh:
                parsed=parse_cov90_line(line)
                if not parsed:
                    continue

                if parsed["lenR"] == big_len:
                    chrom=parsed["ref"]
                    s=min(parsed["s1"],parsed["e1"])
                    e=max(parsed["s1"],parsed["e1"])

                elif parsed["lenQ"] == big_len:
                    chrom=parsed["qry"]
                    s=min(parsed["s2"],parsed["e2"])
                    e=max(parsed["s2"],parsed["e2"])
                else:
                    continue

                fasta=get_fasta_path(chrom)
                if not fasta:
                    break

                real_L=get_length_from_fasta(fasta)

                breakpoints.append((chrom,s,real_L))
                breakpoints.append((chrom,e,real_L))
                break

print("Total breakpoints:",len(breakpoints))

# Chromosome lengths
chrom_lengths={}
fai=CHROM_FASTA+".fai"
if not os.path.exists(fai):
    subprocess.run([SAMTOOLS,"faidx",CHROM_FASTA],check=True)
with open(fai) as f:
    for line in f:
        fields=line.split("\t")
        chrom_lengths[fields[0]]=int(fields[1])

chrom_contigs=list(chrom_lengths.keys())

# ============================================================
# MAIN
# ============================================================

for hw in HALF_WINDOWS:

    print("\n==============================")
    print(f"WINDOW ±{hw}")
    print("==============================")

    workdir=os.path.join(BASE_DIR,f"hypertest_{hw}")
    os.makedirs(workdir,exist_ok=True)

    jobs_bp=[]
    jobs_bg=[]
    jobs_chr=[]

    bp_sample=random.sample(breakpoints,N_TEST)

    # breakpoints
    for i,(chrom,pos,L) in enumerate(bp_sample):
        fasta=get_fasta_path(chrom)
        parts=circular_window(pos,L,hw)
        if not parts: continue
        fa=os.path.join(workdir,f"bp_{i}.fa")
        prefix=os.path.join(workdir,f"bp_{i}")
        if extract_seq(fasta,chrom,parts,fa):
            jobs_bp.append((fa,prefix))

    # random plasmid
    for i in range(N_TEST):
        chrom,_,L=random.choice(breakpoints)
        fasta=get_fasta_path(chrom)
        rand_pos=random.randint(1,L)
        parts=circular_window(rand_pos,L,hw)
        if not parts: continue
        fa=os.path.join(workdir,f"bg_{i}.fa")
        prefix=os.path.join(workdir,f"bg_{i}")
        if extract_seq(fasta,chrom,parts,fa):
            jobs_bg.append((fa,prefix))

    # chromosome
    for i in range(N_TEST):
        contig=random.choice(chrom_contigs)
        L=chrom_lengths[contig]
        if L<2*hw: continue
        center=random.randint(hw+1,L-hw)
        parts=linear_window(center,L,hw)
        if not parts: continue
        fa=os.path.join(workdir,f"chr_{i}.fa")
        prefix=os.path.join(workdir,f"chr_{i}")
        if extract_seq(CHROM_FASTA,contig,parts,fa):
            jobs_chr.append((fa,prefix))

    all_jobs=jobs_bp+jobs_bg+jobs_chr

    print(f"Running {len(all_jobs)} jobs on {N_CORES} cores...")

    with Pool(N_CORES) as pool:
        results=pool.map(run_mefinder_job,all_jobs)

    bp_hits=sum(results[:len(jobs_bp)])
    bg_hits=sum(results[len(jobs_bp):len(jobs_bp)+len(jobs_bg)])
    chr_hits=sum(results[-len(jobs_chr):])

    print(f"Breakpoints:    {bp_hits}/{len(jobs_bp)}")
    print(f"Random plasmid: {bg_hits}/{len(jobs_bg)}")
    print(f"Chromosome:     {chr_hits}/{len(jobs_chr)}")

print("\nHyper-parallel test complete.")

