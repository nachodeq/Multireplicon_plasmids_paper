#!/usr/bin/env python3
"""
find_and_fetch_pairs.py

1) Escanea MOB_DIR/*_summary.txt para todos los representatives listados en DEREP_FILE.
2) Cuenta todas las parejas de replicones (unordered pairs of rep_type strings).
3) Para cada pareja con count >= MIN_COUNT:
     - crea OUT_DIR/pair/<REP1__REP2>/
     - extrae para cada plasmid de la pareja los dos replicones (usando replicon_blast_results.txt)
     - guarda los fasta extraídos como ACCESSION__<cleanrep>.fa
4) Genera run_aligns.sh con comandos para concatenar y alinear (muscle/mafft fallback).
"""
import os, glob, itertools, re, sys, math
import pandas as pd
from Bio import SeqIO

# ---------------- USER ADJUSTABLE ----------------
MOB_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/mobtyper"
FASTAS_SRC = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/fasta"
OUT_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons"
DEREP_FILE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/louvain_by_level_from_table_including_isolates/representatives_by_cluster_level.tsv"
MIN_COUNT = 5   # parejas que ocurran más de (>=) este valor
# -------------------------------------------------

os.makedirs(OUT_DIR, exist_ok=True)

def basename_noext(x):
    if pd.isna(x):
        return x
    name = str(x).split()[0]
    name = os.path.basename(name)
    for ext in ['.faa', '.fna', '.ffn', '.gb', '.gbk', '.fasta', '.fa', '.faa.gz', '.fna.gz', '.fasta.gz']:
        if name.endswith(ext):
            name = name[:-len(ext)]
    parts = name.split('.')
    if len(parts) > 1 and parts[-1].isdigit():
        name = '.'.join(parts[:-1])
    return name

def clean_tag(s):
    # tag limpio para filenames: solo alfanumérico y guiones bajos
    return re.sub(r'[^A-Za-z0-9_]+', '_', s)

# read derep representatives
if not os.path.exists(DEREP_FILE):
    raise FileNotFoundError("DEREP_FILE not found: " + DEREP_FILE)
derep_df = pd.read_csv(DEREP_FILE, sep="\t", dtype=str, keep_default_na=False)
if "representative" not in derep_df.columns:
    raise ValueError("'representative' column not found in " + DEREP_FILE)
derep_reps = set(derep_df["representative"].dropna().astype(str).tolist())
print(f"Loaded {len(derep_reps)} dereplicated representatives")

# index FASTAs
fasta_index = {}
for p in glob.glob(os.path.join(FASTAS_SRC, "*")):
    b = basename_noext(p)
    if b not in fasta_index:
        fasta_index[b] = p
print("Indexed FASTAs:", len(fasta_index))

# read all summary files for representatives only
summary_files = sorted(glob.glob(os.path.join(MOB_DIR, "*_summary.txt")))
print("Found summary files:", len(summary_files))

# data structures
plasmid_reps = {}   # accession -> list of rep types
plasmid_rep_accs = {}  # accession -> list of rep_type_accession (parallel lists)

for sf in summary_files:
    acc = os.path.basename(sf).replace("_summary.txt","")
    if acc not in derep_reps:
        continue
    try:
        df = pd.read_csv(sf, sep="\t", dtype=str, keep_default_na=False)
    except Exception as e:
        print("Warning reading", sf, e)
        continue
    if df.shape[0] == 0:
        continue
    row = df.iloc[0]
    rep_types = str(row.get('rep_type(s)', '')).strip()
    rep_accessions = str(row.get('rep_type_accession(s)', '')).strip()
    if not rep_types:
        continue
    types = [t.strip() for t in re.split('[,;]', rep_types) if t.strip()]
    accessions = [a.strip() for a in re.split('[,;]', rep_accessions) if a.strip()]
    # store
    plasmid_reps[acc] = types
    plasmid_rep_accs[acc] = accessions

