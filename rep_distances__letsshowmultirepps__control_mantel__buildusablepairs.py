#!/usr/bin/env python3
import os
import ast
from itertools import combinations
import pandas as pd

# ============================================================
# CONFIG
# ============================================================
BASE_DIR = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/control_mantel"
META_DIR = "/home/nacho/Downloads/meta"
MANTEL_RESULTS = "/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/pairwise_mantel_results.tsv"

if not os.path.exists(MANTEL_RESULTS):
    alt = os.path.join(BASE_DIR, "pairwise_mantel_results.tsv")
    if os.path.exists(alt):
        MANTEL_RESULTS = alt

OUT_DIR = BASE_DIR
os.makedirs(OUT_DIR, exist_ok=True)

NUCCORE_FILE = os.path.join(META_DIR, "nuccore.csv")
ASSEMBLY_FILE = os.path.join(META_DIR, "assembly.csv")
TYPING_FILE = os.path.join(META_DIR, "typing.csv")

# ============================================================
# HELPERS
# ============================================================
def safe_eval(x):
    if pd.isna(x):
        return []
    if isinstance(x, str):
        try:
            return ast.literal_eval(x)
        except Exception:
            return []
    return x

def parse_rep(x):
    if pd.isna(x):
        return []
    return [r.strip() for r in str(x).split(",") if r.strip()]

def canon_pair(a, b):
    a, b = sorted([str(a), str(b)])
    return f"{a}__{b}"

def clean_mantel_rep(x):
    x = str(x).strip()
    x = x.replace("_all_aligned.fasta", "")
    x = x.replace("_aligned.fasta", "")
    x = x.replace(".fasta", "")
    return x

# ============================================================
# 1. LOAD INPUTS
# ============================================================
print("Loading inputs...")
nuccore = pd.read_csv(NUCCORE_FILE)
assembly = pd.read_csv(ASSEMBLY_FILE)
typing = pd.read_csv(TYPING_FILE)
mantel = pd.read_csv(MANTEL_RESULTS, sep="\t")

required_cols = {"repA", "repB"}
missing = required_cols - set(mantel.columns)
if missing:
    raise ValueError(f"Mantel results missing columns: {missing}")

mantel = mantel.copy()
mantel["repA_raw"] = mantel["repA"]
mantel["repB_raw"] = mantel["repB"]
mantel["repA"] = mantel["repA"].apply(clean_mantel_rep)
mantel["repB"] = mantel["repB"].apply(clean_mantel_rep)
mantel["pair"] = mantel.apply(lambda r: canon_pair(r["repA"], r["repB"]), axis=1)
mantel_pairs = set(mantel["pair"])

print(f"Mantel pairs loaded: {len(mantel_pairs)}")
print("Example cleaned Mantel pairs:")
print(mantel[["repA_raw", "repA", "repB_raw", "repB"]].head(10).to_string(index=False))

# ============================================================
# 2. ASSEMBLY -> NUCCORE -> TYPING
# ============================================================
print("Expanding assembly -> nuccore links...")
assembly = assembly.copy()
assembly["NUCCORE_UID"] = assembly["NUCCORE_UID"].apply(safe_eval)
assembly_long = assembly.explode("NUCCORE_UID").dropna(subset=["NUCCORE_UID"])

df = assembly_long.merge(
    nuccore[["NUCCORE_UID", "NUCCORE_ACC"]],
    on="NUCCORE_UID",
    how="left"
)

df = df.merge(
    typing[["NUCCORE_ACC", "rep_type(s)"]],
    on="NUCCORE_ACC",
    how="left"
)

print(f"Rows after assembly->nuccore->typing merge: {len(df)}")

# parse replicons
print("Parsing replicon lists...")
df["rep_types"] = df["rep_type(s)"].apply(parse_rep)
df_long = df.explode("rep_types").dropna(subset=["rep_types"]).reset_index(drop=True)

print(f"Rows after exploding replicons: {len(df_long)}")

# quick sanity check
typing_reps = set(df_long["rep_types"].astype(str))
mantel_reps = set(mantel["repA"].astype(str)) | set(mantel["repB"].astype(str))
inter = mantel_reps & typing_reps
print(f"Mantel replicons: {len(mantel_reps)}")
print(f"Typing replicons: {len(typing_reps)}")
print(f"Intersection after cleaning: {len(inter)}")

# ============================================================
# 3. BUILD CELL-LEVEL STRUCTURE FOR MANTEL PAIRS ONLY
# ============================================================
print("Scanning assemblies for Mantel-pair coexistence...")
rows = []

