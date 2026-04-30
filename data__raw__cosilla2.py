#!/usr/bin/env python3
import csv, re
from collections import defaultdict

MOB = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/plsdb_mob.csv"
SUM = "/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/plsdb_summary.csv"

# -------------------------------
# 1) Cargar taxonomía (hosts)
# -------------------------------
acc_to_genus = {}

with open(SUM, encoding="utf-8") as f:
    first = f.readline()
    delim = "\t" if "\t" in first else ","
    f.seek(0)
    r = csv.reader(f, delimiter=delim)
    header = next(r)

    acc_i   = header.index("NUCCORE_ACC")
    genus_i = header.index("TAXONOMY.TAXONOMY_genus")

    for row in r:
        if len(row) <= max(acc_i, genus_i): continue
        acc = row[acc_i].strip()
        genus = row[genus_i].strip()
        acc_to_genus[acc] = genus


# ---------------------------------------
# 2) Cargar replicones desde plsdb_mob
# ---------------------------------------
replicon_to_genus = defaultdict(set)

with open(MOB, encoding="utf-8") as f:
    first = f.readline()
    delim = "\t" if "\t" in first else ","
    f.seek(0)
    r = csv.reader(f, delimiter=delim)
    header = next(r)

    acc_i  = header.index("NUCCORE_ACC")
    rep_i  = header.index("rep_type")

    for row in r:
        if len(row) <= max(acc_i, rep_i): continue
        acc = row[acc_i].strip()
        reps = row[rep_i].strip()

        if not reps:
            continue

        # separar por coma (pueden venir varios replicones)
        rep_list = [r.strip() for r in reps.split(",") if r.strip()]

        # buscar el género del host
        genus = acc_to_genus.get(acc, None)
        if not genus:
            continue

        # asociar cada replicón al género
        for rep in rep_list:
            replicon_to_genus[rep].add(genus)


# ---------------------------------------
# 3) Imprimir replicones ordenados
# ---------------------------------------
# lista: (n_generos, replicon, lista_generos)
ordered = sorted(
    [(len(gen), rep, sorted(gen)) for rep, gen in replicon_to_genus.items()],
    key=lambda x: x[0]
)

print("replicon\tn_hosts\tgenera")
for n, rep, gen_list in ordered:
    print(f"{rep}\t{n}\t{','.join(gen_list)}")

