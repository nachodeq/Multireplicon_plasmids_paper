#!/usr/bin/env python3
import csv, re
from pathlib import Path

BASE  = Path("/home/nacho/HDD16/Nacho/RepliCOOC")
NODES = BASE / "results/wgrr_pairs/nodes.tsv"
WORK  = BASE / "results/mr_vs_familyspace"
WORK.mkdir(parents=True, exist_ok=True)

def norm_combo_commas(x: str) -> str:
    """Divide SOLO por comas, limpia espacios y normaliza como 'A|B|C'."""
    if not x:
        return "NA"
    parts = [p.strip() for p in x.split(",")]
    parts = [p for p in parts if p]
    return "|".join(sorted(set(parts))) if parts else "NA"

# Carga nodes.tsv (tabulado)
with open(NODES) as f:
    r = csv.DictReader(f, delimiter="\t")
    rows = list(r)

meta_path = WORK / "meta_min.tsv"
ref_list  = WORK / "ref.list"
mr_list   = WORK / "mr.list"

with open(meta_path, "w") as m, open(ref_list, "w") as rl, open(mr_list, "w") as ml:
    m.write("plasmid_id\tcombo\tis_multi\n")
    for d in rows:
        pid  = d.get("plasmid_id") or d.get("plasmid") or d.get("id")
        faa  = d.get("faa")
        nrep_raw = d.get("n_replicons", "1")
        try:
            nrep = int(nrep_raw) if nrep_raw not in (None, "") else 1
        except:
            nrep = 1
        combo = norm_combo_commas(d.get("replicon_types") or d.get("replicon") or "")
        is_multi = "1" if nrep >= 2 else "0"
        if not pid:
            continue
        m.write(f"{pid}\t{combo}\t{is_multi}\n")
        if faa:
            rl.write(faa + "\n")
            if nrep >= 2:
                ml.write(faa + "\n")

print("Wrote:")
print(" -", meta_path)
print(" -", ref_list)
print(" -", mr_list)

