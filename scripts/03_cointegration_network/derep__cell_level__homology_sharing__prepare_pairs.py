#!/usr/bin/env python3

import pandas as pd
import os
import re

# ============================================================
# CONFIG
# ============================================================

BASE = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing"

PAIRS_TABLE = f"{BASE}/pairs_table.csv"
REPLICONS_TSV = "/home/nacho/HDD16/Nacho/RepliCOOC/derep/plasmid_replicons.tsv"
VALID_PLASMIDS = f"{BASE}/valid_plasmids.txt"

WORKDIR = f"{BASE}/work"

# ============================================================
# HELPERS
# ============================================================

def safe_name(x: str) -> str:
    """
    Convert a biological name into a filesystem-safe name.
    Only used for directory names.
    """
    x = x.strip()
    x = x.replace("/", "_")
    x = x.replace(" ", "_")
    x = x.replace("(", "")
    x = x.replace(")", "")
    x = re.sub(r"__+", "_", x)
    return x

# ============================================================
# LOAD DATA
# ============================================================

pairs = pd.read_csv(PAIRS_TABLE)

rep = pd.read_csv(
    REPLICONS_TSV,
    sep="\t",
    dtype=str
)

# Ensure numeric
rep["n_replicons"] = rep["n_replicons"].astype(int)

# Load valid plasmids universe
with open(VALID_PLASMIDS) as f:
    valid_plasmids = set(line.strip() for line in f if line.strip())

# Restrict replicon table to valid plasmids
rep = rep[rep["plasmid_id"].isin(valid_plasmids)].copy()

# Parse replicon lists
rep["replicon_list"] = (
    rep["replicon_types"]
    .fillna("")
    .apply(lambda x: [r.strip() for r in x.split(",") if r.strip()])
)

# ============================================================
# MAIN LOOP
# ============================================================

os.makedirs(WORKDIR, exist_ok=True)

for _, row in pairs.iterrows():

    # Biological names (DO NOT TOUCH)
    repA_raw = row["repA"]
    repB_raw = row["repB"]

    # Filesystem-safe names
    repA = safe_name(repA_raw)
    repB = safe_name(repB_raw)

    pair_dir = f"{WORKDIR}/{repA}__{repB}"
    os.makedirs(pair_dir, exist_ok=True)

    # --------------------------------------------------------
    # Select A-only / B-only plasmids
    # --------------------------------------------------------

    A_only = rep[
        (rep["n_replicons"] == 1) &
        (rep["replicon_list"].apply(lambda x: repA_raw in x))
    ]["plasmid_id"].astype(str).tolist()

    B_only = rep[
        (rep["n_replicons"] == 1) &
        (rep["replicon_list"].apply(lambda x: repB_raw in x))
    ]["plasmid_id"].astype(str).tolist()

    # --------------------------------------------------------
    # Write lists (ALWAYS create files, even if empty)
    # --------------------------------------------------------

    with open(f"{pair_dir}/A_only.list", "w") as fa:
        fa.write("\n".join(A_only) + ("\n" if A_only else ""))

    with open(f"{pair_dir}/B_only.list", "w") as fb:
        fb.write("\n".join(B_only) + ("\n" if B_only else ""))

    # --------------------------------------------------------
    # Log summary
    # --------------------------------------------------------

    print(
        f"{repA_raw}__{repB_raw}  "
        f"A_only={len(A_only):4d}  "
        f"B_only={len(B_only):4d}"
    )

print("\nDone.")

