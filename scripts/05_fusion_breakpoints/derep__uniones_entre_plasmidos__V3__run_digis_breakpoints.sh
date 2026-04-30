#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# PATHS
# ============================================================

BASE="/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"
DIGIS_SCRIPT="/home/nacho/digIS/digIS_search.py"
PYTHON_BIN="$(which python3)"

HWS=(500 1000 1500 2000 2500 3000)

echo "Running digIS on breakpoint windows..."

for HW in "${HWS[@]}"; do

    TRACE_DIR="$BASE/TRACEABLE_hardcut_95pid_${HW}_onebest_per_pair"
    INPUT_FASTA="$TRACE_DIR/breakpoints_windows.fa"
    OUTDIR="$TRACE_DIR/digis_output"

    echo "============================================================"
    echo "HW = $HW"
    echo "INPUT = $INPUT_FASTA"
    echo "OUTDIR = $OUTDIR"
    echo "============================================================"

    if [[ ! -f "$INPUT_FASTA" ]]; then
        echo "[WARN] missing FASTA: $INPUT_FASTA"
        continue
    fi

    # limpiar output previo
    rm -rf "$OUTDIR"

    # ejecutar digIS
    "$PYTHON_BIN" "$DIGIS_SCRIPT" \
        -i "$INPUT_FASTA" \
        -o "$OUTDIR"

    echo "[OK] finished HW=$HW"

done

echo "DONE"
