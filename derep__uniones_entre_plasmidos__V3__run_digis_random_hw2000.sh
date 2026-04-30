#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# PATHS
# ============================================================

BASE="/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"
HW=2000

DIGIS_SCRIPT="/home/nacho/digIS/digIS_search.py"
PYTHON_BIN="$(which python3)"

TRACE_DIR="$BASE/TRACEABLE_hardcut_95pid_${HW}_onebest_per_pair"
CONTROL_DIR="$TRACE_DIR/random_control_two_random_points_hw2000"

INPUT_FASTA="$CONTROL_DIR/random_windows.fa"
OUTDIR="$CONTROL_DIR/digis_output"

echo "============================================================"
echo "Running digIS on random windows"
echo "HW = $HW"
echo "INPUT = $INPUT_FASTA"
echo "OUTDIR = $OUTDIR"
echo "============================================================"

if [[ ! -f "$INPUT_FASTA" ]]; then
    echo "[ERROR] missing FASTA: $INPUT_FASTA"
    exit 1
fi

rm -rf "$OUTDIR"

"$PYTHON_BIN" "$DIGIS_SCRIPT" \
    -i "$INPUT_FASTA" \
    -o "$OUTDIR"

echo "[OK] finished random digIS HW=$HW"
echo "DONE"
