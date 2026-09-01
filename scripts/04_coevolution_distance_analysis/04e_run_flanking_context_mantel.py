#!/usr/bin/env python3
"""
Flanking-context Mantel analysis around co-occurring replicon pairs.

This script uses the already generated per-pair replicon FASTA files from the
original Mantel analysis. Those FASTA headers contain MOB-typer BLAST
coordinates for each replicon hit. For each pair and flank size, it extracts the
left and right genomic context around each replicon, removes the replicon
sequence itself, builds k-mer Jaccard distance matrices, and runs Mantel tests.
"""

from __future__ import annotations

import argparse
import hashlib
import math
import random
import re
from dataclasses import dataclass
from pathlib import Path

import numpy as np
import pandas as pd


DNA_COMP = str.maketrans("ACGTNacgtn", "TGCANtgcan")
HEADER_RE = re.compile(
    r"^>(?P<plasmid>[^|]+)\|(?P<rep>[^|]+)\|.*\|sstart:(?P<sstart>\d+)\|send:(?P<send>\d+)\|sstrand:(?P<strand>plus|minus)"
)


@dataclass
class RepHit:
    plasmid: str
    rep: str
    sstart: int
    send: int
    strand: str
    rep_seq: str


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser()
    p.add_argument(
        "--mantel-results",
        required=True,
    )
    p.add_argument(
        "--trees-dir",
        required=True,
    )
    p.add_argument(
        "--fasta-dir",
        required=True,
    )
    p.add_argument("--outdir", default="mantel_surrounding_replicons")
    p.add_argument("--flanks", default="500,1000,2000,4000,8000")
    p.add_argument("--kmer", type=int, default=15)
    p.add_argument("--min-n", type=int, default=5)
    p.add_argument("--max-n", type=int, default=200)
    p.add_argument("--permutations", type=int, default=199)
    p.add_argument(
        "--context-only-permutations",
        action="store_true",
        help="Use permutations only for contextA-vs-contextB Mantel; compute other Mantel r values descriptively.",
    )
    p.add_argument("--seed", type=int, default=20260702)
    p.add_argument("--write-context-fastas", action="store_true")
    return p.parse_args()


def read_fasta_one(path: Path) -> tuple[str, str]:
    header = ""
    chunks: list[str] = []
    with path.open() as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            if line.startswith(">"):
                if not header:
                    header = line
                continue
            chunks.append(line.upper())
    return header, "".join(chunks)


def read_plasmid_seq(plasmid: str, fasta_dir: Path, cache: dict[str, str]) -> str | None:
    if plasmid in cache:
        return cache[plasmid]
    for suffix in (".fasta", ".fa", ".fna"):
        p = fasta_dir / f"{plasmid}{suffix}"
        if p.exists():
            _, seq = read_fasta_one(p)
            cache[plasmid] = seq.upper()
            return cache[plasmid]
    cache[plasmid] = ""
    return None


def parse_rep_fasta(path: Path) -> RepHit | None:
    header, seq = read_fasta_one(path)
    m = HEADER_RE.match(header)
    if not m:
        return None
    return RepHit(
        plasmid=m.group("plasmid"),
        rep=m.group("rep"),
        sstart=int(m.group("sstart")),
        send=int(m.group("send")),
        strand=m.group("strand"),
        rep_seq=seq.upper(),
    )


def circular_slice(seq: str, start0: int, length: int) -> str:
    n = len(seq)
    if n == 0 or length <= 0:
        return ""
    start0 %= n
    if start0 + length <= n:
        return seq[start0 : start0 + length]
    first = seq[start0:]
    remaining = length - len(first)
    repeats, tail = divmod(remaining, n)
    return first + (seq * repeats) + seq[:tail]


def revcomp(seq: str) -> str:
    return seq.translate(DNA_COMP)[::-1].upper()


def extract_context(seq: str, hit: RepHit, flank: int) -> tuple[str, str]:
    """Return oriented context sequence and skip reason."""
    n = len(seq)
    if n == 0:
        return "", "missing_plasmid_fasta"
    start = min(hit.sstart, hit.send)
    end = max(hit.sstart, hit.send)
    rep_len = end - start + 1
    if start < 1 or end > n or rep_len <= 0:
        return "", "invalid_coordinates"
    if n < rep_len + (2 * flank):
        return "", "plasmid_too_short_for_nonoverlapping_context"

    left = circular_slice(seq, (start - 1) - flank, flank)
    right = circular_slice(seq, end, flank)
    if hit.strand == "minus":
        return revcomp(right + left), ""
    return (left + right).upper(), ""


def kmers(seq: str, k: int) -> set[str]:
    seq = seq.upper()
    out: set[str] = set()
    for i in range(0, len(seq) - k + 1):
        kmer = seq[i : i + k]
        if "N" not in kmer:
            out.add(kmer)
    return out