print("Plasmids (representatives) with replicon info:", len(plasmid_reps))

# build pair counts (unordered pairs)
from collections import defaultdict
pair_to_plasmids = defaultdict(list)
for acc, types in plasmid_reps.items():
    # consider unique types per plasmid
    uniq = sorted(set(types))
    # all unordered pairs combinations of types (size 2)
    for a,b in itertools.combinations(uniq,2):
        key = tuple(sorted([a,b]))
        pair_to_plasmids[key].append(acc)

# filter pairs by MIN_COUNT
selected_pairs = {k:v for k,v in pair_to_plasmids.items() if len(v) >= MIN_COUNT}
print(f"Found {len(selected_pairs)} pairs with count >= {MIN_COUNT}")

# Save pair counts for inspection
pair_summary = pd.DataFrame([
    {"repA": k[0], "repB": k[1], "count": len(v)}
    for k,v in sorted(selected_pairs.items(), key=lambda x: -len(x[1]))
])
pair_summary.to_csv(os.path.join(OUT_DIR, "replicon_pair_counts.tsv"), sep="\t", index=False)
print("Saved pair counts to replicon_pair_counts.tsv")

# Function to get accession (rep accession) mapping of a type for a plasmid:
def map_type_to_accession(acc, desired_type):
    # look into plasmid_reps[acc] and plasmid_rep_accs[acc] assuming same order
    types = plasmid_reps.get(acc, [])
    accs = plasmid_rep_accs.get(acc, [])
    # try to find index where desired_type is in types[i]
    for i,t in enumerate(types):
        if desired_type in t:
            if i < len(accs):
                return accs[i]
            else:
                return accs[0] if accs else None
    # fallback: None
    return None

