#!/usr/bin/env python3

import pandas as pd
from pathlib import Path

BASE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing"

rows = []

for coords in Path(BASE).glob("work/*/coords/*.coords"):
    pair = coords.parents[1].name
    plasmA, plasmB = coords.stem.split("__")

    with open(coords) as f:
        for line in f:
            line = line.rstrip()

            # Saltar cabeceras
            if (
                not line
                or line.startswith("/")
                or line.startswith("NUCMER")
                or line.startswith("[")
                or line.startswith("=")
            ):
                continue

            # Líneas reales de alineamiento
            if "|" not in line:
                continue

            parts = [p.strip() for p in line.split("|")]

            try:
                s1, e1 = map(int, parts[0].split())
                s2, e2 = map(int, parts[1].split())

                len1, len2 = map(int, parts[2].split())
                pid = float(parts[3])

                len_r, len_q = map(int, parts[4].split())
                cov_r, cov_q = map(float, parts[5].split())

                tags = parts[6] if len(parts) > 6 else ""
            except Exception:
                continue

            rows.append({
                "replicon_pair": pair,
                "plasmid_A": plasmA,
                "plasmid_B": plasmB,
                "start_A": s1,
                "end_A": e1,
                "start_B": s2,
                "end_B": e2,
                "aln_len_A": len1,
                "aln_len_B": len2,
                "pct_identity": pid,
                "plasmid_len_A": len_r,
                "plasmid_len_B": len_q,
                "cov_A_pct": cov_r,
                "cov_B_pct": cov_q,
                "tags": tags
            })

df = pd.DataFrame(rows)

out = f"{BASE}/coords_all_hits.tsv"
df.to_csv(out, sep="\t", index=False)

print(f"Wrote {len(df)} alignment hits to {out}")
print(df.head())

