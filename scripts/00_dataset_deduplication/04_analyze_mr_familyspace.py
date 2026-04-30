#!/usr/bin/env python3
import csv, re
from pathlib import Path
from collections import defaultdict, Counter

BASE = Path("/home/nacho/HDD16/Nacho/RepliCOOC")
WORK = BASE / "results/mr_vs_familyspace"
CLUSTERS = WORK / "clusters.tsv"
META_MIN = WORK / "meta_min.tsv"   # id \t combo \t is_multi

PRESENCE_THRESH = 0.90  # ≥90% genes presentes => “fully present”

def parse_combo(c):
    if not c or c == "NA":
        return frozenset()
    return frozenset([x for x in c.split("|") if x])

hdr_re = re.compile(r'^(MR|REF)\|([^|]+)\|([^|]*)\|(.+)$')  # kind|id|combo|prot

# ---- carga metadatos ----
id2combo = {}
id_is_multi = {}
with META_MIN.open() as f:
    r = csv.DictReader(f, delimiter="\t")
    for d in r:
        pid = d["plasmid_id"]
        id2combo[pid] = parse_combo(d["combo"])
        id_is_multi[pid] = (d["is_multi"] in ("1","true","TRUE","multi"))

# ---- parse clusters ----
cluster_members = defaultdict(list)
prot2cluster = {}
with CLUSTERS.open() as f:
    rd = csv.reader(f, delimiter="\t")
    for rep, mem in rd:
        cluster_members[rep].append(mem)
        prot2cluster[mem] = rep

# índices por cluster
clu_MR_ids = defaultdict(set)
clu_REF_ids = defaultdict(set)
for rep, members in cluster_members.items():
    for m in members:
        m0 = m.lstrip(">").split()[0]
        mm = hdr_re.match(m0)
        if not mm: 
            continue
        kind, pid, combo, prot = mm.groups()
        if kind == "MR":
            clu_MR_ids[rep].add(pid)
        else:
            clu_REF_ids[rep].add(pid)

# proteínas por id (para denominadores)
ref_prots = defaultdict(set)
mr_prots  = defaultdict(set)
for mem, rep in prot2cluster.items():
    m0 = mem.lstrip(">").split()[0]
    mm = hdr_re.match(m0)
    if not mm:
        continue
    kind, pid, combo, prot = mm.groups()
    (ref_prots if kind=="REF" else mr_prots)[pid].add(mem)

ref_ids = sorted(ref_prots.keys())
mr_ids  = sorted([pid for pid, isM in id_is_multi.items() if isM])

# -------- análisis por MR --------
out_path = WORK / "mr_vs_familyspace_matches.tsv"
with out_path.open("w") as fo:
    w = csv.writer(fo, delimiter="\t", lineterminator="\n")
    w.writerow(["MR_id","MR_combo","k",
                "REF_id","REF_combo","ref_size",
                "n_genes","n_present","fraction_present","threshold","fully_present_>=threshold"])
    for mr in mr_ids:
        S = id2combo.get(mr, frozenset())
        if not S: 
            continue
        k = len(S)

        # universo: singles dentro de S
        singles = [rid for rid in ref_ids if len(id2combo.get(rid, frozenset()))==1 and id2combo[rid].issubset(S)]
        # universo: (k-1) subconjuntos contenidos en S
        nminus1 = []
        if k >= 2:
            nminus1 = [rid for rid in ref_ids if len(id2combo.get(rid, frozenset()))==(k-1) and id2combo[rid].issubset(S)]

        candidates = singles + nminus1
        if not candidates:
            continue

        # clusters que contienen este MR
        mr_clusters = set()
        for p in mr_prots.get(mr, []):
            rep = prot2cluster.get(p)
            if rep:
                mr_clusters.add(rep)

        for rid in candidates:
            genes = ref_prots.get(rid, set())
            if not genes:
                continue
            n_total = len(genes)
            n_present = sum(1 for g in genes if prot2cluster.get(g) in mr_clusters)
            frac = n_present / n_total if n_total else 0.0
            fully = "YES" if frac >= PRESENCE_THRESH else "NO"
            w.writerow([
                mr, "|".join(sorted(S)), k,
                rid, "|".join(sorted(id2combo.get(rid, frozenset()))),
                len(id2combo.get(rid, frozenset())),
                n_total, n_present, f"{frac:.3f}", PRESENCE_THRESH, fully
            ])

# resumen por MR
from collections import defaultdict
by_mr = defaultdict(list)
with out_path.open() as f:
    r = csv.DictReader(f, delimiter="\t")
    for d in r:
        by_mr[d["MR_id"]].append(d)

with (WORK / "mr_summary.tsv").open("w") as f:
    w2 = csv.writer(f, delimiter="\t", lineterminator="\n")
    w2.writerow(["MR_id","MR_combo","k","n_candidates",
                 "n_full_hits","n_full_singles","n_full_nminus1",
                 "best_hit_id","best_hit_frac"])
    for mr, lst in by_mr.items():
        if not lst:
            continue
        S = lst[0]["MR_combo"]
        k = lst[0]["k"]
        nC = len(lst)
        full = [d for d in lst if d["fully_present_>=threshold"]=="YES"]
        nF  = len(full)
        nFs = sum(1 for d in full if int(d["ref_size"])==1)
        nFn = sum(1 for d in full if int(d["ref_size"])==int(k)-1)
        best = max(lst, key=lambda d: float(d["fraction_present"]))
        w2.writerow([mr,S,k,nC,nF,nFs,nFn,best["REF_id"],best["fraction_present"]])

print("Wrote:")
print(" -", out_path)
print(" -", WORK / "mr_summary.tsv")

