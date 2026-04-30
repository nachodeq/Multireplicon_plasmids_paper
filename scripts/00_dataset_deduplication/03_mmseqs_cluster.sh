#!/usr/bin/env bash
set -euo pipefail

BASE="/home/nacho/HDD16/Nacho/RepliCOOC"
WORK="$BASE/results/mr_vs_familyspace"
TMP="$WORK/tmp"
mkdir -p "$TMP"

ALL="$WORK/all_proteins.faa"
DB="$WORK/db"
CLU="$WORK/clu"

THREADS=30
MIN_SEQ_ID="0.70"   # identidad mínima
COV="0.8"           # cobertura mínima
COV_MODE="0"        # cobertura respecto al más corto
SENS="7.5"          # sensibilidad alta
CLUMODE="2"         # set-cover

mmseqs createdb "$ALL" "$DB" >/dev/null
mmseqs cluster "$DB" "$CLU" "$TMP" \
  --threads "$THREADS" \
  --min-seq-id "$MIN_SEQ_ID" -c "$COV" --cov-mode "$COV_MODE" \
  -s "$SENS" --cluster-mode "$CLUMODE"

mmseqs createtsv "$DB" "$DB" "$CLU" "$WORK/clusters.tsv" >/dev/null

echo "Wrote: $WORK/clusters.tsv"

