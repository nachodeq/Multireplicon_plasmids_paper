#!/usr/bin/env python3
# count_hits_per_window.py
import re, os,sys,collections

# foreground summary (from profiling/analysis/promge_domain_summary.tsv) produced previously
FG_SUM="profiling/analysis/promge_domain_summary.tsv"
BG_DOM="profiling/analysis/promge_bg.filtered.domtblout"
OUT="profiling/analysis/hmm_window_counts.tsv"

# parse FG: file with columns window\tprot_header\thmm_name\t...
fg_hits = {}  # window -> set(hmm)
if os.path.exists(FG_SUM):
    with open(FG_SUM) as fh:
        hdr = fh.readline()
        for line in fh:
            parts=line.strip().split("\t")
            if len(parts)<3: continue
            win,prot,hmm = parts[0], parts[1], parts[2]
            fg_hits.setdefault(win,set()).add(hmm)
else:
    print("ERROR fg summary not found",FG_SUM); sys.exit(1)

# parse BG: domtblout format (target is HMM name at col0, query at col3)
bg_hits = {}
if os.path.exists(BG_DOM):
    with open(BG_DOM) as fh:
        for line in fh:
            if line.startswith("#"): continue
            parts = re.split(r"\s+", line.strip(), maxsplit=22)
            if len(parts) < 4: continue
            hmm = parts[0]; prot = parts[3]
            # map prot header to background window name (we used name pattern chrom__bg__s_e)
            bg_hits.setdefault(prot,set()).add(hmm)
else:
    print("WARNING bg domtbl not found:",BG_DOM)

# build set of all HMM names
all_hmms=set()
for s in fg_hits.values():
    all_hmms.update(s)
for s in bg_hits.values():
    all_hmms.update(s)

# list of foreground windows
fg_windows = sorted(fg_hits.keys())
bg_windows = sorted(bg_hits.keys())

# for bg we want presence/absence per sampled window name
# our bg prot headers are protein headers; better to map by background sequence filenames:
# quick approach: assume one-to-one protein->window mapping; else count protein hits per bg window by prot name prefix
# here we make presence if any prot header contains the bg window id (prefix)
# create bg window id list from background_seqs filenames
bg_win_ids = [f[:-3] for f in os.listdir("background_seqs") if f.endswith(".fa")]

# map bg protein header to bg window by substring
bg_prot_to_win={}
# load whole bg prodigal output headers
if os.path.exists("prodigal_windows/background_proteins.faa"):
    with open("prodigal_windows/background_proteins.faa") as fh:
        for line in fh:
            if line.startswith(">"):
                hdr = line[1:].strip().split()[0]
                for w in bg_win_ids:
                    if w in hdr:
                        bg_prot_to_win[hdr]=w
                        break

# construct mapping: window -> set(hmm)
bg_win_map = {}
for prot,hmms in bg_hits.items():
    win = bg_prot_to_win.get(prot, None)
    if not win:
        # fallback: look for substring
        for w in bg_win_ids:
            if w in prot:
                win=w; break
    if not win: continue
    bg_win_map.setdefault(win,set()).update(hmms)

# Now contingency for each hmm
rows=[]
for hmm in sorted(all_hmms):
    a = sum(1 for w in fg_windows if hmm in fg_hits.get(w, set()))
    b = len(fg_windows) - a
    c = sum(1 for w in bg_win_ids if hmm in bg_win_map.get(w, set()))
    d = len(bg_win_ids) - c
    rows.append((hmm,a,b,c,d))
# write
with open(OUT,"w") as o:
    o.write("hmm\tfg_with\tfg_without\tbg_with\tbg_without\n")
    for r in rows:
        o.write("\t".join(map(str,r))+"\n")
print("Wrote",OUT)

