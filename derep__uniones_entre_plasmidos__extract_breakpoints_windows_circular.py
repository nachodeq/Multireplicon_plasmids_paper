#!/usr/bin/env python3
"""
extract_breakpoints_windows_circular.py -- WINDOW = 2000

Genera ventanas +/-WINDOW alrededor de los puntos de corte (start,end)
manejando plasmidos circulares. Produce:
 - breakpoints_windows.bed.tsv    (partes por ventana, 0-based)
 - breakpoints_windows_to_fetch.tsv (tab: chrom part1_start1 part1_end1 name wrap part2_start1 part2_end1)
 - fetch_breakpoints_windows.sh  (helper to extract with samtools and concat wrapped parts)

Ejecútalo desde el WORKDIR:
 /home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos
"""
import os, sys, csv, re

WORKDIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/v2_4kbp"
NUCMER_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/nucmer"
GRAPH_DIR = os.path.join(NUCMER_DIR, "graph_cov90_noclose")
CONTAINMENT_FILE = os.path.join(GRAPH_DIR, "containment_NUC_levelup_strictlen.tsv")

WINDOW = 2000  # <-- changed to 2000 bp (±2000)

OUT_BED = os.path.join(WORKDIR, "breakpoints_windows.bed.tsv")
OUT_FETCH = os.path.join(WORKDIR, "breakpoints_windows_to_fetch.tsv")
OUT_FETCH_SCRIPT = os.path.join(WORKDIR, "fetch_breakpoints_windows.sh")

DEFAULT_COV90 = [
    "level1_vs_gt1.cov90.tsv",
    "level2_vs_gt2.cov90.tsv",
    "level3_vs_gt3.cov90.tsv"
]

def parse_cov90_line(line):
    toks = re.split(r'\s+', line.strip())
    if len(toks) < 14:
        return None
    try:
        return {
            "s1": int(toks[0]), "e1": int(toks[1]),
            "s2": int(toks[2]), "e2": int(toks[3]),
            "len1": int(toks[4]), "len2": int(toks[5]),
            "lenR": int(toks[7]), "lenQ": int(toks[8]),
            "ref": toks[11], "qry": toks[12], "raw": line.strip()
        }
    except Exception:
        return None

def load_pairs():
    if not os.path.exists(CONTAINMENT_FILE):
        print("ERROR: containment file not found:", CONTAINMENT_FILE, file=sys.stderr)
        sys.exit(1)
    pairs=[]
    with open(CONTAINMENT_FILE, newline='') as f:
        rdr = csv.DictReader(f, delimiter='\t')
        for r in rdr:
            q = (r.get('query_id') or r.get('query') or r.get('qry') or "").strip()
            t = (r.get('target_id') or r.get('target') or r.get('ref') or "").strip()
            src = (r.get('source_file') or r.get('source') or "").strip()
            if q and t and src:
                pairs.append((q,t,src))
    seen=set(); out=[]
    for p in pairs:
        if p in seen: continue
        seen.add(p); out.append(p)
    return out

def find_cov90_path(src_token):
    bas = os.path.basename(src_token)
    candidates = [
        os.path.join(WORKDIR, bas),
        os.path.join(NUCMER_DIR, bas),
        os.path.join(GRAPH_DIR, bas),
        os.path.join(NUCMER_DIR, src_token),
        os.path.join(GRAPH_DIR, src_token)
    ]
    for n in DEFAULT_COV90:
        candidates.append(os.path.join(NUCMER_DIR, n))
        candidates.append(os.path.join(WORKDIR, n))
    for c in candidates:
        if c and os.path.exists(c):
            return c
    try:
        for fname in os.listdir(NUCMER_DIR):
            if bas.lower() in fname.lower() and fname.lower().endswith(".cov90.tsv"):
                return os.path.join(NUCMER_DIR, fname)
    except Exception:
        pass
    return None

def produce_windows_around(position, L):
    """Return list of 1-based inclusive ranges representing the circular window +/- WINDOW"""
    start = position - WINDOW
    end = position + WINDOW
    if start >= 1 and end <= L:
        return [(start, end)]
    parts = []
    if start < 1:
        left_start = L + start + 1
        if left_start < 1: left_start = 1
        parts.append((left_start, L))
        parts.append((1, end))
        return parts
    if end > L:
        parts.append((start, L))
        parts.append((1, end - L))
        return parts
    return [(max(1,start), min(L,end))]

