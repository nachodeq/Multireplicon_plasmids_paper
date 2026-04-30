#!/usr/bin/env bash
set -euo pipefail

BASE="/home/nacho/HDD16/Nacho/RepliCOOC"
WORK="$BASE/results/mr_vs_familyspace"
META="$WORK/meta_min.tsv"
REFL="$WORK/ref.list"
MRL="$WORK/mr.list"

ALL="$WORK/all_proteins.faa"
: > "$ALL"

# Carga metadatos en arrays asociativos
declare -A COMBO ISMULTI
while IFS=$'\t' read -r pid combo ismulti; do
  [[ "$pid" == "plasmid_id" ]] && continue
  COMBO["$pid"]="$combo"
  ISMULTI["$pid"]="$ismulti"
done < "$META"

add_faa() {
  local faa="$1" kind="$2"
  local pid; pid=$(basename "$faa" .faa)
  local combo="${COMBO[$pid]:-NA}"
  awk -v PFX="${kind}|${pid}|${combo}|" '
    BEGIN{FS=" "; OFS=" "}
    /^>/{
      sub(/^>/,"",$0);
      split($1,a," ");
      print ">" PFX a[1];
      next
    }
    {print}
  ' "$faa" >> "$ALL"
}

# Añade referencias (REF)
while read -r faa; do
  [[ -z "${faa:-}" ]] && continue
  add_faa "$faa" "REF"
done < "$REFL"

# Añade multis (MR)
while read -r faa; do
  [[ -z "${faa:-}" ]] && continue
  add_faa "$faa" "MR"
done < "$MRL"

echo "Wrote: $ALL"

