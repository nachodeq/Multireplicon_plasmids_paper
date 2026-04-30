#!/usr/bin/env bash
set -euo pipefail

WORKDIR="/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos"
cd "$WORKDIR"

mkdir -p windows_seqs
> breakpoints_sequences.fa

while IFS=$'\t' read -r chrom s1 e1 name wrap p2s p2e; do
  [[ "$chrom" =~ ^# ]] && continue
  FASTA=""; for suf in .fna .fa .fasta; do if [ -f "fasta/${chrom}${suf}" ]; then FASTA="fasta/${chrom}${suf}"; break; fi; done
  if [ -z "$FASTA" ]; then echo "WARNING: no fasta for $chrom" >&2; continue; fi
  if [ "$wrap" -eq 0 ]; then
    samtools faidx "$FASTA" "${chrom}:${s1}-${e1}" > "windows_seqs/${name}.fa"
  else
    samtools faidx "$FASTA" "${chrom}:${s1}-${e1}" > "windows_seqs/${name}.part1.fa"
    samtools faidx "$FASTA" "${chrom}:${p2s}-${p2e}" > "windows_seqs/${name}.part2.fa"
    (echo ">${name}"; tail -n +2 "windows_seqs/${name}.part1.fa"; tail -n +2 "windows_seqs/${name}.part2.fa") > "windows_seqs/${name}.fa"
    rm -f "windows_seqs/${name}.part1.fa" "windows_seqs/${name}.part2.fa"
  fi
  # append to multi-fasta
  cat "windows_seqs/${name}.fa" >> breakpoints_sequences.fa
done < breakpoints_windows_to_fetch.tsv