def jaccard_distance(a: set[str], b: set[str]) -> float:
    if not a and not b:
        return np.nan
    union = len(a | b)
    if union == 0:
        return np.nan
    return 1.0 - (len(a & b) / union)


def distance_matrix(seqs: list[str], k: int) -> np.ndarray:
    features = [kmers(s, k) for s in seqs]
    n = len(features)
    mat = np.zeros((n, n), dtype=float)
    for i in range(n):
        for j in range(i + 1, n):
            d = jaccard_distance(features[i], features[j])
            mat[i, j] = mat[j, i] = d
    return mat


def upper_tri(mat: np.ndarray) -> np.ndarray:
    idx = np.triu_indices_from(mat, k=1)
    return mat[idx]


def pearson_r(x: np.ndarray, y: np.ndarray) -> float:
    ok = np.isfinite(x) & np.isfinite(y)
    x = x[ok]
    y = y[ok]
    if len(x) < 3:
        return np.nan
    if np.std(x) == 0 or np.std(y) == 0:
        return np.nan
    return float(np.corrcoef(x, y)[0, 1])


def mantel_test(a: np.ndarray, b: np.ndarray, permutations: int, rng: random.Random) -> tuple[float, float]:
    obs = pearson_r(upper_tri(a), upper_tri(b))
    if not np.isfinite(obs):
        return np.nan, np.nan
    if permutations <= 0:
        return obs, np.nan
    n = a.shape[0]
    more_extreme = 0
    for _ in range(permutations):
        order = list(range(n))
        rng.shuffle(order)
        bp = b[np.ix_(order, order)]
        r = pearson_r(upper_tri(a), upper_tri(bp))
        if np.isfinite(r) and abs(r) >= abs(obs):
            more_extreme += 1
    p = (more_extreme + 1) / (permutations + 1)
    return obs, p


def pair_seed(global_seed: int, pair: str) -> int:
    digest = hashlib.sha256(f"{global_seed}:{pair}".encode()).hexdigest()
    return int(digest[:12], 16)


def parse_pair_dir(pair_dir: Path) -> dict[tuple[str, str], RepHit]:
    hits = {}
    for path in pair_dir.glob("*.fa"):
        hit = parse_rep_fasta(path)
        if hit is None:
            continue
        hits[(hit.plasmid, hit.rep)] = hit
    return hits


def safe_pair_reps(pair: str) -> tuple[str, str]:
    a, b = pair.split("__", 1)
    return a, b


def maybe_write_context_fastas(outdir: Path, pair: str, flank: int, records: list[dict]) -> None:
    pdir = outdir / "context_fastas" / f"flank_{flank}"
    pdir.mkdir(parents=True, exist_ok=True)
    with (pdir / f"{pair}__contextA.fa").open("w") as fa, (pdir / f"{pair}__contextB.fa").open("w") as fb:
        for r in records:
            fa.write(f">{r['plasmid']}|{r['repA']}|flank:{flank}\n{r['contextA']}\n")
            fb.write(f">{r['plasmid']}|{r['repB']}|flank:{flank}\n{r['contextB']}\n")


def classify_original_r(r: float) -> str:
    if not np.isfinite(r):
        return "missing"
    if r >= 0.5:
        return "high_original_mantel"
    if r <= 0.2:
        return "low_original_mantel"
    return "intermediate_original_mantel"


