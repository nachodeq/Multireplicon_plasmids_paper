#!/usr/bin/env python3
# Extraer secuencias de replicones (IncFII + rep_cluster_2183) usando resultados de MOB-typer
# Requisitos:
#  - Directorio MOB_DIR con archivos como AP019816.1_summary.txt y subcarpetas AP019816.1_analysis/replicon_blast_results.txt
#  - FASTA de los plasmidos en FASTAS_SRC (cada plasmid en un fichero fasta único, cerrado)
#  - No se extraen proteínas
# Salida:
#  - OUT_DIR/incfII_rep_2183/Accession_INCFII.fa  y Accession_rep_2183.fa
#  - OUT_DIR/replicones_incFII_rep2183_summary.tsv

import os
import glob
import pandas as pd
from Bio import SeqIO

# ---------------- Ajustes (modifica rutas si hace falta) ----------------
MOB_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/mobtyper"
FASTAS_SRC = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/fasta"
OUT_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons"
OUT_REP_DIR = os.path.join(OUT_DIR, "incFII_colrna")
os.makedirs(OUT_REP_DIR, exist_ok=True)

# Archivo de representantes dereplicados (solo procesar accessions que aparezcan aquí)
DEREP_FILE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/louvain_by_level_from_table_including_isolates/representatives_by_cluster_level.tsv"

# replicones a buscar (strings que aparecen en rep_type(s))
REQUIRED_REP_A = "IncFII"
REQUIRED_REP_B = "ColRNAI_rep_cluster_1857"

# nombres de sufijo de archivo para cada replicon
def rep_tag(rep_type):
    if "IncFII" in rep_type:
        return "INCFII"
    if "rep_cluster_2183" in rep_type:
        return "rep_2183"
    # fallback: limpiar caracteres no alfanuméricos
    return rep_type.replace(',', '_').replace(' ', '_')

# util
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

# ---------------- Leer tabla de representantes dereplicados ----------------
if not os.path.exists(DEREP_FILE):
    raise FileNotFoundError(f"Derep representatives file not found: {DEREP_FILE}")
derep_df = pd.read_csv(DEREP_FILE, sep="\t", dtype=str, keep_default_na=False)
if "representative" not in derep_df.columns:
    raise ValueError(f"'representative' column not found in {DEREP_FILE}")
derep_representatives = set(derep_df["representative"].dropna().astype(str).tolist())
print(f"Loaded {len(derep_representatives)} dereplicated representatives from {DEREP_FILE}.")

# leer todos los summary files en MOB_DIR
summary_files = sorted(glob.glob(os.path.join(MOB_DIR, "*_summary.txt")))
if not summary_files:
    raise FileNotFoundError("No summary files found in MOB_DIR: " + MOB_DIR)

rows_out = []
missing = []

# index FASTA files for quick lookup by basename
fasta_index = {}
for p in glob.glob(os.path.join(FASTAS_SRC, "*")):
    b = basename_noext(p)
    if b not in fasta_index:
        fasta_index[b] = p

print(f"Found {len(summary_files)} summary files. Index FASTAs: {len(fasta_index)} entries.")

