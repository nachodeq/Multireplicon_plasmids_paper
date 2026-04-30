#!/usr/bin/env python3
"""
count_by_genus.py

Cuenta líneas de edges_observed.tsv (no-unique) agrupadas por género y especie
según plsdb_summary.csv. Opciones:
  --strip-version : empareja quitando la parte ".<n>" de los accessions.
  --top N         : imprime los top N géneros (default 40)
  --outdir DIR    : guarda CSVs de resultados (default /tmp)

Uso:
  python3 count_by_genus.py \
    --plsdb /home/nacho/HDD16/Nacho/RepliCOOC/data/raw/plsdb_summary.csv \
    --edges /home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/nucmer/graph_cov90_noclose/edges_observed.tsv \
    --strip-version
"""
import argparse
import csv
import os
from collections import Counter, defaultdict
import re

def strip_version(acc):
    return re.sub(r'\.[0-9]+$', '', acc)

def detect_header_index(header_row, candidates):
    # header_row: list of column names
    for cand in candidates:
        for i, h in enumerate(header_row):
            if h.strip() == cand:
                return i
    return None

def load_plsdb_map(plsdb_path, strip_version_flag=False):
    """
    Returns:
      acc_to_genus: dict accession -> genus (may be empty string)
      acc_to_species: dict accession -> species
    """
    acc_to_genus = {}
    acc_to_species = {}
    with open(plsdb_path, newline='', encoding='utf-8') as fh:
        # try to detect delimiter: if contains tabs use '\t' else comma
        first = fh.readline()
        if '\t' in first:
            delim = '\t'
        else:
            delim = ','
        fh.seek(0)
        reader = csv.reader(fh, delimiter=delim)
        header = next(reader)
        # candidate header names
        a_idx = detect_header_index(header, ["NUCCORE_ACC", "NUCCORE_ACC\t"])
        g_idx = detect_header_index(header, ["TAXONOMY.TAXONOMY_genus", "TAXONOMY_taxon_genus", "TAXONOMY.TAXONOMY_genus\t"])
        s_idx = detect_header_index(header, ["TAXONOMY.TAXONOMY_species", "TAXONOMY_taxon_species", "TAXONOMY.TAXONOMY_species\t"])
        if a_idx is None:
            raise RuntimeError("No pude encontrar la columna NUCCORE_ACC en plsdb_summary.csv. Cabeceras encontradas: {}".format(header))
        # iterate
        for row in reader:
            if len(row) <= a_idx:
                continue
            acc = row[a_idx].strip()
            if strip_version_flag:
                acc_key = strip_version(acc)
            else:
                acc_key = acc
            genus = row[g_idx].strip() if (g_idx is not None and len(row) > g_idx) else ""
            species = row[s_idx].strip() if (s_idx is not None and len(row) > s_idx) else ""
            # if empty put explicit empty string
            acc_to_genus[acc_key] = genus if genus is not None else ""
            acc_to_species[acc_key] = species if species is not None else ""
    return acc_to_genus, acc_to_species

def count_edges(edges_path, acc_to_genus, acc_to_species, strip_version_flag=False):
    counts_genus = Counter()
    counts_species = Counter()
    not_found_counter = Counter()
    total_lines = 0
    # read edges file (tab-separated, but robust)
    with open(edges_path, newline='', encoding='utf-8') as fh:
        first = fh.readline()
        if '\t' in first:
            delim = '\t'
        else:
            # fallback to whitespace split
            delim = None
        fh.seek(0)
        reader = csv.reader(fh, delimiter=delim)
        # detect if header has 'query_id'
        header = next(reader)
        has_header = False
        if any('query_id' in h.lower() for h in header):
            has_header = True
            # find index of query_id
            q_idx = detect_header_index(header, ["query_id", "query", "query_id\t"])
        else:
            # assume first column is query_id
            q_idx = 0
            # process first row as data
            # move file pointer back to start
            fh.seek(0)
            reader = csv.reader(fh, delimiter=delim)

        for row in reader:
            if len(row) == 0:
                continue
            # if header present, skip header line
            if has_header and (row[0].lower().strip() == 'query_id' or any('query_id' in x.lower() for x in row)):
                continue
            if q_idx >= len(row):
                continue
            acc = row[q_idx].strip()
            total_lines += 1
            key = strip_version(acc) if strip_version_flag else acc
            genus = acc_to_genus.get(key, "")
            species = acc_to_species.get(key, "")
            if genus:
                counts_genus[genus] += 1
            else:
                counts_genus["NOT_FOUND"] += 1
                not_found_counter[acc] += 1
            if species:
                counts_species[species] += 1
            else:
                counts_species["NOT_FOUND"] += 1
    return total_lines, counts_genus, counts_species, not_found_counter

def save_counter_to_tsv(counter, path, header=("count","taxon")):
    with open(path, 'w', encoding='utf-8', newline='') as fh:
        fh.write(f"{header[0]}\t{header[1]}\n")
        for k, v in counter.most_common():
            fh.write(f"{v}\t{k}\n")

def save_not_found_list(not_found_counter, path):
    with open(path, 'w', encoding='utf-8', newline='') as fh:
        fh.write("accession\tcount\n")
        for acc, c in not_found_counter.most_common():
            fh.write(f"{acc}\t{c}\n")

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--plsdb", required=True, help="ruta a plsdb_summary.csv")
    p.add_argument("--edges", required=True, help="ruta a edges_observed.tsv")
    p.add_argument("--strip-version", action="store_true", help="quitar la parte .N de los accessions para emparejar")
    p.add_argument("--top", type=int, default=40, help="mostrar top N géneros")
    p.add_argument("--outdir", default="/tmp", help="directorio para guardar resultados")
    args = p.parse_args()

    os.makedirs(args.outdir, exist_ok=True)

    print("Cargando PLSDB (strip_version={})...".format(args.strip_version))
    acc_to_genus, acc_to_species = load_plsdb_map(args.plsdb, strip_version_flag=args.strip_version)
    print("Mapeadas {} accesiones de PLSDB".format(len(acc_to_genus)))

    print("Contando líneas en edges...")
    total_lines, counts_genus, counts_species, not_found_counter = count_edges(args.edges, acc_to_genus, acc_to_species, strip_version_flag=args.strip_version)
    print(f"Total de líneas procesadas en edges: {total_lines:,}")

    # show top genera
    print("\nTop géneros:")
    for i, (g, c) in enumerate(counts_genus.most_common(args.top), 1):
        print(f"{i:2d}. {g:30s} {c:8d}")

    # show Escherichia specifically
    ecoli_count = counts_genus.get("Escherichia", 0)
    print(f"\nLíneas totales asignadas a género 'Escherichia': {ecoli_count}")

    # Guarda resultados
    out_genus = os.path.join(args.outdir, "edges_counts_by_genus.tsv")
    out_species = os.path.join(args.outdir, "edges_counts_by_species.tsv")
    out_notfound = os.path.join(args.outdir, "edges_not_found_list.tsv")
    save_counter_to_tsv(counts_genus, out_genus, header=("count","genus"))
    save_counter_to_tsv(counts_species, out_species, header=("count","species"))
    save_not_found_list(not_found_counter, out_notfound)

    print(f"\nResultados guardados en:\n  {out_genus}\n  {out_species}\n  {out_notfound}")

if __name__ == "__main__":
    main()

