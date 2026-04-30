#!/usr/bin/env python3

import pandas as pd
from pathlib import Path
from multiprocessing import Pool

BASE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing"
LIST = Path(BASE) / "coords_with_hits.list"
NCORES = 30
OUT = Path(BASE) / "coords_all_hits.tsv"

def parse_one(path_str):
    rows = []
    coords = Path(path_str)
    pair = coords.parents[1].name
    plasmA, plasmB = coords.stem.split("__")

    with open(coords) as f:
        for line in f:
            line = line.rstrip()
            if (
                not line
                or line.startswith("/")
                or line.startswith("NUCMER")
                or line.startswith("[")
                or line.startswith("=")
                or "|" not in line
            ):
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

            rows.append([
                pair, plasmA, plasmB,
                s1, e1, s2, e2,
                len1, len2, pid,
                len_r, len_q, cov_r, cov_q,
                tags
            ])
    return rows

def main():
    coords_files = [l.strip() for l in open(LIST) if l.strip()]
    print(f"Parsing {len(coords_files)} coords with hits")

    # Write header once
    with open(OUT, "w") as out:
        out.write(
            "replicon_pair\tplasmid_A\tplasmid_B\t"
            "start_A\tend_A\tstart_B\tend_B\t"
            "aln_len_A\taln_len_B\tpct_identity\t"
            "plasmid_len_A\tplasmid_len_B\t"
            "cov_A_pct\tcov_B_pct\ttags\n"
        )

    with Pool(processes=NCORES) as pool:
        for chunk in pool.imap_unordered(parse_one, coords_files, chunksize=100):
            if not chunk:
                continue
            df = pd.DataFrame(chunk)
            df.to_csv(OUT, sep="\t", index=False, header=False, mode="a")

if __name__ == "__main__":
    main()