for sf in summary_files:
    # filename like AP019816.1_summary.txt
    acc = os.path.basename(sf).replace('_summary.txt', '')
    # saltar si no es representante en la tabla de dereplicación
    if acc not in derep_representatives:
        continue

    try:
        df = pd.read_csv(sf, sep='\t', dtype=str, keep_default_na=False)
    except Exception as e:
        print("Warning: could not read summary", sf, e)
        continue

    # tomar la primera fila (cada summary es una fila por sample)
    if df.shape[0] == 0:
        print("Warning: empty summary file:", sf)
        continue
    row = df.iloc[0]
    rep_types = str(row.get('rep_type(s)', '')).strip()
    rep_accessions = str(row.get('rep_type_accession(s)', '')).strip()

    # requerir que los dos replicones estén presentes
    if (REQUIRED_REP_A not in rep_types) or (REQUIRED_REP_B not in rep_types):
        # skip plasmids que no tengan ambos
        continue

    print("Processing plasmid:", acc)

    # split accessions en lista, manteniendo el orden
    acc_list = [a.strip() for a in rep_accessions.replace(';', ',').split(',') if a.strip()]
    type_list = [t.strip() for t in rep_types.replace(';', ',').split(',') if t.strip()]

    # construir mapping tipo->accession: asumo mismo orden
    type_to_accessions = {}
    for i, t in enumerate(type_list):
        if i < len(acc_list):
            type_to_accessions.setdefault(t, []).append(acc_list[i])

    # ---------------- CORRECCIÓN: construir needed SOLO con t que contenga los strings requeridos -----------
    needed = []
    for t, accs in type_to_accessions.items():
        # añadir sólo si el TIPO (t) contiene la cadena buscada
        if REQUIRED_REP_A in t:
            for a in accs:
                needed.append((t, a))
        if REQUIRED_REP_B in t:
            for a in accs:
                needed.append((t, a))
    # -----------------------------------------------------------------------------------------------

    # eliminación de duplicados (manteniendo orden)
    seen = set()
    needed_unique = []
    for item in needed:
        if item not in seen:
            needed_unique.append(item)
            seen.add(item)
    needed = needed_unique

    if len(needed) == 0:
        print(f"  No matching replicons found for {acc} after filtering by required types; skipping.")
        continue

    print(f"  Will extract replicons for {acc}: {needed}")

    # leer replicon_blast_results.txt en la carpeta analysis
    analysis_dir = os.path.join(MOB_DIR, acc + "_analysis")
    blast_file = os.path.join(analysis_dir, 'replicon_blast_results.txt')
    if not os.path.exists(blast_file):
        raise FileNotFoundError(f"Missing replicon_blast_results.txt for {acc} in {analysis_dir}")

    # leer blast results
    blast_df = pd.read_csv(blast_file, sep='\t', dtype=str, keep_default_na=False)
    # asegurar campos numéricos
    for c in ['sstart', 'send', 'bitscore']:
        if c in blast_df.columns:
            blast_df[c] = pd.to_numeric(blast_df[c], errors='coerce')

    # localizar FASTA del plasmido
    fasta_path = None
    bacc = basename_noext(acc)
    if bacc in fasta_index:
        fasta_path = fasta_index[bacc]
    else:
        # intentar buscar comodín
        matches = glob.glob(os.path.join(FASTAS_SRC, f"*{bacc}*"))
        if matches:
            fasta_path = matches[0]
    if fasta_path is None:
        raise FileNotFoundError(f"FASTA not found for plasmid {acc} (basename {bacc}) in {FASTAS_SRC}")

    # cargar secuencia del fasta (suponemos un solo contig por fichero)
    with open(fasta_path) as fh:
        seqs = list(SeqIO.parse(fh, 'fasta'))
        if len(seqs) == 0:
            raise ValueError(f"No sequences found in FASTA {fasta_path}")
        if len(seqs) > 1:
            print(f"Warning: FASTA {fasta_path} has {len(seqs)} contigs; using first one")
        seq_record = seqs[0]
    seq_len = len(seq_record.seq)

    # para cada replicon accession requerido
    for rep_type, rep_acc in needed:
        token = rep_acc
        # buscar filas cuyo qseqid contenga token (sin interpretación regex)
        if 'qseqid' not in blast_df.columns:
            raise ValueError(f"'qseqid' column not in blast results for {acc} ({blast_file})")
        # usar regex=False para evitar interpretar caracteres especiales del token
        matches = blast_df[blast_df['qseqid'].str.contains(token, na=False, regex=False)]
        if matches.empty:
            # según tu instrucción, si no hay hit -> saltar error
            raise ValueError(f"No blast hits found for replicon accession {token} in {blast_file} (plasmid {acc})")
        # elegir mejor hit por bitscore (mayor)
        if 'bitscore' in matches.columns and matches['bitscore'].notna().any():
            best_idx = matches['bitscore'].idxmax()
            hit = matches.loc[best_idx]
        else:
            # fallback: primera coincidencia
            hit = matches.iloc[0]

        # extraer coordenadas
        sstart = int(hit['sstart'])
        send = int(hit['send'])
        sstrand = hit.get('sstrand', 'plus')
        sseqid = hit.get('sseqid', '')

        # validar coordenadas
        if sstart < 1 or send < 1 or sstart > seq_len or send > seq_len:
            raise ValueError(f"Coordinates out of range for {acc} (len {seq_len}): sstart={sstart}, send={send}, fasta={fasta_path}")

        # convert to 0-based python indices
        a = min(sstart, send) - 1
        b = max(sstart, send)  # python slice end is exclusive
        subseq = seq_record.seq[a:b]
        if sstrand.lower() == 'minus':
            subseq = subseq.reverse_complement()

        # nombre de salida
        tag = rep_tag(rep_type)
        out_fname = f"{acc}__{tag}.fa"
        out_path = os.path.join(OUT_REP_DIR, out_fname)
        # escribir fasta
        with open(out_path, 'w') as oh:
            header = (
                f">{acc}|{tag}|source:{os.path.basename(blast_file)}"
                f"|qseqid:{hit.get('qseqid','')}|sseqid:{sseqid}"
                f"|sstart:{sstart}|send:{send}|sstrand:{sstrand}\n"
            )
            oh.write(header)
            oh.write(str(subseq) + "\n")

        # guardar fila resumen
        rows_out.append({
            'plasmid_id': acc,
            'basename': bacc,
            'rep_type': rep_type,
            'rep_accession': rep_acc,
            'blast_qseqid': hit.get('qseqid', ''),
            'blast_sseqid': sseqid,
            'sstart': sstart,
            'send': send,
            'sstrand': sstrand,
            'fasta_path': fasta_path,
            'rep_fasta_path': out_path,
            'notes': ''
        })

# guardar resumen
summary_out = os.path.join(OUT_DIR, 'replicones_incFII_rep2183_summary.tsv')
pd.DataFrame(rows_out).to_csv(summary_out, sep='\t', index=False)
print('Saved summary to', summary_out)
print('Extracted replicons to', OUT_REP_DIR)

# guardar missing si hay
if missing:
    miss_path = os.path.join(OUT_DIR, 'replicones_missing.tsv')
    pd.DataFrame(missing).to_csv(miss_path, sep='\t', index=False)
    print('Missing entries saved to', miss_path)

