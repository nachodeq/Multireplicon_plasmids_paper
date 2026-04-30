#!/usr/bin/env bash
set -euo pipefail
echo "[i] minimap2 preset: asm5"

echo "[i] Running L1 vs >L …"
minimap2 -x asm5 -t 30 --secondary=no -c "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level_gt1_targets.fasta" "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level1_queries.fasta" > "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level1_vs_gt1.paf"
echo "[✓] Done L1 vs >L -> /home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level1_vs_gt1.paf"

echo "[i] Running L2 vs >L …"
minimap2 -x asm5 -t 30 --secondary=no -c "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level_gt2_targets.fasta" "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level2_queries.fasta" > "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level2_vs_gt2.paf"
echo "[✓] Done L2 vs >L -> /home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level2_vs_gt2.paf"

echo "[i] Running L3 vs >L …"
minimap2 -x asm5 -t 30 --secondary=no -c "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level_gt3_targets.fasta" "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level3_queries.fasta" > "/home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level3_vs_gt3.paf"
echo "[✓] Done L3 vs >L -> /home/nacho/HDD16/Nacho/RepliCOOC/derep/containment_mm2/level3_vs_gt3.paf"
