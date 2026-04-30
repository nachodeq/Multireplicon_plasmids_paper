#!/bin/bash
set -u -o pipefail
# no -e: no abortar si algún delta falla

BASE=/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing
JOBS=12

echo "Running delta-filter -i 99 on existing deltas"

for PAIR in $BASE/work/*__*; do
  PAIRNAME=$(basename "$PAIR")
  DELTADIR="$PAIR/nucmer"

  [[ ! -d "$DELTADIR" ]] && continue

  OUT_DELTA="$PAIR/delta99/delta"
  OUT_COORDS="$PAIR/delta99/coords"

  mkdir -p "$OUT_DELTA" "$OUT_COORDS"

  echo "Processing $PAIRNAME"

  for d in "$DELTADIR"/*.delta; do
    [[ -e "$d" ]] || continue

    base=$(basename "$d" .delta)

    out_delta="$OUT_DELTA/${base}.99.delta"
    out_coords="$OUT_COORDS/${base}.99.coords"

    # Skip if already done
    [[ -s "$out_coords" ]] && continue

    delta-filter -i 99 "$d" > "$out_delta" 2>/dev/null

    # Si el delta filtrado está vacío, seguimos
    if [[ ! -s "$out_delta" ]]; then
      continue
    fi

    show-coords -rcl "$out_delta" > "$out_coords" 2>/dev/null || true
  done
done

echo "Finished delta-filter 99 pass"

