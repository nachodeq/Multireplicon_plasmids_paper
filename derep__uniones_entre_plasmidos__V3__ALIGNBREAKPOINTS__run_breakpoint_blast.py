#!/usr/bin/env python3

import os
import re
import glob
import subprocess
import pandas as pd
from multiprocessing import Pool, cpu_count

# ============================================================
# CONFIG
# ============================================================

BASE_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"
WINDOWS = [500, 1000, 1500, 2000, 2500]

BLASTN = "blastn"
N_CORES = max(1, cpu_count() - 2)

OUT_ROOT = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3/ALIGNBREAKPOINTS"
os.makedirs(OUT_ROOT, exist_ok=True)

OUTFMT = "6 qseqid sseqid qstart qend sstart send length pident mismatch gapopen evalue bitscore"

# ============================================================
# HELPERS
# ============================================================

def natural_key(path):
    name = os.path.basename(path)
    m = re.search(r"_(\d+)\.fa$", name)
    return int(m.group(1)) if m else 10**12

def pair_files(files):
    files = sorted(files, key=natural_key)
    return [(files[i], files[i+1]) for i in range(0, len(files)-1, 2)]

def run_one(job):
    category, hw, idx, fa1, fa2 = job

    outdir = os.path.join(OUT_ROOT, f"FULL_hyper_{hw}", category)
    os.makedirs(outdir, exist_ok=True)

    prefix = f"{category}_pair_{idx:05d}"
    out_tsv = os.path.join(outdir, prefix + ".blast.tsv")

    cmd = [
        BLASTN,
        "-query", fa1,
        "-subject", fa2,
        "-task", "blastn",
        "-dust", "no",
        "-soft_masking", "false",
        "-outfmt", OUTFMT
    ]

    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        return {
            "window_hw": hw,
            "window_bp_total": hw * 2 + 1,
            "category": category,
            "pair_id": idx,
            "fa1": fa1,
            "fa2": fa2,
            "blast_tsv": out_tsv,
            "status": "error",
            "n_hits": None,
            "stderr": result.stderr.strip()
        }

    with open(out_tsv, "w") as f:
        f.write(result.stdout)

    n_hits = 0
    if os.path.exists(out_tsv) and os.path.getsize(out_tsv) > 0:
        with open(out_tsv) as f:
            for _ in f:
                n_hits += 1

    return {
        "window_hw": hw,
        "window_bp_total": hw * 2 + 1,
        "category": category,
        "pair_id": idx,
        "fa1": fa1,
        "fa2": fa2,
        "blast_tsv": out_tsv,
        "status": "ok",
        "n_hits": n_hits,
        "stderr": ""
    }

# ============================================================
# MAIN
# ============================================================

def main():
    all_jobs = []

    for hw in WINDOWS:
        workdir = os.path.join(BASE_DIR, f"FULL_hyper_{hw}")
        if not os.path.isdir(workdir):
            print(f"[WARN] Missing dir: {workdir}")
            continue

        bp_files = glob.glob(os.path.join(workdir, "bp_*.fa"))
        bg_files = glob.glob(os.path.join(workdir, "bg_*.fa"))

        bp_pairs = pair_files(bp_files)
        bg_pairs = pair_files(bg_files)

        print(f"\n=== FULL_hyper_{hw} ===")
        print(f"bp files : {len(bp_files)} -> {len(bp_pairs)} pairs")
        print(f"bg files : {len(bg_files)} -> {len(bg_pairs)} pairs")

        for idx, (fa1, fa2) in enumerate(bp_pairs):
            all_jobs.append(("bp", hw, idx, fa1, fa2))

        for idx, (fa1, fa2) in enumerate(bg_pairs):
            all_jobs.append(("bg", hw, idx, fa1, fa2))

    print(f"\nRunning {len(all_jobs)} BLAST jobs on {N_CORES} cores...")

    with Pool(N_CORES) as pool:
        results = pool.map(run_one, all_jobs)

    df = pd.DataFrame(results)

    summary_path = os.path.join(OUT_ROOT, "FULL_hyper_blast_pair_index.tsv")
    df.to_csv(summary_path, sep="\t", index=False)

    print("\nDone.")
    print(f"Index written to: {summary_path}")

    if not df.empty:
        print("\nStatus summary:")
        print(df.groupby(['window_hw', 'category', 'status']).size())

if __name__ == "__main__":
    main()
