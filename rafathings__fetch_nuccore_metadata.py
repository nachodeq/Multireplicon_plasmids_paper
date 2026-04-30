#!/usr/bin/env python3
"""
Fetch isolation source and assembly metadata from NCBI nuccore for a list of accessions.

OUTPUT COLUMNS:
  accession, organism, strain, isolation_source, geo_loc_name, collection_date,
  plasmid, genome_representation, expected_final_version, genome_coverage, sequencing_technology, error

USAGE:
  python fetch_nuccore_metadata.py --input accessions.txt --output nuccore_metadata.csv --email you@domain
  # accessions.txt: one accession per line (e.g., CP137431.1)

Notes:
- Requires Biopython (pip install biopython).
- Be considerate of NCBI usage guidelines (set your email, optionally use an API key).
"""

import argparse
import csv
import os
import re
import sys
import time
from typing import Dict, Iterable, List

from Bio import Entrez, SeqIO
from Bio.SeqFeature import SeqFeature


# --------------------------- Parsing helpers ---------------------------

SCHEMA = [
    "accession",
    "organism",
    "strain",
    "isolation_source",
    "geo_loc_name",
    "collection_date",
    "plasmid",
    "genome_representation",
    "expected_final_version",
    "genome_coverage",
    "sequencing_technology",
    "error",
]


def _extract_source_qualifiers(features: List[SeqFeature]) -> Dict[str, str]:
    out = {
        "organism": "",
        "strain": "",
        "isolation_source": "",
        "geo_loc_name": "",
        "collection_date": "",
        "plasmid": "",
    }
    for feat in features:
        if feat.type == "source":
            q = feat.qualifiers
            out["organism"] = (q.get("organism", [""]) or [""])[0]
            out["strain"] = (q.get("strain", [""]) or [""])[0]
            out["isolation_source"] = (q.get("isolation_source", [""]) or [""])[0]
            out["geo_loc_name"] = (q.get("geo_loc_name", [""]) or [""])[0]
            out["collection_date"] = (q.get("collection_date", [""]) or [""])[0]
            out["plasmid"] = (q.get("plasmid", [""]) or [""])[0]
            break
    return out


def _extract_assembly_from_structured_comment(record) -> Dict[str, str]:
    """
    Try Biopython's structured_comment first, then fall back to scanning record.annotations['comment'].
    """
    fields = {
        "genome_representation": "",
        "expected_final_version": "",
        "genome_coverage": "",
        "sequencing_technology": "",
    }

    # 1) Structured comment dict (preferred)
    sc = record.annotations.get("structured_comment")
    if isinstance(sc, dict):
        gad = sc.get("Genome-Assembly-Data")
        if isinstance(gad, dict):
            fields["genome_representation"] = gad.get("Genome Representation", "") or ""
            fields["expected_final_version"] = gad.get("Expected Final Version", "") or ""
            fields["genome_coverage"] = gad.get("Genome Coverage", "") or ""
            fields["sequencing_technology"] = gad.get("Sequencing Technology", "") or ""
            return fields

    # 2) Fallback: parse plain comment text
    comment = record.annotations.get("comment", "") or ""
    # Robust regexes, tolerate variable spacing and colons
    def grab(label: str) -> str:
        m = re.search(
            rf"{re.escape(label)}\s*[:]\s*(.+)",
            comment,
            flags=re.IGNORECASE,
        )
        if m:
            # stop at end of line
            return m.group(1).splitlines()[0].strip()
        return ""

    fields["genome_representation"] = grab("Genome Representation")
    fields["expected_final_version"] = grab("Expected Final Version")
    fields["genome_coverage"] = grab("Genome Coverage")
    fields["sequencing_technology"] = grab("Sequencing Technology")
    return fields


def parse_record(record) -> Dict[str, str]:
    row = {k: "" for k in SCHEMA}
    row["accession"] = getattr(record, "id", "") or record.annotations.get("accessions", [""])[0]

    # Source qualifiers
    row.update(_extract_source_qualifiers(record.features))

    # Assembly structured comment
    row.update(_extract_assembly_from_structured_comment(record))

    # Normalize coverage to a compact form (e.g., "245.0x" or "245x")
    cov = row.get("genome_coverage", "")
    if cov:
        # keep original but trim whitespace
        row["genome_coverage"] = cov.strip()

    # Clean whitespace everywhere
    for k, v in list(row.items()):
        if isinstance(v, str):
            row[k] = v.strip()

    return row


