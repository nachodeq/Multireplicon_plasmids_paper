#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/control_mantel"
CONTROL_FASTAS="${BASE_DIR}/control_fastas"

cd "$CONTROL_FASTAS"

for pairdir in */; do
    [[ ! -d "$pairdir" ]] && continue
    pairdir="${pairdir%/}"
    echo "Processing pair: $pairdir"

    # sacar replicones presentes en ese directorio
    reps=$(find "$pairdir" -maxdepth 1 -type f -name "*.fa" \
        | sed 's#.*/##' \
        | sed 's/\.fa$//' \
        | awk -F'__' '{print $NF}' \
        | sort -u)

    for rep in $reps; do
        all_fa="${pairdir}/${rep}_all.fa"
        aligned_fa="${pairdir}/${rep}_all_aligned.fasta"

        cat "${pairdir}"/*"__${rep}.fa" > "$all_fa"

        nseq=$(grep -c '^>' "$all_fa" || true)
        if [[ "$nseq" -lt 4 ]]; then
            echo "  Skip $rep in $pairdir (only $nseq sequences)"
            rm -f "$all_fa"
            continue
        fi

        if command -v muscle >/dev/null 2>&1; then
            echo "  Aligning $rep with muscle ($nseq seqs)"
            muscle -align "$all_fa" -output "$aligned_fa"
        else
            echo "  Aligning $rep with mafft ($nseq seqs)"
            mafft --auto --thread 8 "$all_fa" > "$aligned_fa"
        fi
    done
done

echo "All alignments completed."
