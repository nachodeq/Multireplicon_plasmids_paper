#!/usr/bin/env python3
# make_background_windows.py
import random, os, sys
WORKDIR="."
FG="foreground_windows.tsv"
OUT="background_windows.tsv"
FA_DIR="fasta"   # los fasta enlazados
WINDOW=1000

# read foreground and count per chrom
counts={}
fgrows=[]
with open(FG) as f:
    for line in f:
        parts=line.strip().split("\t")
        if len(parts)<4: continue
        name, chrom, s, e = parts[0], parts[1], int(parts[2]), int(parts[3])
        counts[chrom] = counts.get(chrom,0)+1
        fgrows.append((name,chrom,s,e))

# for each chrom, get sequence length from fasta index (.fai)
out=[]
for chrom,k in counts.items():
    # find fasta file containing chrom as basename
    found=None
    for suf in (".fna",".fa",".fasta"):
        p=os.path.join(FA_DIR,chrom+suf)
        if os.path.exists(p):
            found=p; break
    if not found:
        print("WARNING: no fasta for",chrom,"skip")
        continue
    # read length from .fai
    fai=found+".fai"
    if not os.path.exists(fai):
        raise SystemExit("Fai not found for "+found)
    L=None
    with open(fai) as fh:
        for line in fh:
            parts=line.strip().split("\t")
            if parts[0]==chrom:
                L=int(parts[1]); break
    if not L:
        # fallback: take first record
        with open(fai) as fh:
            parts=fh.readline().split("\t")
            L=int(parts[1])
    # sample k positions ensuring non-overlap (simple retry)
    tries=0; sampled=[]
    while len(sampled) < k and tries < k*100:
        pos = random.randint(1, L)  # 1-based center
        # compute window 1-based inclusive: center-W/2 .. center+W/2-1 (here we use left/right windows we want equal size)
        half = WINDOW//2
        s = pos - half
        e = pos + half - 1 if WINDOW%2==0 else pos + half
        # normalize circularly: represent as (s,e) with 1..L, allow wrap later
        # check overlap with existing sampled (consider circular distance)
        ok=True
        for (ss,ee) in sampled:
            # naive overlap check on linearized coordinates (expand wrap if needed)
            def intervals(a,b):
                if a<=b: return [(a,b)]
                else: return [(a,L),(1,b)]
            ints1=intervals(s,e); ints2=intervals(ss,ee)
            for A,B in ints1:
                for C,D in ints2:
                    if not (B < C or D < A):
                        ok=False; break
                if not ok: break
            if not ok: break
        if ok:
            sampled.append((s,e))
        tries+=1
    if len(sampled)<k:
        print("WARNING: could only sample",len(sampled),"of",k,"for",chrom)
    for s,e in sampled:
        out.append((chrom,s,e))
# write out
with open(OUT,"w") as o:
    o.write("chrom\tstart1\tend1\n")
    for chrom,s,e in out:
        o.write(f"{chrom}\t{max(1,s)}\t{e}\n")
print("Wrote",OUT)