# --------------------------- I/O and Entrez ---------------------------

def chunked(iterable: Iterable[str], n: int) -> Iterable[List[str]]:
    chunk: List[str] = []
    for x in iterable:
        chunk.append(x)
        if len(chunk) >= n:
            yield chunk
            chunk = []
    if chunk:
        yield chunk


def read_accessions(path: str) -> List[str]:
    accs: List[str] = []
    with open(path, "r", encoding="utf-8") as fh:
        for line in fh:
            s = line.strip()
            if not s or s.startswith("#"):
                continue
            # allow comma or whitespace separated lists per line
            parts = re.split(r"[,\s]+", s)
            accs.extend([p for p in parts if p])
    # de-duplicate, preserve order
    seen = set()
    uniq = []
    for a in accs:
        if a not in seen:
            uniq.append(a)
            seen.add(a)
    return uniq


def fetch_batch(accessions: List[str], pause: float = 0.34):
    """
    Fetch a batch of GenBank records by accession(s).
    pause: sleep after each request to respect NCBI guidelines (~3 req/s without API key).
    """
    ids = ",".join(accessions)
    with Entrez.efetch(db="nuccore", id=ids, rettype="gb", retmode="text") as handle:
        for rec in SeqIO.parse(handle, "genbank"):
            yield rec
    time.sleep(pause)


def main():
    ap = argparse.ArgumentParser(description="Fetch nuccore metadata for accessions.")
    ap.add_argument("--input", "-i", required=True, help="Text file with accessions (one per line).")
    ap.add_argument("--output", "-o", default="nuccore_metadata.csv", help="Output CSV path.")
    ap.add_argument("--email", required=True, help="Contact email for NCBI Entrez.")
    ap.add_argument("--api-key", default=os.getenv("NCBI_API_KEY", ""), help="NCBI API key (optional).")
    ap.add_argument("--batch-size", type=int, default=50, help="Batch size for efetch (default 50).")
    ap.add_argument("--pause", type=float, default=0.34, help="Pause between requests in seconds.")
    args = ap.parse_args()

    Entrez.email = args.email
    if args.api_key:
        Entrez.api_key = args.api_key

    accessions = read_accessions(args.input)
    if not accessions:
        print("No accessions found in input.", file=sys.stderr)
        sys.exit(1)

    # Write CSV
    with open(args.output, "w", newline="", encoding="utf-8") as outfh:
        w = csv.DictWriter(outfh, fieldnames=SCHEMA)
        w.writeheader()

        total = len(accessions)
        processed = 0

        # map for pairing parsed records back to requested IDs (in case of order differences)
        for batch in chunked(accessions, args.batch_size):
            # initialize empties so missing records still produce rows
            rows_by_acc = {acc: {k: "" for k in SCHEMA} for acc in batch}
            for acc in batch:
                rows_by_acc[acc]["accession"] = acc

            try:
                for rec in fetch_batch(batch, pause=args.pause):
                    row = parse_record(rec)
                    key = row.get("accession") or rec.annotations.get("accessions", [""])[0]
                    if key in rows_by_acc:
                        rows_by_acc[key].update(row)
                    else:
                        # sometimes record.id can include version or GI; try to match by primary accession
                        prim = (rec.annotations.get("accessions", [""]) or [""])[0]
                        if prim:
                            rows_by_acc.setdefault(prim, {k: "" for k in SCHEMA})
                            rows_by_acc[prim].update(row)

            except Exception as e:
                # on a batch-level failure, record error for all in batch
                for acc in batch:
                    rows_by_acc[acc]["error"] = f"batch_error: {type(e).__name__}: {e}"

            # write rows in the same order as requested
            for acc in batch:
                # ensure error message if absolutely nothing came back
                if all((rows_by_acc[acc].get(k, "") == "" for k in SCHEMA if k not in ("accession", "error"))):
                    rows_by_acc[acc].setdefault("error", "")
                    if not rows_by_acc[acc]["error"]:
                        rows_by_acc[acc]["error"] = "no_record_or_no_fields_found"
                w.writerow(rows_by_acc[acc])
                processed += 1

                # simple progress to stderr
                if processed % 20 == 0 or processed == total:
                    print(f"[{processed}/{total}] done", file=sys.stderr)

    print(f"✅ Wrote: {args.output}")


if __name__ == "__main__":
    main()

