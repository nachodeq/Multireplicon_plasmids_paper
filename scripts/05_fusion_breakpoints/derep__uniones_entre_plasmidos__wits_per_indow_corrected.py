#!/usr/bin/env python3
"""
count_windows_by_hmm_corrected_v2.py

Mapea proteínas a ventanas leyendo la cabecera real de cada FASTA en windows_seqs/,
cuenta presencia/ausencia por ventana para HMMs (foreground y background),
y realiza Fisher+BH (si scipy & statsmodels están instalados).

Salida:
 - profiling/analysis/hmm_window_counts_corrected_v2.tsv
 - profiling/analysis/hmm_enrichment_corrected_v2.tsv  (si bg existe y scipy/statsmodels están presentes)
"""
import os, re, sys, csv
from collections import defaultdict

WORKDIR = "."
WIN_DIR_FG = os.path.join(WORKDIR, "windows_seqs")
WIN_DIR_BG = os.path.join(WORKDIR, "background_seqs")
DOM_FG = os.path.join("profiling","analysis","promge_hmmscan.filtered.domtblout")
DOM_BG = os.path.join("profiling","analysis","promge_bg.filtered.domtblout")  # optional
OUT_COUNTS = os.path.join("profiling","analysis","hmm_window_counts_corrected_v2.tsv")
OUT_ENR = os.path.join("profiling","analysis","hmm_enrichment_corrected_v2.tsv")

def build_header_map(win_dir):
    """
    Return dict: token -> window_name
    token is the fasta header token (first token after >) found in the file.
    """
    d = {}
    if not os.path.isdir(win_dir):
        return d
    for fn in os.listdir(win_dir):
        if not fn.endswith(".fa"): continue
        path = os.path.join(win_dir, fn)
        with open(path) as fh:
            for line in fh:
                if line.startswith(">"):
                    tok = line[1:].strip().split()[0]
                    d[tok] = fn[:-3]   # map token -> window name (filename without .fa)
                    break
    return d

def parse_domtbl(domfile):
    """
    Parse domtblout minimally, return dict prot_header_token -> set(hmm_names)
    """
    prot_to_hmms = defaultdict(set)
    if not os.path.exists(domfile):
        return prot_to_hmms
    with open(domfile) as fh:
        for line in fh:
            if line.startswith("#"): continue
            parts = re.split(r"\s+", line.strip(), maxsplit=22)
            if len(parts) < 4: continue
            hmm = parts[0]
            prot = parts[3]
            # prot may contain full header; token is first field
            token = prot.split()[0]
            prot_to_hmms[token].add(hmm)
    return prot_to_hmms

