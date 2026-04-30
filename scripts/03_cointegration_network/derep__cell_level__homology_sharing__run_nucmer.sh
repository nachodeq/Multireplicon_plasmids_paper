#!/bin/bash
set -u -o pipefail
# NOTA: quitamos -e para que no aborte en errores individuales

BASE=/home/nacho/HDD16/Nacho/RepliCOOC/derep/cell_level/homology_sharing
FASTAS=$BASE/plasmids/fastas
JOBS=12   # ajusta a tus cores

LOGDIR=$BASE/logs
mkdir -p "$LOGDIR"

for PAIR in $BASE/work/*__*; do
  PAIRNAME=$(basename "$PAIR")
  echo "Processing $PAIRNAME"

  # Skip if lists missing or empty
  [[ ! -s $PAIR/A_only.list ]] && { echo "  -> skip (no A_only)"; continue; }
  [[ ! -s $PAIR/B_only.list ]] && { echo "  -> skip (no B_only)"; continue; }

  mkdir -p $PAIR/fastas/A $PAIR/fastas/B
  mkdir -p $PAIR/nucmer $PAIR/coords

  # --------------------------------------------------
  # Copy FASTAs (idempotente)
  # --------------------------------------------------
  while read -r A; do
    [[ -f $FASTAS/${A}.fna ]] || continue
    cp -n $FASTAS/${A}.fna $PAIR/fastas/A/
  done < $PAIR/A_only.list

  while read -r B; do
    [[ -f $FASTAS/${B}.fna ]] || continue
    cp -n $FASTAS/${B}.fna $PAIR/fastas/B/
  done < $PAIR/B_only.list

  # --------------------------------------------------
  # Build job list
  # --------------------------------------------------
  JOBFILE=$PAIR/jobs.txt
  : > "$JOBFILE"

  for A in $PAIR/fastas/A/*.fna; do
    [[ -e "$A" ]] || continue
    Aname=$(basename "$A" .fna)

    for B in $PAIR/fastas/B/*.fna; do
      [[ -e "$B" ]] || continue
      Bname=$(basename "$B" .fna)

      PREFIX=$PAIR/nucmer/${Aname}__${Bname}
      COORDS=$PAIR/coords/${Aname}__${Bname}.coords

      # Skip if already done
      [[ -f ${PREFIX}.delta && -s $COORDS ]] && continue

      echo "$A $B $PREFIX $COORDS" >> "$JOBFILE"
    done
  done

  [[ ! -s $JOBFILE ]] && { echo "  -> no jobs to run"; continue; }

  # --------------------------------------------------
  # Run NUCmer jobs in parallel (FAIL-SAFE)
  # --------------------------------------------------
  parallel \
    -j $JOBS \
    --colsep ' ' \
    --joblog "$LOGDIR/${PAIRNAME}.parallel.log" \
    --results "$LOGDIR/${PAIRNAME}.parallel.results" \
    --halt never \
    '
    A={1}
    B={2}
    PREFIX={3}
    COORDS={4}

    nucmer --maxmatch -c 100 -l 50 "$A" "$B" -p "$PREFIX" \
      > "${PREFIX}.stdout" 2> "${PREFIX}.stderr"

    if [[ $? -eq 0 && -f ${PREFIX}.delta ]]; then
      show-coords -rcl "${PREFIX}.delta" > "$COORDS" \
        2>> "${PREFIX}.stderr"
    else
      echo "NUCmer failed for $A vs $B" >> "${PREFIX}.stderr"
    fi
    ' :::: "$JOBFILE"

done

echo "All jobs submitted."