def main() -> None:
    args = parse_args()
    outdir = Path(args.outdir)
    tables = outdir / "tables"
    logs = outdir / "logs"
    tables.mkdir(parents=True, exist_ok=True)
    logs.mkdir(parents=True, exist_ok=True)

    flanks = [int(x) for x in args.flanks.split(",") if x.strip()]
    mantel = pd.read_csv(args.mantel_results, sep="\t")
    trees_dir = Path(args.trees_dir)
    fasta_dir = Path(args.fasta_dir)
    plasmid_cache: dict[str, str] = {}

    results = []
    per_plasmid_rows = []
    skip_rows = []

    for pair_idx, (_, row) in enumerate(mantel.iterrows(), start=1):
        pair = str(row["pair"])
        print(f"[{pair_idx}/{len(mantel)}] {pair}", flush=True)
        rep_a, rep_b = safe_pair_reps(pair)
        pair_dir = trees_dir / pair
        if not pair_dir.is_dir():
            skip_rows.append({"pair": pair, "reason": "missing_pair_dir"})
            continue
        hits = parse_pair_dir(pair_dir)
        plasmids = sorted({p for p, r in hits if r == rep_a} & {p for p, r in hits if r == rep_b})
        if len(plasmids) < args.min_n:
            skip_rows.append({"pair": pair, "reason": "fewer_than_min_plasmids_with_both_hits", "n": len(plasmids)})
            continue

        was_subsampled = False
        if len(plasmids) > args.max_n:
            rng_sample = random.Random(pair_seed(args.seed, pair))
            plasmids = sorted(rng_sample.sample(plasmids, args.max_n))
            was_subsampled = True

        rep_a_seqs = []
        rep_b_seqs = []
        base_records = []
        for plasmid in plasmids:
            ha = hits[(plasmid, rep_a)]
            hb = hits[(plasmid, rep_b)]
            seq = read_plasmid_seq(plasmid, fasta_dir, plasmid_cache)
            if not seq:
                skip_rows.append({"pair": pair, "plasmid": plasmid, "reason": "missing_plasmid_fasta"})
                continue
            rep_a_seqs.append(ha.rep_seq)
            rep_b_seqs.append(hb.rep_seq)
            base_records.append({"plasmid": plasmid, "repA": rep_a, "repB": rep_b, "hitA": ha, "hitB": hb, "plasmid_seq": seq})

        if len(base_records) < args.min_n:
            skip_rows.append({"pair": pair, "reason": "fewer_than_min_records_after_fasta_lookup", "n": len(base_records)})
            continue

        # Recompute a k-mer analogue of the original replicon Mantel on the exact sampled records.
        rep_a_seqs = [r["hitA"].rep_seq for r in base_records]
        rep_b_seqs = [r["hitB"].rep_seq for r in base_records]
        rep_a_mat = distance_matrix(rep_a_seqs, args.kmer)
        rep_b_mat = distance_matrix(rep_b_seqs, args.kmer)
        rng_rep = random.Random(pair_seed(args.seed, pair + ":rep"))
        rep_perms = 0 if args.context_only_permutations else args.permutations
        rep_kmer_r, rep_kmer_p = mantel_test(rep_a_mat, rep_b_mat, rep_perms, rng_rep)

        for flank in flanks:
            records = []
            skip_reason_counts: dict[str, int] = {}
            for r in base_records:
                ca, reason_a = extract_context(r["plasmid_seq"], r["hitA"], flank)
                cb, reason_b = extract_context(r["plasmid_seq"], r["hitB"], flank)
                reason = reason_a or reason_b
                if reason:
                    skip_reason_counts[reason] = skip_reason_counts.get(reason, 0) + 1
                    continue
                records.append(
                    {
                        "pair": pair,
                        "plasmid": r["plasmid"],
                        "repA": rep_a,
                        "repB": rep_b,
                        "flank_bp_each_side": flank,
                        "contextA": ca,
                        "contextB": cb,
                        "hitA_start": min(r["hitA"].sstart, r["hitA"].send),
                        "hitA_end": max(r["hitA"].sstart, r["hitA"].send),
                        "hitB_start": min(r["hitB"].sstart, r["hitB"].send),
                        "hitB_end": max(r["hitB"].sstart, r["hitB"].send),
                        "plasmid_length": len(r["plasmid_seq"]),
                    }
                )

            n_used = len(records)
            if n_used < args.min_n:
                results.append(
                    {
                        "pair": pair,
                        "repA": rep_a,
                        "repB": rep_b,
                        "flank_bp_each_side": flank,
                        "context_total_bp": flank * 2,
                        "n_original_mantel": int(row["n_taxa"]),
                        "n_available_hits": len(base_records),
                        "n_used": n_used,
                        "was_subsampled": was_subsampled,
                        "status": "insufficient_nonoverlapping_context",
                        "skip_reasons": ";".join(f"{k}:{v}" for k, v in sorted(skip_reason_counts.items())),
                        "original_mantel_r": row["mantel_r"],
                        "original_mantel_p": row["mantel_p"],
                        "original_mantel_class": classify_original_r(float(row["mantel_r"])),
                        "replicon_kmer_mantel_r": rep_kmer_r,
                        "replicon_kmer_mantel_p": rep_kmer_p,
                    }
                )
                continue

            if args.write_context_fastas:
                maybe_write_context_fastas(outdir, pair, flank, records)

            context_a_mat = distance_matrix([r["contextA"] for r in records], args.kmer)
            context_b_mat = distance_matrix([r["contextB"] for r in records], args.kmer)

            # Match replicon matrices to records retained for this flank.
            keep_plasmids = [r["plasmid"] for r in records]
            idx = [i for i, r in enumerate(base_records) if r["plasmid"] in set(keep_plasmids)]
            rep_a_sub = rep_a_mat[np.ix_(idx, idx)]
            rep_b_sub = rep_b_mat[np.ix_(idx, idx)]

            rng = random.Random(pair_seed(args.seed, f"{pair}:{flank}"))
            context_r, context_p = mantel_test(context_a_mat, context_b_mat, args.permutations, rng)
            rng = random.Random(pair_seed(args.seed, f"{pair}:{flank}:a"))
            local_perms = 0 if args.context_only_permutations else args.permutations
            repa_context_r, repa_context_p = mantel_test(rep_a_sub, context_a_mat, local_perms, rng)
            rng = random.Random(pair_seed(args.seed, f"{pair}:{flank}:b"))
            repb_context_r, repb_context_p = mantel_test(rep_b_sub, context_b_mat, local_perms, rng)

            results.append(
                {
                    "pair": pair,
                    "repA": rep_a,
                    "repB": rep_b,
                    "flank_bp_each_side": flank,
                    "context_total_bp": flank * 2,
                    "n_original_mantel": int(row["n_taxa"]),
                    "n_available_hits": len(base_records),
                    "n_used": n_used,
                    "was_subsampled": was_subsampled,
                    "status": "ok",
                    "skip_reasons": ";".join(f"{k}:{v}" for k, v in sorted(skip_reason_counts.items())),
                    "original_mantel_r": row["mantel_r"],
                    "original_mantel_p": row["mantel_p"],
                    "original_mantel_class": classify_original_r(float(row["mantel_r"])),
                    "replicon_kmer_mantel_r": rep_kmer_r,
                    "replicon_kmer_mantel_p": rep_kmer_p,
                    "context_context_mantel_r": context_r,
                    "context_context_mantel_p": context_p,
                    "repA_contextA_mantel_r": repa_context_r,
                    "repA_contextA_mantel_p": repa_context_p,
                    "repB_contextB_mantel_r": repb_context_r,
                    "repB_contextB_mantel_p": repb_context_p,
                    "kmer": args.kmer,
                    "permutations": args.permutations,
                    "seed": args.seed,
                }
            )

            for r in records:
                rr = {k: v for k, v in r.items() if k not in {"contextA", "contextB"}}
                rr["contextA_len"] = len(r["contextA"])
                rr["contextB_len"] = len(r["contextB"])
                per_plasmid_rows.append(rr)

    res = pd.DataFrame(results)
    res.to_csv(tables / "context_mantel_by_pair_window.tsv", sep="\t", index=False)
    pd.DataFrame(per_plasmid_rows).to_csv(tables / "context_mantel_per_plasmid_records.tsv", sep="\t", index=False)
    pd.DataFrame(skip_rows).to_csv(tables / "context_mantel_skips.tsv", sep="\t", index=False)

    ok = res[res["status"].eq("ok")].copy()
    if not ok.empty:
        summary = (
            ok.groupby("flank_bp_each_side")
            .agg(
                n_pair_windows=("pair", "count"),
                n_pairs=("pair", "nunique"),
                median_n_used=("n_used", "median"),
                median_original_mantel_r=("original_mantel_r", "median"),
                median_context_context_mantel_r=("context_context_mantel_r", "median"),
                frac_context_positive=("context_context_mantel_r", lambda x: float((x > 0).mean())),
                frac_context_r_ge_0p3=("context_context_mantel_r", lambda x: float((x >= 0.3).mean())),
            )
            .reset_index()
        )
        summary.to_csv(tables / "context_mantel_summary_by_window.tsv", sep="\t", index=False)

        by_class = (
            ok.groupby(["flank_bp_each_side", "original_mantel_class"])
            .agg(
                n=("pair", "count"),
                median_original_mantel_r=("original_mantel_r", "median"),
                median_context_context_mantel_r=("context_context_mantel_r", "median"),
                median_repA_contextA_mantel_r=("repA_contextA_mantel_r", "median"),
                median_repB_contextB_mantel_r=("repB_contextB_mantel_r", "median"),
            )
            .reset_index()
        )
        by_class.to_csv(tables / "context_mantel_summary_by_window_and_original_class.tsv", sep="\t", index=False)

    with (outdir / "logs" / "run_context_mantel.log").open("w") as log:
        log.write(f"mantel_results={args.mantel_results}\n")
        log.write(f"trees_dir={args.trees_dir}\n")
        log.write(f"fasta_dir={args.fasta_dir}\n")
        log.write(f"flanks={flanks}\n")
        log.write(f"kmer={args.kmer}\n")
        log.write(f"min_n={args.min_n}\n")
        log.write(f"max_n={args.max_n}\n")
        log.write(f"permutations={args.permutations}\n")
        log.write(f"context_only_permutations={args.context_only_permutations}\n")
        log.write(f"seed={args.seed}\n")
        log.write(f"input_pairs={len(mantel)}\n")
        log.write(f"result_rows={len(res)}\n")
        log.write(f"ok_rows={int(res['status'].eq('ok').sum()) if not res.empty else 0}\n")
        log.write(f"unique_ok_pairs={ok['pair'].nunique() if not ok.empty else 0}\n")


if __name__ == "__main__":
    main()
