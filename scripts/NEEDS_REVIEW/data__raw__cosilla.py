#!/usr/bin/env python3
"""
filter_edges_ecoli_col.py

Filtra las líneas de edges_observed.tsv y imprime SOLO aquellas cuyo query_id:
  - aparece en plsdb_summary.csv como Escherichia_coli (o 'Escherichia' en species/genus),
  - y en plsdb_mob.csv tiene rep_type que contiene "col" (case-insensitive).

Salida (por stdout): la línea original de edges_observed.tsv + 
  TAB + NUCCORE_ACC_plsdb + TAB + rep_type + TAB + TAXONOMY_species

Opciones dentro del script:
  STRIP_VERSION = True  -> empareja NZ_CPxxxx.1 con NZ_CPxxxx
"""
import csv, re, sys
from collections import Counter

# -------- CONFIG --------
EDGES      = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/nucmer/graph_cov90_noclose/edges_observed.tsv"
PLSDB_SUM  = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/plsdb_summary.csv"   # para taxonomía (Escherichia_coli)
PLSDB_MOB  = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/plsdb_mob.csv"       # para rep_type
STRIP_VERSION = True    # True quita el sufijo .N de los accessions para emparejar
PAT_COL = re.compile(r"col", re.I)   # buscar "col" case-insensitive en rep_type
# ------------------------

def stripv(a):
    return re.sub(r"\.[0-9]+$", "", a)

def detect_delim_and_reader(path):
    # devuelve (delim, header_row_list, reader_factory)
    with open(path, 'r', encoding='utf-8', errors='replace') as fh:
        first = fh.readline()
    delim = '\t' if '\t' in first else ','
    return delim

# 1) leer edges, mantener lista de líneas y la columna query_id (preservando orden y repeticiones)
edges_rows = []
query_list = []   # in same order as rows
try:
    delim_e = detect_delim_and_reader(EDGES)
    with open(EDGES, newline='', encoding='utf-8', errors='replace') as fh:
        reader = csv.reader(fh, delimiter=delim_e)
        header = next(reader)
        # encontrar índice de query_id (case-insensitive)
        q_idx = None
        for i,h in enumerate(header):
            if h.strip().lower() in ("query_id","query","q","qry"):
                q_idx = i
                break
        if q_idx is None:
            # asumimos primera columna y tratamos la primera fila como dato (volver atrás)
            q_idx = 0
            fh.seek(0)
            reader = csv.reader(fh, delimiter=delim_e)
        else:
            # header ya consumida y reader apunta a la primera data row
            pass

        # guardamos la cabecera (si existe) para reimprimir en caso que queramos
        edges_has_header = any("query_id" in c.lower() or c.lower() in ("query","q") for c in header)

        # iterate rows
        for row in reader:
            if not row:
                edges_rows.append((None, None))  # placeholder
                query_list.append("")
                continue
            # aseguramos q_idx válido
            if q_idx >= len(row):
                acc = ""
            else:
                acc = row[q_idx].strip()
            key = stripv(acc) if STRIP_VERSION and acc else acc
            edges_rows.append((row, key))
            query_list.append(key)
except FileNotFoundError:
    sys.exit(f"ERROR: no se encuentra {EDGES}")

# 2) cargar plsdb_summary.csv -> map accession -> species (o genus)
plsdb_acc_to_species = {}
try:
    delim_s = detect_delim_and_reader(PLSDB_SUM)
    with open(PLSDB_SUM, newline='', encoding='utf-8', errors='replace') as fh:
        reader = csv.reader(fh, delimiter=delim_s)
        header = next(reader)
        # detectar índice columnas relevantes de forma tolerante
        def find_hdr(starts):
            for i,h in enumerate(header):
                if h.strip() in starts or h.strip().lower() in [s.lower() for s in starts]:
                    return i
            return None
        acc_i = find_hdr(["NUCCORE_ACC","nuccore_acc","NUCCORE_ACC\t"])
        species_i = find_hdr(["TAXONOMY.TAXONOMY_species","TAXONOMY.TAXONOMY_species\t","TAXONOMY.TAXONOMY_species","TAXONOMY_taxon_species"])
        genus_i = find_hdr(["TAXONOMY.TAXONOMY_genus","TAXONOMY.TAXONOMY_genus\t","TAXONOMY_taxon_genus"])
        if acc_i is None:
            sys.exit("ERROR: No encuentro columna NUCCORE_ACC en plsdb_summary.csv (revisa header).")

        for row in reader:
            if len(row) <= acc_i: continue
            acc = row[acc_i].strip()
            key = stripv(acc) if STRIP_VERSION and acc else acc
            species = row[species_i].strip() if (species_i is not None and len(row) > species_i) else ""
            genus = row[genus_i].strip() if (genus_i is not None and len(row) > genus_i) else ""
            # normalizar species/genus posibles variantes
            plsdb_acc_to_species[key] = species if species else genus
