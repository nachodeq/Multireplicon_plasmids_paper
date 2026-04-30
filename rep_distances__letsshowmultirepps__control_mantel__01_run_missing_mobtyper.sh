#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE="missing_mobtyper_fasta_paths.txt"
OUTPUT_DIR_BASE="/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/mobtyper"
MAX_JOBS=30

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Input file not found: $INPUT_FILE"
    exit 1
fi

mkdir -p "$OUTPUT_DIR_BASE"

while read -r filepath; do
    [[ -z "$filepath" ]] && continue
    [[ ! -f "$filepath" ]] && { echo "Missing FASTA: $filepath"; continue; }

    base=$(basename "$filepath")
    base="${base%.fasta}"
    base="${base%.fa}"
    base="${base%.fna}"

    output_folder="${OUTPUT_DIR_BASE}/${base}_analysis"
    summary_file="${OUTPUT_DIR_BASE}/${base}_summary.txt"
    blast_file="${output_folder}/replicon_blast_results.txt"

    if [[ -d "$output_folder" && -f "$blast_file" && -f "$summary_file" ]]; then
        echo "Skip $base, MOB-typer output already complete."
        continue
    fi

    echo "Processing $base"

    (
        mob_typer \
            -i "$filepath" \
            -o "$summary_file" \
            -a "$output_folder" \
            --keep_tmp
    ) &

    while [[ $(jobs -r | wc -l) -ge $MAX_JOBS ]]; do
        sleep 1
    done
done < "$INPUT_FILE"

wait
echo "All jobs completed."
