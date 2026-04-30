#!/bin/bash

input_file="multi_replicon_fasta_paths.txt"
output_dir_base="mobtyper"

# Para cada archivo en la lista
cat "$input_file" | while read -r filepath; do
    base=$(basename "$filepath" .fasta)
    output_folder="${output_dir_base}/${base}_analysis"
    summary_file="${output_dir_base}/${base}_summary.txt"

    # Si la carpeta de output existe, la saltamos
    if [ -d "$output_folder" ]; then
        echo "Skip $base, output folder exists."
        continue
    fi

    # Ejecutar mob_typer para ese archivo
    echo "Processing $base"

    # Lanzamos en background y limitamos a 30 jobs paralelos
    (
      mob_typer -i "$filepath" -o "$summary_file" -a "$output_folder" --keep_tmp
    ) &

    # Control simple para no exceder 30 jobs al mismo tiempo
    while [ $(jobs -r | wc -l) -ge 30 ]; do
        sleep 1
    done
done

# Esperamos a que terminen todos los jobs en background
wait
echo "All jobs completed."