except FileNotFoundError:
    sys.exit(f"ERROR: no se encuentra {PLSDB_SUM}")

# 3) cargar plsdb_mob.csv -> map accession -> rep_type
plsdb_acc_to_reptype = {}
try:
    delim_m = detect_delim_and_reader(PLSDB_MOB)
    with open(PLSDB_MOB, newline='', encoding='utf-8', errors='replace') as fh:
        reader = csv.reader(fh, delimiter=delim_m)
        header = next(reader)
        # índices
        try:
            acc_i_m = [i for i,h in enumerate(header) if h.strip()=="NUCCORE_ACC"][0]
        except Exception:
            # tolerant search
            acc_i_m = None
            for i,h in enumerate(header):
                if h.strip().lower()=="nuccore_acc":
                    acc_i_m = i; break
        rep_i = None
        for i,h in enumerate(header):
            if h.strip().lower() == "rep_type".lower():
                rep_i = i; break
        if acc_i_m is None or rep_i is None:
            sys.exit("ERROR: No encuentro NUCCORE_ACC o rep_type en plsdb_mob.csv (revisa header).")
        for row in reader:
            if len(row) <= max(acc_i_m, rep_i): continue
            acc = row[acc_i_m].strip()
            rep = row[rep_i].strip()
            key = stripv(acc) if STRIP_VERSION and acc else acc
            if rep:  # guardar aunque no contenga 'col' por si quieres inspección posterior
                plsdb_acc_to_reptype[key] = rep
except FileNotFoundError:
    sys.exit(f"ERROR: no se encuentra {PLSDB_MOB}")

# 4) ahora filtramos: para cada línea en edges, comprobar condiciones y si se cumplen imprimir la línea original + info
matches = 0
printed_header = False

# si edges tenía header, reimprimimos la misma cabecera extendida
out_header_extra = ["NUCCORE_ACC_plsdb","rep_type","TAXONOMY_species"]
if edges_rows:
    # imprimir cabecera: si edges_has_header True, tenemos 'header' variable del parseo; de lo contrario, imprimimos una cabecera genérica
    if edges_rows and any(edges_rows):
        pass

# asegurar impresión de cabecera razonable
# si detectamos que edges file tenía header y lo leímos previamente, imprimimos esa cabecera (reconstruída)
# pero por simplicidad imprimimos siempre una cabecera compuesta si la primera fila parecía header (q_idx detectado originalmente)
# detect edges_has_header by checking first original header variable existence above
try:
    if edges_rows and hasattr(header, '__iter__') and any("query_id" in c.lower() for c in header):
        # header variable currently refers to last read header (from last opened file). To avoid confusion, recompute a simple header print:
        # read first line of EDGES to get header names:
        with open(EDGES, 'r', encoding='utf-8', errors='replace') as fh:
            first_line = fh.readline().rstrip('\n')
            delim_e = '\t' if '\t' in first_line else ','
            hdr_cols = first_line.split(delim_e)
        print(delim_e.join(hdr_cols) + "\t" + "\t".join(out_header_extra))
    else:
        # no header in edges -> print generic header
        print("col0\t...\t" + "\t".join(out_header_extra))
except Exception:
    print("\t".join(["<edges cols>"] + out_header_extra))

# iterate preserving original order
for (row, key) in edges_rows:
    if row is None:
        continue
    # key may be "" if parsing failed
    if not key:
        continue
    # check in plsdb_summary (Escherichia)
    species = plsdb_acc_to_species.get(key, "")
    if not species:
        continue
    # accept various species/genus formats: "Escherichia_coli", "Escherichia coli", "Escherichia"
    species_norm = species.replace(" ", "_")
    if not (species_norm.lower().startswith("escherichia") or species_norm.lower() == "escherichia_coli"):
        continue
    # check rep_type in plsdb_mob
    rep = plsdb_acc_to_reptype.get(key, "")
    if not rep:
        continue
    if not PAT_COL.search(rep):
        continue
    # passed all filters -> print original line + info
    # reconstruct original line with delimiter used in edges file (we used delim_e earlier)
    # join row with the originally-detected delim (delim_e)
    try:
        # detect delim again for safe join
        delim_e = '\t' if '\t' in open(EDGES, 'r', encoding='utf-8', errors='replace').readline() else ','
    except Exception:
        delim_e = '\t'
    print(delim_e.join(row) + "\t" + key + "\t" + rep + "\t" + species)
    matches += 1

# summary
print(f"\n# Total de líneas de edges que cumplen: {matches}", file=sys.stderr)