# Now for each selected pair, extract replicons
run_align_lines = []
for (repA, repB), plasmids in selected_pairs.items():
    # prepare directory
    repA_tag = clean_tag(repA)
    repB_tag = clean_tag(repB)
    pair_name = f"{repA_tag}__{repB_tag}"
    pair_dir = os.path.join(OUT_DIR, pair_name)
    os.makedirs(pair_dir, exist_ok=True)
    print(f"Processing pair {pair_name} with {len(plasmids)} plasmids -> {pair_dir}")
    # for each plasmid, open its analysis blast file and extract each required replicon
    for acc in plasmids:
        analysis_dir = os.path.join(MOB_DIR, acc + "_analysis")
        blast_file = os.path.join(analysis_dir, "replicon_blast_results.txt")
        if not os.path.exists(blast_file):
            print("  Missing blast for", acc, "skipping")
            continue
        # find FASTA
        bacc = basename_noext(acc)
        fasta_path = fasta_index.get(bacc)
        if fasta_path is None:
            matches = glob.glob(os.path.join(FASTAS_SRC, f"*{bacc}*"))
            fasta_path = matches[0] if matches else None
        if fasta_path is None:
            print("  FASTA not found for", acc, "skipping")
            continue
        # load sequence
        seqs = list(SeqIO.parse(fasta_path, "fasta"))
        if len(seqs) == 0:
            print("  empty fasta", fasta_path)
            continue
        seq_record = seqs[0]
        seq_len = len(seq_record.seq)
        # read blast df
        try:
            bdf = pd.read_csv(blast_file, sep="\t", dtype=str, keep_default_na=False)
            for c in ['sstart','send','bitscore']:
                if c in bdf.columns:
                    bdf[c] = pd.to_numeric(bdf[c], errors='coerce')
        except Exception as e:
            print("  error reading blast", blast_file, e)
            continue
        # for each replicon in pair pick an accession token and search qseqid
        for rep_type in (repA, repB):
            rep_acc = map_type_to_accession(acc, rep_type)
            if rep_acc is None or rep_acc == "":
                print(f"   No rep accession for {acc} type {rep_type} -> skipping this replicon")
                continue
            # search qseqid containing rep_acc
            matches = bdf[bdf['qseqid'].str.contains(rep_acc, na=False, regex=False)]
            if matches.empty:
                # try searching in sseqid as fallback
                matches = bdf[bdf['sseqid'].str.contains(rep_acc, na=False, regex=False)]
            if matches.empty:
                print(f"   No blast hit for {acc} rep {rep_acc} ({rep_type}) -> skipping")
                continue
            # choose best by bitscore if available
            if 'bitscore' in matches.columns and matches['bitscore'].notna().any():
                hit = matches.loc[matches['bitscore'].idxmax()]
            else:
                hit = matches.iloc[0]
            sstart = int(hit['sstart'])
            send = int(hit['send'])
            sstrand = hit.get('sstrand','plus')
            # sanity check coords
            if sstart < 1 or send < 1 or sstart > seq_len or send > seq_len:
                print(f"   Coordinates out of range for {acc}: {sstart}-{send} (len {seq_len}) -> skipping")
                continue
            a = min(sstart, send) - 1
            b = max(sstart, send)
            subseq = seq_record.seq[a:b]
            if sstrand.lower() == 'minus':
                subseq = subseq.reverse_complement()
            tag = clean_tag(rep_type)
            out_fname = f"{acc}__{tag}.fa"
            out_path = os.path.join(pair_dir, out_fname)
            with open(out_path, "w") as oh:
                header = f">{acc}|{tag}|src:{os.path.basename(blast_file)}|qseqid:{hit.get('qseqid','')}|sstart:{sstart}|send:{send}|sstrand:{sstrand}\n"
                oh.write(header)
                oh.write(str(subseq) + "\n")
    # after extracting all plasmids for the pair, add concat+align commands to run_aligns.sh
    # create glob patterns relative to pair_dir
    repA_glob = os.path.join(pair_dir, f"*{clean_tag(repA)}.fa")
    repB_glob = os.path.join(pair_dir, f"*{clean_tag(repB)}.fa")
    repA_concat = os.path.join(pair_dir, f"{repA_tag}_all.fa")
    repB_concat = os.path.join(pair_dir, f"{repB_tag}_all.fa")
    repA_aln = os.path.join(pair_dir, f"{repA_tag}_all_aligned.fasta")
    repB_aln = os.path.join(pair_dir, f"{repB_tag}_all_aligned.fasta")
    # safe cat using shell
    run_align_lines.append(f"echo 'Concatenating {pair_name} {repA_tag}'; cat {repA_glob} > {repA_concat} || true")
    run_align_lines.append(f"echo 'Concatenating {pair_name} {repB_tag}'; cat {repB_glob} > {repB_concat} || true")
    # muscle command (portable) with fallback to mafft
    run_align_lines.append(f"if command -v muscle >/dev/null 2>&1; then")
    run_align_lines.append(f"  echo 'Running muscle for {pair_name} {repA_tag}'; muscle -in {repA_concat} -out {repA_aln}")
    run_align_lines.append(f"  echo 'Running muscle for {pair_name} {repB_tag}'; muscle -in {repB_concat} -out {repB_aln}")
    run_align_lines.append(f"else")
    run_align_lines.append(f"  echo 'muscle not found, using mafft --auto for {pair_name}';")
    run_align_lines.append(f"  mafft --auto --thread 8 {repA_concat} > {repA_aln}")
    run_align_lines.append(f"  mafft --auto --thread 8 {repB_concat} > {repB_aln}")
    run_align_lines.append(f"fi")
    run_align_lines.append("")

# write run_aligns.sh
run_script = os.path.join(OUT_DIR, "run_aligns.sh")
with open(run_script, "w") as rh:
    rh.write("#!/usr/bin/env bash\nset -euo pipefail\n\n")
    rh.write("\n".join(run_align_lines))
os.chmod(run_script, 0o755)
print("Wrote align/run script to", run_script)
print("Done.")