def main():
    # build maps from fasta headers to window names
    print("Reading window headers from", WIN_DIR_FG)
    map_fg = build_header_map(WIN_DIR_FG)
    print("Foreground header tokens:", len(map_fg))
    map_bg = build_header_map(WIN_DIR_BG)
    print("Background header tokens:", len(map_bg))

    # read domtblouts
    print("Parsing foreground domtbl:", DOM_FG)
    prot_hmms_fg = parse_domtbl(DOM_FG)
    print("Proteins with hits (fg):", len(prot_hmms_fg))
    print("Parsing background domtbl (if any):", DOM_BG)
    prot_hmms_bg = parse_domtbl(DOM_BG)
    print("Proteins with hits (bg):", len(prot_hmms_bg))

    # map protein tokens -> window names using map_fg and map_bg
    win_hmms_fg = defaultdict(set)   # window_name -> set(hmms)
    unmapped_fg = []
    for prot_token, hmms in prot_hmms_fg.items():
        win = map_fg.get(prot_token)
        if win:
            win_hmms_fg[win].update(hmms)
        else:
            # sometimes proteins from concated background/proteins may have token matching bg map
            # or token may include prefix like chrom:coords_1 while fasta header token could be chrom:coords
            # try relaxed matching: check prefixes in map_fg keys
            matched = None
            for tok in map_fg:
                if prot_token.startswith(tok) or tok.startswith(prot_token):
                    matched = map_fg[tok]
                    break
            if matched:
                win_hmms_fg[matched].update(hmms)
            else:
                unmapped_fg.append(prot_token)
    print("Mapped foreground proteins -> windows:", len(win_hmms_fg))
    print("Unmapped foreground protein tokens (count):", len(unmapped_fg))
    if len(unmapped_fg)>0:
        print("Examples unmapped (fg):", unmapped_fg[:10])

    win_hmms_bg = defaultdict(set)
    unmapped_bg = []
    for prot_token, hmms in prot_hmms_bg.items():
        win = map_bg.get(prot_token)
        if win:
            win_hmms_bg[win].update(hmms)
        else:
            matched = None
            for tok in map_bg:
                if prot_token.startswith(tok) or tok.startswith(prot_token):
                    matched = map_bg[tok]
                    break
            if matched:
                win_hmms_bg[matched].update(hmms)
            else:
                unmapped_bg.append(prot_token)
    print("Mapped background proteins -> windows:", len(win_hmms_bg))
    print("Unmapped background protein tokens (count):", len(unmapped_bg))
    if len(unmapped_bg)>0:
        print("Examples unmapped (bg):", unmapped_bg[:10])

    # list windows
    fg_windows = sorted(set(map_fg.values()))
    bg_windows = sorted(set(map_bg.values()))

    # gather all HMMs observed
    all_hmms = set()
    for s in win_hmms_fg.values(): all_hmms.update(s)
    for s in win_hmms_bg.values(): all_hmms.update(s)

    fg_total = len(fg_windows)
    bg_total = len(bg_windows)

    # build counts per HMM presence/absence (by window)
    rows = []
    for hmm in sorted(all_hmms):
        fg_with = sum(1 for w in fg_windows if hmm in win_hmms_fg.get(w, set()))
        fg_without = fg_total - fg_with
        if bg_total:
            bg_with = sum(1 for w in bg_windows if hmm in win_hmms_bg.get(w, set()))
            bg_without = bg_total - bg_with
        else:
            bg_with = bg_without = 0
        rows.append((hmm, fg_with, fg_without, bg_with, bg_without))

    # write counts
    os.makedirs(os.path.join("profiling","analysis"), exist_ok=True)
    with open(OUT_COUNTS, "w") as out:
        out.write("hmm\tfg_with\tfg_without\tbg_with\tbg_without\tfg_total\tbg_total\n")
        for r in rows:
            out.write("\t".join(map(str, r + (fg_total, bg_total))) + "\n")
    print("Wrote counts to", OUT_COUNTS)

    # attempt Fisher + BH if bg exists and stats libs installed
    if bg_total==0:
        print("No background windows; skipping Fisher enrichment.")
        return

    try:
        from scipy.stats import fisher_exact
        from statsmodels.stats.multitest import multipletests
    except Exception as e:
        print("scipy/statsmodels not available; skipping Fisher. Install with: pip3 install scipy statsmodels")
        return

    contigs = []
    pvals = []
    for (hmm, a, b, c, d) in rows:
        table = [[a, b], [c, d]]
        try:
            orr, p = fisher_exact(table, alternative='greater')
        except Exception:
            orr, p = None, 1.0
        contigs.append((hmm,a,b,c,d,orr,p))
        pvals.append(p)
    rej, p_adj, _, _ = multipletests(pvals, method='fdr_bh')
    with open(OUT_ENR, "w") as out:
        out.write("hmm\tfg_with\tfg_without\tbg_with\tbg_without\toddsratio\tpvalue\tp_adj\treject\n")
        for i, (hmm,a,b,c,d,orr,p) in enumerate(contigs):
            out.write("\t".join(map(str, [hmm,a,b,c,d, "{:.3g}".format(orr) if orr is not None else "NA", "{:.2e}".format(p), "{:.2e}".format(p_adj[i]), int(rej[i]) ])) + "\n")
    print("Wrote enrichment to", OUT_ENR)

if __name__ == "__main__":
    main()

