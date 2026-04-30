#!/usr/bin/env python3
import os, re
from collections import defaultdict

WORKDIR = os.path.abspath(os.path.dirname(__file__))

WIN_DIR_FG = os.path.join(WORKDIR, "windows_seqs")
WIN_DIR_BG = os.path.join(WORKDIR, "background_seqs")

DOM_FG = os.path.join(WORKDIR, "profiling/analysis/promge_hmmscan.filtered.domtblout")
DOM_BG = os.path.join(WORKDIR, "profiling/analysis/promge_bg.filtered.domtblout")

OUT_COUNTS = os.path.join(WORKDIR, "profiling/analysis/hmm_window_counts_corrected_v2.tsv")
OUT_ENR = os.path.join(WORKDIR, "profiling/analysis/hmm_enrichment_corrected_v2.tsv")


def load_window_headers(win_dir):
    header_map = {}
    filename_map = {}
    if not os.path.isdir(win_dir):
        return header_map, filename_map

    for fn in os.listdir(win_dir):
        if not fn.endswith(".fa"): continue
        name = fn[:-3]
        filename_map[name] = name

        with open(os.path.join(win_dir, fn)) as fh:
            line = fh.readline().strip()
            if line.startswith(">"):
                token = line[1:].split()[0]
                header_map[token] = name
    return header_map, filename_map


def parse_domtbl(domfile):
    prot_to_hmms = defaultdict(set)
    if not os.path.exists(domfile):
        return prot_to_hmms

    with open(domfile) as fh:
        for L in fh:
            if L.startswith("#"): continue
            parts = re.split(r"\s+", L.strip())
            if len(parts) < 4: continue
            hmm = parts[0]
            prot = parts[3]
            prot_to_hmms[prot].add(hmm)
    return prot_to_hmms


# NEW — extract coordinate token from ANY pattern
def extract_window_id(token):
    """
    Devuelve un identificador que coincida con nombres en windows_seqs:
    Soporta:
      chrom:start-end
      chrom__xxxx__start_end
    """
    # pattern 1: chrom:start-end
    m = re.search(r'([A-Za-z0-9_.]+:\d+-\d+)', token)
    if m:
        return m.group(1)

    # pattern 2: chrom__xxx__start_end
    m2 = re.search(r'([A-Za-z0-9_.]+)__[^ ]*?__(\d+)_(\d+)', token)
    if m2:
        chrom = m2.group(1)
        s = m2.group(2)
        e = m2.group(3)
        return f"{chrom}:{s}-{e}"

    return None


def try_map_token(token, header_map, filename_map, all_window_names):

    # 1 — exact matches
    if token in header_map:
        return header_map[token]
    if token in filename_map:
        return filename_map[token]

    # 2 — strip suffixes (_1, _2)
    t = re.sub(r'_[0-9]+$', '', token)
    if t in header_map: return header_map[t]
    if t in filename_map: return filename_map[t]

    # 3 — extract coordinate window id
    coord = extract_window_id(token)
    if coord:
        if coord in header_map: return header_map[coord]
        if coord in filename_map: return filename_map[coord]

    # 4 — fallback: map by prefix using chrom accession (NZ_CPxxxxx)
    prefix = token.split("__")[0].split(":")[0]
    for w in all_window_names:
        if w.startswith(prefix):
            return w

    return None


def main():

    # Load window maps
    fg_hmap, fg_fmap = load_window_headers(WIN_DIR_FG)
    bg_hmap, bg_fmap = load_window_headers(WIN_DIR_BG)

    fg_windows = sorted(fg_fmap.values())
    bg_windows = sorted(bg_fmap.values())

    print(f"FG windows = {len(fg_windows)}  BG windows = {len(bg_windows)}")

    # Read hits
    fg_hits = parse_domtbl(DOM_FG)
    bg_hits = parse_domtbl(DOM_BG)

    print(f"FG protein hits = {len(fg_hits)}  BG protein hits = {len(bg_hits)}")

    fg_win_hmms = defaultdict(set)
    bg_win_hmms = defaultdict(set)

    # MAPPING foreground
    all_fg_window_names = set(fg_windows)
    unmapped_fg = []

    for prot, hmms in fg_hits.items():
        win = try_map_token(prot, fg_hmap, fg_fmap, all_fg_window_names)
        if win:
            fg_win_hmms[win].update(hmms)
        else:
            unmapped_fg.append(prot)

    # MAPPING background
    all_bg_window_names = set(bg_windows)
    unmapped_bg = []

    for prot, hmms in bg_hits.items():
        win = try_map_token(prot, bg_hmap, bg_fmap, all_bg_window_names)
        if win:
            bg_win_hmms[win].update(hmms)
        else:
            unmapped_bg.append(prot)

    print("Mapped FG:", len(fg_win_hmms), "Unmapped FG:", len(unmapped_fg))
    print("Mapped BG:", len(bg_win_hmms), "Unmapped BG:", len(unmapped_bg))

    # collect all hmms
    all_hmms = set()
    for s in fg_win_hmms.values(): all_hmms.update(s)
    for s in bg_win_hmms.values(): all_hmms.update(s)

    rows = []
    fg_total = len(fg_windows)
    bg_total = len(bg_windows)

    for hmm in sorted(all_hmms):
        fg_with = sum(hmm in fg_win_hmms.get(w, set()) for w in fg_windows)
        fg_without = fg_total - fg_with

        bg_with = sum(hmm in bg_win_hmms.get(w, set()) for w in bg_windows)
        bg_without = bg_total - bg_with

        rows.append((hmm, fg_with, fg_without, bg_with, bg_without))

    with open(OUT_COUNTS, "w") as o:
        o.write("hmm\tfg_with\tfg_without\tbg_with\tbg_without\tfg_total\tbg_total\n")
        for r in rows:
            o.write("\t".join(map(str, r + (fg_total, bg_total))) + "\n")

    print("Wrote:", OUT_COUNTS)

    # Enrichment
    try:
        from scipy.stats import fisher_exact
        from statsmodels.stats.multitest import multipletests
    except:
        print("No fisher/statsmodels — skipping enrichment.")
        return

    pvals, tables = [], []
    for hmm, a, b, c, d in rows:
        OR, p = fisher_exact([[a,b],[c,d]], alternative="greater")
        tables.append((hmm,a,b,c,d,OR,p))
        pvals.append(p)

    if len(pvals)==0:
        print("No HMM hits found.")
        return

    rej, p_adj, _, _ = multipletests(pvals, method="fdr_bh")

    with open(OUT_ENR, "w") as o:
        o.write("hmm\tfg_with\tfg_without\tbg_with\tbg_without\toddsratio\tpvalue\tp_adj\treject\n")
        for i,(hmm,a,b,c,d,OR,p) in enumerate(tables):
            o.write(f"{hmm}\t{a}\t{b}\t{c}\t{d}\t{OR:.3g}\t{p:.2e}\t{p_adj[i]:.2e}\t{int(rej[i])}\n")

    print("Wrote:", OUT_ENR)


if __name__ == "__main__":
    main()

