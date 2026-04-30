#!/usr/bin/env python3
# profiling/summarize_promge_hits.py
import re, os
DOM = "profiling/analysis/promge_hmmscan.filtered.domtblout"
OUT = "profiling/analysis/promge_domain_summary.tsv"
WIN_DIR = "windows_seqs"

if not os.path.exists(DOM):
    print("ERROR: no domtblout filtrado:", DOM); raise SystemExit(1)

# ventana names list (longest-first to match substrings)
wins = [f[:-3] for f in os.listdir(WIN_DIR) if f.endswith(".fa")]
wins_sorted = sorted(wins, key=lambda x:-len(x))

def map_prot_to_window(prot_hdr):
    # prot_hdr is the PROTEIN header token from prodigal (should contain window id)
    for w in wins_sorted:
        if w in prot_hdr:
            return w
    return prot_hdr

out = []
with open(DOM) as fh:
    for line in fh:
        if line.startswith("#"): continue
        parts = re.split(r"\s+", line.strip(), maxsplit=22)
        if len(parts) < 7: continue
        hmm_name = parts[0]
        prot = parts[3]
        try:
            evalue = float(parts[6])
        except:
            evalue = None
        score = parts[7] if len(parts) > 7 else ""
        ali_from = parts[17] if len(parts) > 17 else ""
        ali_to = parts[18] if len(parts) > 18 else ""
        win = map_prot_to_window(prot)
        out.append((win, prot, hmm_name, evalue, score, ali_from, ali_to))

with open(OUT,"w") as o:
    o.write("window\tprot_header\thmm_name\tevalue\tscore\tali_from\tali_to\n")
    for r in sorted(out, key=lambda x:(x[0], x[3] if x[3] is not None else 1e9)):
        o.write("\t".join(map(str,r)) + "\n")

print("Wrote summary to", OUT)

