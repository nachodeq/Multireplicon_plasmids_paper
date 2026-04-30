#!/usr/bin/env python3

import os
import pandas as pd

INDEX_PATH = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3/ALIGNBREAKPOINTS/FULL_hyper_blast_pair_index.tsv"
OUT_PATH   = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3/ALIGNBREAKPOINTS/FULL_hyper_blast_bestlen_summary.tsv"

COLS = [
    "qseqid", "sseqid",
    "qstart", "qend",
    "sstart", "send",
    "length", "pident",
    "mismatch", "gapopen",
    "evalue", "bitscore"
]

def summarize_one(path):
    if (not os.path.exists(path)) or os.path.getsize(path) == 0:
        return {
            "n_hits": 0,
            "best_len": 0,
            "best_pident": 0.0,
            "best_bitscore": 0.0
        }

    hits = pd.read_csv(path, sep="\t", names=COLS)

    if hits.empty:
        return {
            "n_hits": 0,
            "best_len": 0,
            "best_pident": 0.0,
            "best_bitscore": 0.0
        }

    best = hits.sort_values(
        ["length", "bitscore", "pident"],
        ascending=[False, False, False]
    ).iloc[0]

    return {
        "n_hits": int(len(hits)),
        "best_len": int(best["length"]),
        "best_pident": float(best["pident"]),
        "best_bitscore": float(best["bitscore"])
    }

idx = pd.read_csv(INDEX_PATH, sep="\t")

rows = []
for _, row in idx.iterrows():
    stats = summarize_one(row["blast_tsv"])
    rows.append({
        **row.to_dict(),
        **stats
    })

out = pd.DataFrame(rows)
out.to_csv(OUT_PATH, sep="\t", index=False)

print("Written:", OUT_PATH)
print(out.head())