def main():
    pairs = load_pairs()
    bed_rows=[]
    fetch_rows=[]
    skipped=0
    for query, target, src in pairs:
        cov_path = find_cov90_path(src)
        if not cov_path:
            print(f"WARNING: .cov90 not found for source '{src}' (target {target})", file=sys.stderr)
            skipped += 1
            continue
        with open(cov_path, 'r', encoding='utf-8', errors='ignore') as fh:
            for lineno, line in enumerate(fh, 1):
                parsed = parse_cov90_line(line)
                if not parsed: continue
                cond1 = (parsed['ref'] == target and parsed['qry'] == query)
                cond2 = (parsed['qry'] == target and parsed['ref'] == query)
                if not (cond1 or cond2): continue
                if parsed['ref'] == target:
                    L = parsed.get('lenR') or parsed.get('len1') or None
                    s_coord = parsed['s1']; e_coord = parsed['e1']
                else:
                    L = parsed.get('lenQ') or parsed.get('len2') or None
                    s_coord = parsed['s2']; e_coord = parsed['e2']
                if not L:
                    print(f"WARNING: length missing for {target} in {cov_path} line {lineno}", file=sys.stderr)
                    continue
                s_coord, e_coord = min(s_coord, e_coord), max(s_coord, e_coord)
                left_parts = produce_windows_around(s_coord, L)
                right_parts = produce_windows_around(e_coord, L)
                base = os.path.basename(cov_path)
                left_name = f"{target}__{base}__L{lineno}__LEFT"
                right_name = f"{target}__{base}__L{lineno}__RIGHT"

                # LEFT
                if len(left_parts)==1:
                    a,b = left_parts[0]
                    bed_rows.append((target, a-1, b, left_name, base, lineno, parsed['raw']))
                    fetch_rows.append((target, a, b, left_name, 0, "", ""))
                else:
                    (a1,b1),(a2,b2)=left_parts
                    bed_rows.append((target, a1-1, b1, left_name+"_part1", base, lineno, parsed['raw']))
                    bed_rows.append((target, a2-1, b2, left_name+"_part2", base, lineno, parsed['raw']))
                    fetch_rows.append((target, a1, b1, left_name, 1, a2, b2))

                # RIGHT
                if len(right_parts)==1:
                    a,b = right_parts[0]
                    bed_rows.append((target, a-1, b, right_name, base, lineno, parsed['raw']))
                    fetch_rows.append((target, a, b, right_name, 0, "", ""))
                else:
                    (a1,b1),(a2,b2)=right_parts
                    bed_rows.append((target, a1-1, b1, right_name+"_part1", base, lineno, parsed['raw']))
                    bed_rows.append((target, a2-1, b2, right_name+"_part2", base, lineno, parsed['raw']))
                    fetch_rows.append((target, a1, b1, right_name, 1, a2, b2))

    with open(OUT_BED, "w") as ob:
        ob.write("#chrom\tstart0\tend\tname\tsource_file\tlineno\toriginal_line\n")
        for r in bed_rows:
            ob.write("\t".join(map(str,r)) + "\n")

    with open(OUT_FETCH, "w") as of:
        of.write("#chrom\tpart1_start1\tpart1_end1\tname\twrap\tpart2_start1\tpart2_end1\n")
        for r in fetch_rows:
            chrom, s1, e1, name, wrap, p2s, p2e = r
            of.write("\t".join(map(str,[chrom,s1,e1,name,wrap, p2s if p2s else "", p2e if p2e else ""])) + "\n")

    # helper fetch script
    with open(OUT_FETCH_SCRIPT, "w") as sh:
        sh.write("#!/usr/bin/env bash\nset -euo pipefail\n\n")
        sh.write("WORKDIR=\"" + WORKDIR + "\"\ncd \"$WORKDIR\"\n\n")
        sh.write("mkdir -p windows_seqs\n> breakpoints_sequences.fa\n\n")
        sh.write("while IFS=$'\\t' read -r chrom s1 e1 name wrap p2s p2e; do\n")
        sh.write("  [[ \"$chrom\" =~ ^# ]] && continue\n")
        sh.write("  FASTA=\"\"; for suf in .fna .fa .fasta; do if [ -f \"fasta/${chrom}${suf}\" ]; then FASTA=\"fasta/${chrom}${suf}\"; break; fi; done\n")
        sh.write("  if [ -z \"$FASTA\" ]; then echo \"WARNING: no fasta for $chrom\" >&2; continue; fi\n")
        sh.write("  if [ \"$wrap\" -eq 0 ]; then\n")
        sh.write("    samtools faidx \"$FASTA\" \"${chrom}:${s1}-${e1}\" > \"windows_seqs/${name}.fa\"\n")
        sh.write("  else\n")
        sh.write("    samtools faidx \"$FASTA\" \"${chrom}:${s1}-${e1}\" > \"windows_seqs/${name}.part1.fa\"\n")
        sh.write("    samtools faidx \"$FASTA\" \"${chrom}:${p2s}-${p2e}\" > \"windows_seqs/${name}.part2.fa\"\n")
        sh.write("    (echo \">${name}\"; tail -n +2 \"windows_seqs/${name}.part1.fa\"; tail -n +2 \"windows_seqs/${name}.part2.fa\") > \"windows_seqs/${name}.fa\"\n")
        sh.write("    rm -f \"windows_seqs/${name}.part1.fa\" \"windows_seqs/${name}.part2.fa\"\n")
        sh.write("  fi\n")
        sh.write("  # append to multi-fasta\n")
        sh.write("  cat \"windows_seqs/${name}.fa\" >> breakpoints_sequences.fa\n")
        sh.write("done < " + os.path.basename(OUT_FETCH) + "\n")
    os.chmod(OUT_FETCH_SCRIPT, 0o755)

    print("Done. Windows generated:", len(fetch_rows))
    print("Wrote:", OUT_BED)
    print("Wrote:", OUT_FETCH)
    print("Wrote helper:", OUT_FETCH_SCRIPT)
    if skipped:
        print("Skipped pairs:", skipped)

if __name__ == "__main__":
    main()

