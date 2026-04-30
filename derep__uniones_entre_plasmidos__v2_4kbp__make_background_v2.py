#!/usr/bin/env python3
#
# make_background_v2.py
#
# Genera ventanas de background de ±2000 bp (4001 bp totales),
# estratificadas por replicón y con soporte para circularidad.
#
# Salida: background_windows_v2.tsv
#
import os
import random

WINDOW = 2000  # half-window → total window = 4001 bp
FG_FILE = "breakpoints_windows_to_fetch.tsv"
FA_DIR = "fasta"
OUT = "background_windows_v2.tsv"

# ------------------------------------------------------------
# Leer cuántas ventanas foreground hay por replicón
# ------------------------------------------------------------
counts = {}
with open(FG_FILE) as f:
    for i, line in enumerate(f):
        if line.startswith("#"): 
            continue
        parts = line.strip().split("\t")
        if len(parts) < 4:
            continue
        chrom = parts[0]
        counts[chrom] = counts.get(chrom, 0) + 1

print("Replicones encontrados en foreground:", len(counts))

# ------------------------------------------------------------
# Función para obtener longitud del replicón desde FASTA + FAI
# ------------------------------------------------------------
def get_length(chrom):
    for suf in [".fna", ".fa", ".fasta"]:
        path = os.path.join(FA_DIR, chrom + suf)
        fai = path + ".fai"
        if os.path.exists(fai):
            with open(fai) as fh:
                for line in fh:
                    fields = line.split("\t")
                    if fields[0] == chrom:
                        return int(fields[1])
    return None

# ------------------------------------------------------------
# Generar background
# ------------------------------------------------------------
out_rows = []

for chrom, k in counts.items():
    L = get_length(chrom)
    if not L:
        print(f"WARNING: No length found for {chrom}, skipping")
        continue

    print(f"{chrom}: sampling {k} windows (L={L})")

    sampled = set()
    tries = 0
    max_tries = k * 200

    while len(sampled) < k and tries < max_tries:
        center = random.randint(1, L)
        s = center - WINDOW
        e = center + WINDOW

        if s >= 1 and e <= L:
            # no wrap
            key = f"{chrom}:{s}-{e}"
        elif s < 1:
            # wrap at left
            p1s = L + s + 1
            p1e = L
            p2s = 1
            p2e = e
            key = f"{chrom}:{p1s}-{p1e}|{p2s}-{p2e}"
        else:
            # e > L → wrap at right
            p1s = s
            p1e = L
            p2s = 1
            p2e = e - L
            key = f"{chrom}:{p1s}-{p1e}|{p2s}-{p2e}"

        if key not in sampled:
            sampled.add(key)

        tries += 1

    # convertir sampled → filas de salida
    for entry in sampled:
        if "|" in entry:
            # wrapped
            left, right = entry.split("|")
            chromA, rangeA = left.split(":")
            s1, e1 = rangeA.split("-")
            s2, e2 = right.split("-")
            out_rows.append((chromA, s1, e1, s2, e2))
        else:
            chromA, rangeA = entry.split(":")
            s1, e1 = rangeA.split("-")
            out_rows.append((chromA, s1, e1, "", ""))

# ------------------------------------------------------------
# Guardar salida
# ------------------------------------------------------------
with open(OUT, "w") as o:
    o.write("#chrom\tp1_start\tp1_end\tp2_start\tp2_end\n")
    for r in out_rows:
        o.write("\t".join(map(str, r)) + "\n")

print(f"BACKGROUND listo → {OUT}")
print(f"Total ventanas background: {len(out_rows)}")