for cell, sub in df_long.groupby("ASSEMBLY_ACC"):
    plasmids = (
        sub.groupby("NUCCORE_ACC")["rep_types"]
        .apply(lambda x: set(x))
        .to_dict()
    )

    if not plasmids:
        continue

    reps_in_cell = set().union(*plasmids.values())
    if len(reps_in_cell) < 2:
        continue

    for a, b in combinations(sorted(reps_in_cell), 2):
        pair = canon_pair(a, b)
        if pair not in mantel_pairs:
            continue

        plasmids_with_a = sorted([p for p, reps in plasmids.items() if a in reps])
        plasmids_with_b = sorted([p for p, reps in plasmids.items() if b in reps])

        shared = sorted(set(plasmids_with_a) & set(plasmids_with_b))
        a_only = sorted(set(plasmids_with_a) - set(shared))
        b_only = sorted(set(plasmids_with_b) - set(shared))

        same_plasmid = len(shared) > 0
        has_separated = (len(a_only) > 0 and len(b_only) > 0)
        unique_separated = (len(a_only) == 1 and len(b_only) == 1)

        if same_plasmid and not has_separated:
            status = "same_plasmid_only"
        elif (not same_plasmid) and unique_separated:
            status = "separated_unique"
        elif (not same_plasmid) and has_separated:
            status = "separated_ambiguous"
        elif same_plasmid and has_separated:
            status = "mixed_same_and_separated"
        else:
            status = "other"

        rows.append({
            "ASSEMBLY_ACC": cell,
            "pair": pair,
            "repA": a,
            "repB": b,
            "same_plasmid": int(same_plasmid),
            "has_separated": int(has_separated),
            "status": status,
            "n_plasmids_with_repA": len(plasmids_with_a),
            "n_plasmids_with_repB": len(plasmids_with_b),
            "plasmids_with_repA": ";".join(plasmids_with_a),
            "plasmids_with_repB": ";".join(plasmids_with_b),
            "shared_plasmids": ";".join(shared),
            "repA_separate_plasmids": ";".join(a_only),
            "repB_separate_plasmids": ";".join(b_only),
            "repA_control_plasmid": a_only[0] if len(a_only) == 1 else "",
            "repB_control_plasmid": b_only[0] if len(b_only) == 1 else "",
        })

# ============================================================
# 4. SAVE MASTER TABLE
# ============================================================
master = pd.DataFrame(rows)
if master.empty:
    raise RuntimeError(
        "No Mantel-pair coexistence records were found even after cleaning Mantel replicon names."
    )

master_out = os.path.join(OUT_DIR, "control_mantel_cell_contexts.tsv")
master.to_csv(master_out, sep="\t", index=False)
print(f"Wrote: {master_out}")

# ============================================================
# 5. SUMMARISE BY PAIR
# ============================================================
pair_summary = (
    master.groupby(["pair", "repA", "repB"], as_index=False)
    .agg(
        n_same_cell=("ASSEMBLY_ACC", "nunique"),
        n_same_plasmid_only=("status", lambda x: int((x == "same_plasmid_only").sum())),
        n_separated_unique=("status", lambda x: int((x == "separated_unique").sum())),
        n_separated_ambiguous=("status", lambda x: int((x == "separated_ambiguous").sum())),
        n_mixed_same_and_separated=("status", lambda x: int((x == "mixed_same_and_separated").sum())),
    )
)

mantel_extra = mantel.drop(columns=[c for c in ["repA", "repB", "repA_raw", "repB_raw"] if c in mantel.columns]).drop_duplicates("pair")
pair_summary = pair_summary.merge(
    mantel_extra,
    on="pair",
    how="left"
)

pair_summary["n_control_usable"] = pair_summary["n_separated_unique"]
pair_summary["has_usable_control"] = pair_summary["n_control_usable"] > 0

summary_out = os.path.join(OUT_DIR, "control_mantel_pair_summary.tsv")
pair_summary.to_csv(summary_out, sep="\t", index=False)
print(f"Wrote: {summary_out}")

# ============================================================
# 6. KEEP USABLE CONTROL OBSERVATIONS ONLY
# ============================================================
usable = master[master["status"] == "separated_unique"].copy()

usable_out = os.path.join(OUT_DIR, "control_mantel_usable_observations.tsv")
usable.to_csv(usable_out, sep="\t", index=False)
print(f"Wrote: {usable_out}")

usable_pairs = sorted(usable["pair"].unique())
usable_pairs_out = os.path.join(OUT_DIR, "usable_control_pairs.txt")
with open(usable_pairs_out, "w") as oh:
    for p in usable_pairs:
        oh.write(p + "\n")
print(f"Wrote: {usable_pairs_out}")
print(f"Usable pairs: {len(usable_pairs)}")

# ============================================================
# 7. QUICK REPORT
# ============================================================
report = {
    "n_mantel_pairs_total": len(mantel_pairs),
    "n_mantel_pairs_seen_in_same_cell": int(master["pair"].nunique()),
    "n_pairs_with_usable_control": int(usable["pair"].nunique()),
    "n_usable_observations_total": int(len(usable)),
}

report_path = os.path.join(OUT_DIR, "control_mantel_report.txt")
with open(report_path, "w") as oh:
    for k, v in report.items():
        oh.write(f"{k}\t{v}\n")
print(f"Wrote: {report_path}")

print("Done.")
