#!/usr/bin/env bash
set -euo pipefail

echo 'Concatenating rep_cluster_1733__rep_cluster_2214 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_1733_all.fa || true
echo 'Concatenating rep_cluster_1733__rep_cluster_2214 rep_cluster_2214'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/*rep_cluster_2214.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_2214_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2214 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_1733_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2214 rep_cluster_2214'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_2214_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1733__rep_cluster_2214';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_1733_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_2214_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
fi

echo 'Concatenating IncC__IncFIA IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncC_all.fa || true
echo 'Concatenating IncC__IncFIA IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncFIA_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncFIA IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncFIA IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncFIA_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncFIA';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIA/IncFIA_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1229__rep_cluster_1948 rep_cluster_1229'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/*rep_cluster_1229.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1229_all.fa || true
echo 'Concatenating rep_cluster_1229__rep_cluster_1948 rep_cluster_1948'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/*rep_cluster_1948.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1948_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1229__rep_cluster_1948 rep_cluster_1229'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1229_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1229_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1229__rep_cluster_1948 rep_cluster_1948'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1948_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1948_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1229__rep_cluster_1948';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1229_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1229_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1948_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1229__rep_cluster_1948/rep_cluster_1948_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__rep_cluster_1088 IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__rep_cluster_1088 IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncFII IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncFII IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_167__rep_cluster_1948 rep_cluster_167'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/*rep_cluster_167.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_167_all.fa || true
echo 'Concatenating rep_cluster_167__rep_cluster_1948 rep_cluster_1948'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/*rep_cluster_1948.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_1948_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_167__rep_cluster_1948 rep_cluster_167'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_167_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_167_all_aligned.fasta
  echo 'Running muscle for rep_cluster_167__rep_cluster_1948 rep_cluster_1948'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_1948_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_1948_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_167__rep_cluster_1948';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_167_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_167_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_1948_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_1948/rep_cluster_1948_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncHI1B IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncHI1B IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncHI1B_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncHI1B IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncHI1B IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncHI1B_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncHI1B';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI1B/IncHI1B_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncQ1 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncQ1 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncQ1 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncQ1 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncN IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncN IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncFII IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncFII IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncR IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncFII_all.fa || true
echo 'Concatenating IncFII__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncR IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_1418 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_1418 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2272 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2272 rep_cluster_2272'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/*rep_cluster_2272.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/rep_cluster_2272_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2272 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2272 rep_cluster_2272'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/rep_cluster_2272_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2272';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/rep_cluster_2272_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
fi

echo 'Concatenating IncR__rep_cluster_1418 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/IncR_all.fa || true
echo 'Concatenating IncR__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__rep_cluster_1418 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1418__rep_cluster_2272 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_1418_all.fa || true
echo 'Concatenating rep_cluster_1418__rep_cluster_2272 rep_cluster_2272'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/*rep_cluster_2272.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_2272_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1418__rep_cluster_2272 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_1418_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1418__rep_cluster_2272 rep_cluster_2272'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_2272_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1418__rep_cluster_2272';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_1418_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_2272_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2183 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2183 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncR__rep_cluster_2183 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/IncR_all.fa || true
echo 'Concatenating IncR__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__rep_cluster_2183 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1698__rep_cluster_1912 rep_cluster_1698'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/*rep_cluster_1698.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1698_all.fa || true
echo 'Concatenating rep_cluster_1698__rep_cluster_1912 rep_cluster_1912'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/*rep_cluster_1912.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1912_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1698__rep_cluster_1912 rep_cluster_1698'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1698_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1698_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1698__rep_cluster_1912 rep_cluster_1912'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1912_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1912_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1698__rep_cluster_1912';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1698_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1698_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1912_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1698__rep_cluster_1912/rep_cluster_1912_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_125__rep_cluster_1698 rep_cluster_125'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/*rep_cluster_125.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_125_all.fa || true
echo 'Concatenating rep_cluster_125__rep_cluster_1698 rep_cluster_1698'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/*rep_cluster_1698.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_1698_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_125__rep_cluster_1698 rep_cluster_125'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_125_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_125_all_aligned.fasta
  echo 'Running muscle for rep_cluster_125__rep_cluster_1698 rep_cluster_1698'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_1698_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_1698_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_125__rep_cluster_1698';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_125_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_125_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_1698_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1698/rep_cluster_1698_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1418 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1418 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncFIB IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncFIB IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIB_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncFIB IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncFIB IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIB_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncFIB';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIB/IncFIB_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2272 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2272 rep_cluster_2272'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/*rep_cluster_2272.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/rep_cluster_2272_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2272 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2272 rep_cluster_2272'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/rep_cluster_2272_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2272';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/rep_cluster_2272_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2272/rep_cluster_2272_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncFIC IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncFIC IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIC_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncFIC IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncFIC IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIC_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncFIC';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncFIC/IncFIC_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncFIC IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncFIC IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIC_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncFIC IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncFIC IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIC_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncFIC';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncFIC/IncFIC_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncFII IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncFII IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2244 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2244 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2244 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2244 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2244 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2244 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2350__rep_cluster_2358 rep_cluster_2350'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/*rep_cluster_2350.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2350_all.fa || true
echo 'Concatenating rep_cluster_2350__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2350__rep_cluster_2358 rep_cluster_2350'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2350_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2350_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2350__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2350__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2350_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2350_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2203 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2203 rep_cluster_2203'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/*rep_cluster_2203.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/rep_cluster_2203_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2203 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2203 rep_cluster_2203'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/rep_cluster_2203_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/rep_cluster_2203_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2203';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/rep_cluster_2203_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2203/rep_cluster_2203_all_aligned.fasta
fi

echo 'Concatenating Inc18__rep_cluster_185 Inc18'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/*Inc18.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/Inc18_all.fa || true
echo 'Concatenating Inc18__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Inc18__rep_cluster_185 Inc18'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/Inc18_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/Inc18_all_aligned.fasta
  echo 'Running muscle for Inc18__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Inc18__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/Inc18_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/Inc18_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_1968 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_1968 rep_cluster_1968'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/*rep_cluster_1968.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_1968_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_1968 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_1968 rep_cluster_1968'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_1968_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_1968_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_1968';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_1968_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_1968/rep_cluster_1968_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1018__rep_cluster_185 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_1018_all.fa || true
echo 'Concatenating rep_cluster_1018__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1018__rep_cluster_185 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_1018_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1018__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1018__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_1018_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1197__rep_cluster_185 rep_cluster_1197'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/*rep_cluster_1197.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_1197_all.fa || true
echo 'Concatenating rep_cluster_1197__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1197__rep_cluster_185 rep_cluster_1197'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_1197_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_1197_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1197__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1197__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_1197_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_1197_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1197__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_2146 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_2146 rep_cluster_2146'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/*rep_cluster_2146.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_2146_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_2146 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_2146 rep_cluster_2146'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_2146_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_2146_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_2146';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_2146_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2146/rep_cluster_2146_all_aligned.fasta
fi

echo 'Concatenating Col156__rep_cluster_2131 Col156'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/*Col156.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/Col156_all.fa || true
echo 'Concatenating Col156__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Col156__rep_cluster_2131 Col156'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/Col156_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/Col156_all_aligned.fasta
  echo 'Running muscle for Col156__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Col156__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/Col156_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/Col156_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating IncR__IncX1 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncR_all.fa || true
echo 'Concatenating IncR__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__IncX1 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__rep_cluster_2077 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__rep_cluster_2077 rep_cluster_2077'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/*rep_cluster_2077.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/rep_cluster_2077_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__rep_cluster_2077 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__rep_cluster_2077 rep_cluster_2077'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/rep_cluster_2077_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/rep_cluster_2077_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__rep_cluster_2077';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/rep_cluster_2077_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2077/rep_cluster_2077_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2232 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2232 rep_cluster_2232'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/*rep_cluster_2232.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/rep_cluster_2232_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2232 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2232 rep_cluster_2232'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/rep_cluster_2232_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2232';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/rep_cluster_2232_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncN IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncN IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1216__rep_cluster_1733 rep_cluster_1216'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/*rep_cluster_1216.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1216_all.fa || true
echo 'Concatenating rep_cluster_1216__rep_cluster_1733 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1733_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1216__rep_cluster_1733 rep_cluster_1216'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1216_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1216_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1216__rep_cluster_1733 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1216__rep_cluster_1733';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1216_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1216_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1216__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
fi

echo 'Concatenating IncI1__rep_cluster_1057 IncI1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/*IncI1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/IncI1_all.fa || true
echo 'Concatenating IncI1__rep_cluster_1057 rep_cluster_1057'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/*rep_cluster_1057.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/rep_cluster_1057_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncI1__rep_cluster_1057 IncI1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/IncI1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/IncI1_all_aligned.fasta
  echo 'Running muscle for IncI1__rep_cluster_1057 rep_cluster_1057'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/rep_cluster_1057_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/rep_cluster_1057_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncI1__rep_cluster_1057';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/IncI1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/IncI1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/rep_cluster_1057_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI1__rep_cluster_1057/rep_cluster_1057_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2183 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2183 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_910 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_910 rep_cluster_910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/*rep_cluster_910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_910 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_910 rep_cluster_910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_910/rep_cluster_910_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_185 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_185 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1110 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1110 rep_cluster_1110'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/*rep_cluster_1110.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1110_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1110 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1110 rep_cluster_1110'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1110_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1110_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1110';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1110_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1110/rep_cluster_1110_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1442__rep_cluster_2215 rep_cluster_1442'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/*rep_cluster_1442.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_1442_all.fa || true
echo 'Concatenating rep_cluster_1442__rep_cluster_2215 rep_cluster_2215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/*rep_cluster_2215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_2215_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1442__rep_cluster_2215 rep_cluster_1442'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_1442_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_1442_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1442__rep_cluster_2215 rep_cluster_2215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_2215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_2215_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1442__rep_cluster_2215';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_1442_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_1442_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_2215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_2215/rep_cluster_2215_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_164__rep_cluster_1751 rep_cluster_164'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/*rep_cluster_164.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_164_all.fa || true
echo 'Concatenating rep_cluster_164__rep_cluster_1751 rep_cluster_1751'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/*rep_cluster_1751.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_1751_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_164__rep_cluster_1751 rep_cluster_164'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_164_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_164_all_aligned.fasta
  echo 'Running muscle for rep_cluster_164__rep_cluster_1751 rep_cluster_1751'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_1751_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_1751_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_164__rep_cluster_1751';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_164_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_164_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_1751_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_164__rep_cluster_1751/rep_cluster_1751_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_889__rep_cluster_893 rep_cluster_889'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/*rep_cluster_889.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_889_all.fa || true
echo 'Concatenating rep_cluster_889__rep_cluster_893 rep_cluster_893'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/*rep_cluster_893.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_893_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_889__rep_cluster_893 rep_cluster_889'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_889_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_889_all_aligned.fasta
  echo 'Running muscle for rep_cluster_889__rep_cluster_893 rep_cluster_893'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_893_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_893_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_889__rep_cluster_893';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_889_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_889_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_893_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_893/rep_cluster_893_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncR IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncR IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncU IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncU IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncU IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncFII_all.fa || true
echo 'Concatenating IncFII__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncU IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncR__IncU IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncR_all.fa || true
echo 'Concatenating IncR__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__IncU IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncU__rep_cluster_2183 IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/IncU_all.fa || true
echo 'Concatenating IncU__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncU__rep_cluster_2183 IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/IncU_all_aligned.fasta
  echo 'Running muscle for IncU__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncU__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/IncU_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2232 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2232 rep_cluster_2232'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/*rep_cluster_2232.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/rep_cluster_2232_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2232 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2232 rep_cluster_2232'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/rep_cluster_2232_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2232';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/rep_cluster_2232_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
fi

echo 'Concatenating IncHI1A__IncP IncHI1A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/*IncHI1A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncHI1A_all.fa || true
echo 'Concatenating IncHI1A__IncP IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncP_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1A__IncP IncHI1A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncHI1A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncHI1A_all_aligned.fasta
  echo 'Running muscle for IncHI1A__IncP IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncP_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1A__IncP';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncHI1A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncHI1A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncP/IncP_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2183 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2183 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_183__rep_cluster_185 rep_cluster_183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/*rep_cluster_183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_183_all.fa || true
echo 'Concatenating rep_cluster_183__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_183__rep_cluster_185 rep_cluster_183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_183_all_aligned.fasta
  echo 'Running muscle for rep_cluster_183__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_183__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_183_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_183__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating IncC__rep_cluster_1254 IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/IncC_all.fa || true
echo 'Concatenating IncC__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__rep_cluster_1254 IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating Inc18__rep_cluster_893 Inc18'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/*Inc18.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/Inc18_all.fa || true
echo 'Concatenating Inc18__rep_cluster_893 rep_cluster_893'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/*rep_cluster_893.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/rep_cluster_893_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Inc18__rep_cluster_893 Inc18'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/Inc18_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/Inc18_all_aligned.fasta
  echo 'Running muscle for Inc18__rep_cluster_893 rep_cluster_893'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/rep_cluster_893_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/rep_cluster_893_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Inc18__rep_cluster_893';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/Inc18_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/Inc18_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/rep_cluster_893_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_893/rep_cluster_893_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1567__rep_cluster_731 rep_cluster_1567'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/*rep_cluster_1567.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_1567_all.fa || true
echo 'Concatenating rep_cluster_1567__rep_cluster_731 rep_cluster_731'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/*rep_cluster_731.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_731_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1567__rep_cluster_731 rep_cluster_1567'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_1567_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_1567_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1567__rep_cluster_731 rep_cluster_731'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_731_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_731_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1567__rep_cluster_731';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_1567_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_1567_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_731_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1567__rep_cluster_731/rep_cluster_731_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_645 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_645 rep_cluster_645'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/*rep_cluster_645.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/rep_cluster_645_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_645 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_645 rep_cluster_645'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/rep_cluster_645_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/rep_cluster_645_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_645';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/rep_cluster_645_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_645/rep_cluster_645_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncR IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncR IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1721__rep_cluster_484 rep_cluster_1721'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/*rep_cluster_1721.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_1721_all.fa || true
echo 'Concatenating rep_cluster_1721__rep_cluster_484 rep_cluster_484'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/*rep_cluster_484.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_484_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1721__rep_cluster_484 rep_cluster_1721'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_1721_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_1721_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1721__rep_cluster_484 rep_cluster_484'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_484_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_484_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1721__rep_cluster_484';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_1721_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_1721_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_484_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1721__rep_cluster_484/rep_cluster_484_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_169__rep_cluster_1721 rep_cluster_169'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/*rep_cluster_169.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_169_all.fa || true
echo 'Concatenating rep_cluster_169__rep_cluster_1721 rep_cluster_1721'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/*rep_cluster_1721.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_1721_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_169__rep_cluster_1721 rep_cluster_169'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_169_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_169_all_aligned.fasta
  echo 'Running muscle for rep_cluster_169__rep_cluster_1721 rep_cluster_1721'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_1721_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_1721_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_169__rep_cluster_1721';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_169_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_169_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_1721_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_169__rep_cluster_1721/rep_cluster_1721_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2392 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2392 rep_cluster_2392'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/*rep_cluster_2392.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/rep_cluster_2392_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2392 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2392 rep_cluster_2392'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/rep_cluster_2392_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/rep_cluster_2392_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2392';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/rep_cluster_2392_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2392/rep_cluster_2392_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncU IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncU IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2358 ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2358 ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncI_gamma_K1 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncI_gamma_K1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncI_gamma_K1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncI_gamma_K1 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncI_gamma_K1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncI_gamma_K1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncI_gamma_K1 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncI_gamma_K1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncI_gamma_K1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncI_gamma_K1 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncI_gamma_K1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncI_gamma_K1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncI_gamma_K1 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncFII_all.fa || true
echo 'Concatenating IncFII__IncI_gamma_K1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncI_gamma_K1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncI_gamma_K1 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncI_gamma_K1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncI_gamma_K1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1254 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1254 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncQ1 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncQ1 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_1418 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_1418 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIA ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIA IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/IncFIA_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIA ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIA IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/IncFIA_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncFIA';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIA/IncFIA_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIB ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIB IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/IncFIB_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIB ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIB IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/IncFIB_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncFIB';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIB/IncFIB_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncX1 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncX1 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncX1 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncFII_all.fa || true
echo 'Concatenating IncFII__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncX1 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1215 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1215 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1215_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1215 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1215 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1215_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1215';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1215/rep_cluster_1215_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1733 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1733 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1733_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1733 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1733 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1733';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_2100 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_2100 rep_cluster_2100'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/*rep_cluster_2100.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_2100_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2100 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2100 rep_cluster_2100'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_2100_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_2100_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_2100';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_2100_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2100/rep_cluster_2100_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1733__rep_cluster_2100 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_1733_all.fa || true
echo 'Concatenating rep_cluster_1733__rep_cluster_2100 rep_cluster_2100'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/*rep_cluster_2100.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_2100_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2100 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_1733_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2100 rep_cluster_2100'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_2100_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_2100_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1733__rep_cluster_2100';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_1733_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_2100_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2100/rep_cluster_2100_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1018__rep_cluster_1118 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1018_all.fa || true
echo 'Concatenating rep_cluster_1018__rep_cluster_1118 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1118_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1118 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1018_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1118 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1018__rep_cluster_1118';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1018_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1018__rep_cluster_2120 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_1018_all.fa || true
echo 'Concatenating rep_cluster_1018__rep_cluster_2120 rep_cluster_2120'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/*rep_cluster_2120.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_2120_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1018__rep_cluster_2120 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_1018_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1018__rep_cluster_2120 rep_cluster_2120'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_2120_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_2120_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1018__rep_cluster_2120';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_1018_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_2120_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_2120/rep_cluster_2120_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__IncQ1 IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__IncQ1 IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncQ1__rep_cluster_1088 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/IncQ1_all.fa || true
echo 'Concatenating IncQ1__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__rep_cluster_1088 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__rep_cluster_1254 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__rep_cluster_1254 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncU IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncU IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncU__rep_cluster_1254 IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/IncU_all.fa || true
echo 'Concatenating IncU__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncU__rep_cluster_1254 IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/IncU_all_aligned.fasta
  echo 'Running muscle for IncU__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncU__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/IncU_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_392__rep_cluster_517 rep_cluster_392'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/*rep_cluster_392.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_392_all.fa || true
echo 'Concatenating rep_cluster_392__rep_cluster_517 rep_cluster_517'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/*rep_cluster_517.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_517_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_392__rep_cluster_517 rep_cluster_392'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_392_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_392_all_aligned.fasta
  echo 'Running muscle for rep_cluster_392__rep_cluster_517 rep_cluster_517'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_517_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_517_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_392__rep_cluster_517';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_392_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_392_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_517_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_392__rep_cluster_517/rep_cluster_517_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncI1 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncFII_all.fa || true
echo 'Concatenating IncFII__IncI1 IncI1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/*IncI1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncI1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncI1 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncI1 IncI1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncI1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncI1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncI1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncI1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncI1/IncI1_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_1254 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_1254 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1254__rep_cluster_2183 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_1254_all.fa || true
echo 'Concatenating rep_cluster_1254__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1254__rep_cluster_2183 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_1254_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1254__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1254__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_1254_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncQ1 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncFII_all.fa || true
echo 'Concatenating IncFII__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncQ1 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncQ1__rep_cluster_2183 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/IncQ1_all.fa || true
echo 'Concatenating IncQ1__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__rep_cluster_2183 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2335 ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2335 rep_cluster_2335'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/*rep_cluster_2335.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/rep_cluster_2335_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2335 ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2335 rep_cluster_2335'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/rep_cluster_2335_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/rep_cluster_2335_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__rep_cluster_2335';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/rep_cluster_2335_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2335/rep_cluster_2335_all_aligned.fasta
fi

echo 'Concatenating IncQ1__rep_cluster_1418 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/IncQ1_all.fa || true
echo 'Concatenating IncQ1__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__rep_cluster_1418 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1418__rep_cluster_2183 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_1418_all.fa || true
echo 'Concatenating rep_cluster_1418__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1418__rep_cluster_2183 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_1418_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1418__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1418__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_1418_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1418__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncX1__IncY IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncX1_all.fa || true
echo 'Concatenating IncX1__IncY IncY'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/*IncY.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncY_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncX1__IncY IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncX1_all_aligned.fasta
  echo 'Running muscle for IncX1__IncY IncY'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncY_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncY_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncX1__IncY';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncX1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncY_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncY/IncY_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncI1 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncI1 IncI1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/*IncI1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncI1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncI1 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncI1 IncI1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncI1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncI1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncI1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncI1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncI1/IncI1_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncI1 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncI1 IncI1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/*IncI1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncI1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncI1 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncI1 IncI1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncI1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncI1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncI1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncI1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI1/IncI1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_125__rep_cluster_1721 rep_cluster_125'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/*rep_cluster_125.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_125_all.fa || true
echo 'Concatenating rep_cluster_125__rep_cluster_1721 rep_cluster_1721'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/*rep_cluster_1721.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_1721_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_125__rep_cluster_1721 rep_cluster_125'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_125_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_125_all_aligned.fasta
  echo 'Running muscle for rep_cluster_125__rep_cluster_1721 rep_cluster_1721'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_1721_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_1721_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_125__rep_cluster_1721';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_125_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_125_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_1721_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_1721/rep_cluster_1721_all_aligned.fasta
fi

echo 'Concatenating IncU__rep_cluster_1418 IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/IncU_all.fa || true
echo 'Concatenating IncU__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncU__rep_cluster_1418 IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/IncU_all_aligned.fasta
  echo 'Running muscle for IncU__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncU__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/IncU_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncU__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2313 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2313 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncX1 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncX1 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncN IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncN IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2373 ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2373 rep_cluster_2373'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/*rep_cluster_2373.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/rep_cluster_2373_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2373 ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2373 rep_cluster_2373'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/rep_cluster_2373_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__rep_cluster_2373';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/rep_cluster_2373_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
fi

echo 'Concatenating IncC__IncN IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncC_all.fa || true
echo 'Concatenating IncC__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncN IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncX1__IncX3 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX1_all.fa || true
echo 'Concatenating IncX1__IncX3 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX3_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncX1__IncX3 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX1_all_aligned.fasta
  echo 'Running muscle for IncX1__IncX3 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX3_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncX1__IncX3';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX1__IncX3/IncX3_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2131 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2131 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2131 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2131 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__IncP IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__IncP IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncP_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__IncP IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__IncP IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncP_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__IncP';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncP/IncP_all_aligned.fasta
fi

echo 'Concatenating IncP__rep_cluster_1088 IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/IncP_all.fa || true
echo 'Concatenating IncP__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncP__rep_cluster_1088 IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/IncP_all_aligned.fasta
  echo 'Running muscle for IncP__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncP__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/IncP_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1142 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1142 rep_cluster_1142'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/*rep_cluster_1142.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1142_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1142 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1142 rep_cluster_1142'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1142_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1142_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1142';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1142_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1142/rep_cluster_1142_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1215__rep_cluster_1733 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1215_all.fa || true
echo 'Concatenating rep_cluster_1215__rep_cluster_1733 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1733_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1215__rep_cluster_1733 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1215_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1215__rep_cluster_1733 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1215__rep_cluster_1733';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1215_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1281 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1281 rep_cluster_1281'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/*rep_cluster_1281.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1281_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1281 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1281 rep_cluster_1281'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1281_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1281';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1281_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1215__rep_cluster_1281 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1215_all.fa || true
echo 'Concatenating rep_cluster_1215__rep_cluster_1281 rep_cluster_1281'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/*rep_cluster_1281.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1281_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1215__rep_cluster_1281 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1215_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1215__rep_cluster_1281 rep_cluster_1281'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1281_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1215__rep_cluster_1281';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1215_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1281_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1118 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1118 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1118_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1118 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1118 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1118';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_765 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_765 rep_cluster_765'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/*rep_cluster_765.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_765_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_765 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_765 rep_cluster_765'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_765_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_765_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_765';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_765_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_765/rep_cluster_765_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_1733 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_1733 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1733_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1733 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1733 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_1733';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_910 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_910 rep_cluster_910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/*rep_cluster_910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_910 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_910 rep_cluster_910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_910/rep_cluster_910_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1215__rep_cluster_910 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_1215_all.fa || true
echo 'Concatenating rep_cluster_1215__rep_cluster_910 rep_cluster_910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/*rep_cluster_910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1215__rep_cluster_910 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_1215_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1215__rep_cluster_910 rep_cluster_910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1215__rep_cluster_910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_1215_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_910/rep_cluster_910_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1215__rep_cluster_2214 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_1215_all.fa || true
echo 'Concatenating rep_cluster_1215__rep_cluster_2214 rep_cluster_2214'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/*rep_cluster_2214.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_2214_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1215__rep_cluster_2214 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_1215_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1215__rep_cluster_2214 rep_cluster_2214'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_2214_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1215__rep_cluster_2214';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_1215_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_2214_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1215__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
fi

echo 'Concatenating IncR__rep_cluster_1254 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/IncR_all.fa || true
echo 'Concatenating IncR__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__rep_cluster_1254 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1254__rep_cluster_1418 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1254_all.fa || true
echo 'Concatenating rep_cluster_1254__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1254__rep_cluster_1418 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1254_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1254__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1254__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1254_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1110__rep_cluster_1442 rep_cluster_1110'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/*rep_cluster_1110.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1110_all.fa || true
echo 'Concatenating rep_cluster_1110__rep_cluster_1442 rep_cluster_1442'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/*rep_cluster_1442.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1442_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1110__rep_cluster_1442 rep_cluster_1110'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1110_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1110_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1110__rep_cluster_1442 rep_cluster_1442'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1442_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1442_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1110__rep_cluster_1442';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1110_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1110_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1442_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1110__rep_cluster_1442/rep_cluster_1442_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1442__rep_cluster_910 rep_cluster_1442'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/*rep_cluster_1442.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_1442_all.fa || true
echo 'Concatenating rep_cluster_1442__rep_cluster_910 rep_cluster_910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/*rep_cluster_910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1442__rep_cluster_910 rep_cluster_1442'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_1442_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_1442_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1442__rep_cluster_910 rep_cluster_910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1442__rep_cluster_910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_1442_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_1442_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1442__rep_cluster_910/rep_cluster_910_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2409__rep_cluster_910 rep_cluster_2409'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/*rep_cluster_2409.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_2409_all.fa || true
echo 'Concatenating rep_cluster_2409__rep_cluster_910 rep_cluster_910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/*rep_cluster_910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2409__rep_cluster_910 rep_cluster_2409'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_2409_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_2409_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2409__rep_cluster_910 rep_cluster_910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2409__rep_cluster_910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_2409_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_2409_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2409__rep_cluster_910/rep_cluster_910_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2183 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2183 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2131 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2131 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2313 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2313 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2131 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2131 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2335__rep_cluster_2358 rep_cluster_2335'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/*rep_cluster_2335.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2335_all.fa || true
echo 'Concatenating rep_cluster_2335__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2335__rep_cluster_2358 rep_cluster_2335'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2335_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2335_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2335__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2335__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2335_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2335_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2313 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2313 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2232 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2232 rep_cluster_2232'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/*rep_cluster_2232.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/rep_cluster_2232_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2232 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2232 rep_cluster_2232'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/rep_cluster_2232_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2232';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/rep_cluster_2232_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__IncFIB ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__IncFIB IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/IncFIB_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncFIB ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncFIB IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/IncFIB_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__IncFIB';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFIB/IncFIB_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__IncFII ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncFII ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2327 ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2327 rep_cluster_2327'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/*rep_cluster_2327.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/rep_cluster_2327_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2327 ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2327 rep_cluster_2327'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/rep_cluster_2327_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/rep_cluster_2327_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__rep_cluster_2327';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/rep_cluster_2327_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2327/rep_cluster_2327_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncY IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncY IncY'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/*IncY.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncY_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncY IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncY IncY'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncY_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncY_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncY';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncY_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncY/IncY_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncX1 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncX1 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2350__rep_cluster_2370 rep_cluster_2350'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/*rep_cluster_2350.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2350_all.fa || true
echo 'Concatenating rep_cluster_2350__rep_cluster_2370 rep_cluster_2370'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/*rep_cluster_2370.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2370_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2350__rep_cluster_2370 rep_cluster_2350'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2350_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2350_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2350__rep_cluster_2370 rep_cluster_2370'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2370_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2370_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2350__rep_cluster_2370';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2350_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2350_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2370_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2350__rep_cluster_2370/rep_cluster_2370_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_1760 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_1760 rep_cluster_1760'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/*rep_cluster_1760.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/rep_cluster_1760_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_1760 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_1760 rep_cluster_1760'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/rep_cluster_1760_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/rep_cluster_1760_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_1760';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/rep_cluster_1760_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1760/rep_cluster_1760_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1760 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1760 rep_cluster_1760'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/*rep_cluster_1760.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/rep_cluster_1760_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1760 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1760 rep_cluster_1760'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/rep_cluster_1760_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/rep_cluster_1760_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1760';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/rep_cluster_1760_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1760/rep_cluster_1760_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncI_gamma_K1 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncI_gamma_K1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncI_gamma_K1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncI_gamma_K1 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncI_gamma_K1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncI_gamma_K1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncI_gamma_K1/IncI_gamma_K1_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncK2_Z IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncK2_Z IncK2_Z'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/*IncK2_Z.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncK2_Z_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncK2_Z IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncK2_Z IncK2_Z'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncK2_Z_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncK2_Z_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncK2_Z';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncK2_Z_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncK2_Z/IncK2_Z_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2244 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2244 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncY IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncY IncY'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/*IncY.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncY_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncY IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncY IncY'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncY_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncY_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncY';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncY_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncY/IncY_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncQ1 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncQ1 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncQ1__rep_cluster_2244 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/IncQ1_all.fa || true
echo 'Concatenating IncQ1__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__rep_cluster_2244 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2232 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2232 rep_cluster_2232'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/*rep_cluster_2232.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/rep_cluster_2232_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2232 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2232 rep_cluster_2232'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/rep_cluster_2232_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2232';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/rep_cluster_2232_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2232/rep_cluster_2232_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_2313 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_2313 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2232__rep_cluster_2313 rep_cluster_2232'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/*rep_cluster_2232.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2232_all.fa || true
echo 'Concatenating rep_cluster_2232__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2232__rep_cluster_2313 rep_cluster_2232'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2232_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2232_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2232__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2232__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2232_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2232_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2232__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncHI2A IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncHI2A IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncHI2A_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncHI2A IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncHI2A IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncHI2A_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncHI2A';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI2A/IncHI2A_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_1088 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_1088 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncHI2A IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncHI2A IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncHI2A_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncHI2A IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncHI2A IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncHI2A_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncHI2A';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncHI2A/IncHI2A_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1088 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1088 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__IncN IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__IncN IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncN__rep_cluster_1088 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/IncN_all.fa || true
echo 'Concatenating IncN__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__rep_cluster_1088 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncP IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncP IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncP_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncP IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncP IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncP_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncP';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncP/IncP_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1254__rep_cluster_1364 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1254_all.fa || true
echo 'Concatenating rep_cluster_1254__rep_cluster_1364 rep_cluster_1364'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/*rep_cluster_1364.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1364_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1254__rep_cluster_1364 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1254_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1254__rep_cluster_1364 rep_cluster_1364'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1364_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1364_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1254__rep_cluster_1364';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1254_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1364_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1254__rep_cluster_1364/rep_cluster_1364_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncFII ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFII ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncHI1B IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncHI1B IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncHI1B_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncHI1B IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncHI1B IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncHI1B_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncHI1B';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncHI1B/IncHI1B_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_1254 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_1254 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_935 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_935 rep_cluster_935'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/*rep_cluster_935.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_935_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_935 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_935 rep_cluster_935'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_935_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_935_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_935';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_935_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_935/rep_cluster_935_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_889 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_889 rep_cluster_889'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/*rep_cluster_889.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_889_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_889 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_889 rep_cluster_889'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_889_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_889_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_889';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_889_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_889/rep_cluster_889_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2358__rep_cluster_2373 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2358_all.fa || true
echo 'Concatenating rep_cluster_2358__rep_cluster_2373 rep_cluster_2373'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/*rep_cluster_2373.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2373_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2358__rep_cluster_2373 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2358_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2358__rep_cluster_2373 rep_cluster_2373'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2373_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2358__rep_cluster_2373';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2358_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2373_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2358__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__IncR ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncR ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncX3 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncX3 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncX3_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncX3 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncX3 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncX3_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncX3';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncX3/IncX3_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncX3 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncFII_all.fa || true
echo 'Concatenating IncFII__IncX3 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncX3_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncX3 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncX3 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncX3_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncX3';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncX3/IncX3_all_aligned.fasta
fi

echo 'Concatenating IncX3__rep_cluster_2183 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/IncX3_all.fa || true
echo 'Concatenating IncX3__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncX3__rep_cluster_2183 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/IncX3_all_aligned.fasta
  echo 'Running muscle for IncX3__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncX3__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/IncX3_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_554__rep_cluster_667 rep_cluster_554'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/*rep_cluster_554.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_554_all.fa || true
echo 'Concatenating rep_cluster_554__rep_cluster_667 rep_cluster_667'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/*rep_cluster_667.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_667_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_554__rep_cluster_667 rep_cluster_554'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_554_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_554_all_aligned.fasta
  echo 'Running muscle for rep_cluster_554__rep_cluster_667 rep_cluster_667'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_667_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_667_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_554__rep_cluster_667';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_554_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_554_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_667_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_667/rep_cluster_667_all_aligned.fasta
fi

echo 'Concatenating IncX3__rep_cluster_1195 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/IncX3_all.fa || true
echo 'Concatenating IncX3__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncX3__rep_cluster_1195 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/IncX3_all_aligned.fasta
  echo 'Running muscle for IncX3__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncX3__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/IncX3_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncX3__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2165 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2165 rep_cluster_2165'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/*rep_cluster_2165.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/rep_cluster_2165_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2165 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2165 rep_cluster_2165'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/rep_cluster_2165_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/rep_cluster_2165_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2165';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/rep_cluster_2165_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2165/rep_cluster_2165_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncHI2A IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncFII_all.fa || true
echo 'Concatenating IncFII__IncHI2A IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncHI2A_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncHI2A IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncHI2A IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncHI2A_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncHI2A';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI2A/IncHI2A_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_1088 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_1088 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncP__rep_cluster_398 IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/IncP_all.fa || true
echo 'Concatenating IncP__rep_cluster_398 rep_cluster_398'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/*rep_cluster_398.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/rep_cluster_398_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncP__rep_cluster_398 IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/IncP_all_aligned.fasta
  echo 'Running muscle for IncP__rep_cluster_398 rep_cluster_398'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/rep_cluster_398_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/rep_cluster_398_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncP__rep_cluster_398';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/IncP_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/rep_cluster_398_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_398/rep_cluster_398_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2131__rep_cluster_2313 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2131_all.fa || true
echo 'Concatenating rep_cluster_2131__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2131__rep_cluster_2313 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2131_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2131__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2131__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2131_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2131__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating Col156__IncFIB Col156'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/*Col156.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/Col156_all.fa || true
echo 'Concatenating Col156__IncFIB IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/IncFIB_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Col156__IncFIB Col156'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/Col156_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/Col156_all_aligned.fasta
  echo 'Running muscle for Col156__IncFIB IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/IncFIB_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Col156__IncFIB';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/Col156_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/Col156_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIB/IncFIB_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_574 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_574 rep_cluster_574'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/*rep_cluster_574.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/rep_cluster_574_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_574 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_574 rep_cluster_574'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/rep_cluster_574_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/rep_cluster_574_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_574';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/rep_cluster_574_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_574/rep_cluster_574_all_aligned.fasta
fi

echo 'Concatenating IncFIB__IncK2_Z IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncFIB_all.fa || true
echo 'Concatenating IncFIB__IncK2_Z IncK2_Z'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/*IncK2_Z.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncK2_Z_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__IncK2_Z IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__IncK2_Z IncK2_Z'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncK2_Z_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncK2_Z_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__IncK2_Z';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncK2_Z_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__IncK2_Z/IncK2_Z_all_aligned.fasta
fi

echo 'Concatenating IncI_gamma_K1__IncQ1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncI_gamma_K1_all.fa || true
echo 'Concatenating IncI_gamma_K1__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncI_gamma_K1__IncQ1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncI_gamma_K1_all_aligned.fasta
  echo 'Running muscle for IncI_gamma_K1__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncI_gamma_K1__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncI_gamma_K1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncQ1__rep_cluster_2131 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/IncQ1_all.fa || true
echo 'Concatenating IncQ1__rep_cluster_2131 rep_cluster_2131'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/*rep_cluster_2131.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/rep_cluster_2131_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__rep_cluster_2131 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__rep_cluster_2131 rep_cluster_2131'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/rep_cluster_2131_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__rep_cluster_2131';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/rep_cluster_2131_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__rep_cluster_2131/rep_cluster_2131_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncR ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncR ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2350 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2350 rep_cluster_2350'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/*rep_cluster_2350.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/rep_cluster_2350_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2350 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2350 rep_cluster_2350'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/rep_cluster_2350_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/rep_cluster_2350_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2350';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/rep_cluster_2350_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2350/rep_cluster_2350_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_137__rep_cluster_60 rep_cluster_137'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/*rep_cluster_137.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_137_all.fa || true
echo 'Concatenating rep_cluster_137__rep_cluster_60 rep_cluster_60'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/*rep_cluster_60.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_60_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_137__rep_cluster_60 rep_cluster_137'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_137_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_137_all_aligned.fasta
  echo 'Running muscle for rep_cluster_137__rep_cluster_60 rep_cluster_60'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_60_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_60_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_137__rep_cluster_60';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_137_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_137_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_60_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_137__rep_cluster_60/rep_cluster_60_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1607__rep_cluster_707 rep_cluster_1607'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/*rep_cluster_1607.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_1607_all.fa || true
echo 'Concatenating rep_cluster_1607__rep_cluster_707 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_707_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1607__rep_cluster_707 rep_cluster_1607'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_1607_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_1607_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1607__rep_cluster_707 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_707_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1607__rep_cluster_707';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_1607_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_1607_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1607__rep_cluster_707/rep_cluster_707_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_167__rep_cluster_707 rep_cluster_167'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/*rep_cluster_167.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_167_all.fa || true
echo 'Concatenating rep_cluster_167__rep_cluster_707 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_707_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_167__rep_cluster_707 rep_cluster_167'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_167_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_167_all_aligned.fasta
  echo 'Running muscle for rep_cluster_167__rep_cluster_707 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_707_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_167__rep_cluster_707';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_167_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_167_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_167__rep_cluster_707/rep_cluster_707_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_707__rep_cluster_731 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_707_all.fa || true
echo 'Concatenating rep_cluster_707__rep_cluster_731 rep_cluster_731'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/*rep_cluster_731.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_731_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_707__rep_cluster_731 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_707_all_aligned.fasta
  echo 'Running muscle for rep_cluster_707__rep_cluster_731 rep_cluster_731'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_731_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_731_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_707__rep_cluster_731';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_707_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_731_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_707__rep_cluster_731/rep_cluster_731_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1328__rep_cluster_707 rep_cluster_1328'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/*rep_cluster_1328.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_1328_all.fa || true
echo 'Concatenating rep_cluster_1328__rep_cluster_707 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_707_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1328__rep_cluster_707 rep_cluster_1328'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_1328_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_1328_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1328__rep_cluster_707 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_707_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1328__rep_cluster_707';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_1328_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_1328_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_707/rep_cluster_707_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1328__rep_cluster_1465 rep_cluster_1328'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/*rep_cluster_1328.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1328_all.fa || true
echo 'Concatenating rep_cluster_1328__rep_cluster_1465 rep_cluster_1465'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/*rep_cluster_1465.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1465_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1328__rep_cluster_1465 rep_cluster_1328'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1328_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1328_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1328__rep_cluster_1465 rep_cluster_1465'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1465_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1465_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1328__rep_cluster_1465';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1328_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1328_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1465_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1465/rep_cluster_1465_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__rep_cluster_2350 ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__rep_cluster_2350 rep_cluster_2350'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/*rep_cluster_2350.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/rep_cluster_2350_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__rep_cluster_2350 ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__rep_cluster_2350 rep_cluster_2350'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/rep_cluster_2350_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/rep_cluster_2350_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__rep_cluster_2350';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/rep_cluster_2350_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2350/rep_cluster_2350_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_1215 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_1215 rep_cluster_1215'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/*rep_cluster_1215.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1215_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1215 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1215 rep_cluster_1215'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1215_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1215_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_1215';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1215_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1215/rep_cluster_1215_all_aligned.fasta
fi

echo 'Concatenating IncN__IncQ1 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncN_all.fa || true
echo 'Concatenating IncN__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__IncQ1 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating IncN__IncU IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncN_all.fa || true
echo 'Concatenating IncN__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__IncU IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_252__rep_cluster_735 rep_cluster_252'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/*rep_cluster_252.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_252_all.fa || true
echo 'Concatenating rep_cluster_252__rep_cluster_735 rep_cluster_735'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/*rep_cluster_735.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_735_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_252__rep_cluster_735 rep_cluster_252'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_252_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_252_all_aligned.fasta
  echo 'Running muscle for rep_cluster_252__rep_cluster_735 rep_cluster_735'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_735_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_735_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_252__rep_cluster_735';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_252_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_252_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_735_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_252__rep_cluster_735/rep_cluster_735_all_aligned.fasta
fi

echo 'Concatenating IncN__IncX1 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncN_all.fa || true
echo 'Concatenating IncN__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__IncX1 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_459__rep_cluster_920 rep_cluster_459'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/*rep_cluster_459.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_459_all.fa || true
echo 'Concatenating rep_cluster_459__rep_cluster_920 rep_cluster_920'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/*rep_cluster_920.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_920_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_459__rep_cluster_920 rep_cluster_459'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_459_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_459_all_aligned.fasta
  echo 'Running muscle for rep_cluster_459__rep_cluster_920 rep_cluster_920'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_920_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_920_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_459__rep_cluster_920';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_459_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_459_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_920_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_459__rep_cluster_920/rep_cluster_920_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncR IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncR IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncHI1A__IncQ1 IncHI1A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/*IncHI1A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncHI1A_all.fa || true
echo 'Concatenating IncHI1A__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1A__IncQ1 IncHI1A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncHI1A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncHI1A_all_aligned.fasta
  echo 'Running muscle for IncHI1A__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1A__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncHI1A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncHI1A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1A__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_155 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_155 rep_cluster_155'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/*rep_cluster_155.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_155_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_155 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_155 rep_cluster_155'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_155_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_155_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_155';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_155_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_155/rep_cluster_155_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_155__rep_cluster_1733 rep_cluster_155'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/*rep_cluster_155.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_155_all.fa || true
echo 'Concatenating rep_cluster_155__rep_cluster_1733 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_1733_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_155__rep_cluster_1733 rep_cluster_155'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_155_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_155_all_aligned.fasta
  echo 'Running muscle for rep_cluster_155__rep_cluster_1733 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_155__rep_cluster_1733';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_155_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_155_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_155__rep_cluster_1733/rep_cluster_1733_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_2214 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_2214 rep_cluster_2214'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/*rep_cluster_2214.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_2214_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_2214 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_2214 rep_cluster_2214'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_2214_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_2214';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_2214_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_2214 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_2214 rep_cluster_2214'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/*rep_cluster_2214.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_2214_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2214 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2214 rep_cluster_2214'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_2214_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_2214';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_2214_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2214/rep_cluster_2214_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2335__rep_cluster_2373 rep_cluster_2335'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/*rep_cluster_2335.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2335_all.fa || true
echo 'Concatenating rep_cluster_2335__rep_cluster_2373 rep_cluster_2373'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/*rep_cluster_2373.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2373_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2335__rep_cluster_2373 rep_cluster_2335'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2335_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2335_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2335__rep_cluster_2373 rep_cluster_2373'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2373_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2335__rep_cluster_2373';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2335_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2335_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2373_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2335__rep_cluster_2373/rep_cluster_2373_all_aligned.fasta
fi

echo 'Concatenating IncN__IncR IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncN_all.fa || true
echo 'Concatenating IncN__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__IncR IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1763__rep_cluster_185 rep_cluster_1763'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/*rep_cluster_1763.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_1763_all.fa || true
echo 'Concatenating rep_cluster_1763__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1763__rep_cluster_185 rep_cluster_1763'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_1763_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_1763_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1763__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1763__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_1763_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_1763_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_943 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_943 rep_cluster_943'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/*rep_cluster_943.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_943_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_943 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_943 rep_cluster_943'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_943_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_943_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_943';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_943_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_943/rep_cluster_943_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_185__rep_cluster_2351 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_185_all.fa || true
echo 'Concatenating rep_cluster_185__rep_cluster_2351 rep_cluster_2351'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/*rep_cluster_2351.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_2351_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_185__rep_cluster_2351 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_185_all_aligned.fasta
  echo 'Running muscle for rep_cluster_185__rep_cluster_2351 rep_cluster_2351'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_2351_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_2351_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_185__rep_cluster_2351';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_185_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_2351_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_185__rep_cluster_2351/rep_cluster_2351_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2351__rep_cluster_943 rep_cluster_2351'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/*rep_cluster_2351.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_2351_all.fa || true
echo 'Concatenating rep_cluster_2351__rep_cluster_943 rep_cluster_943'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/*rep_cluster_943.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_943_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2351__rep_cluster_943 rep_cluster_2351'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_2351_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_2351_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2351__rep_cluster_943 rep_cluster_943'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_943_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_943_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2351__rep_cluster_943';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_2351_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_2351_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_943_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2351__rep_cluster_943/rep_cluster_943_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1093__rep_cluster_185 rep_cluster_1093'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/*rep_cluster_1093.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_1093_all.fa || true
echo 'Concatenating rep_cluster_1093__rep_cluster_185 rep_cluster_185'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/*rep_cluster_185.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_185_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1093__rep_cluster_185 rep_cluster_1093'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_1093_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_1093_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1093__rep_cluster_185 rep_cluster_185'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_185_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_185_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1093__rep_cluster_185';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_1093_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_1093_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_185_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_185/rep_cluster_185_all_aligned.fasta
fi

echo 'Concatenating IncP__rep_cluster_1115 IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/IncP_all.fa || true
echo 'Concatenating IncP__rep_cluster_1115 rep_cluster_1115'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/*rep_cluster_1115.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/rep_cluster_1115_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncP__rep_cluster_1115 IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/IncP_all_aligned.fasta
  echo 'Running muscle for IncP__rep_cluster_1115 rep_cluster_1115'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/rep_cluster_1115_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/rep_cluster_1115_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncP__rep_cluster_1115';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/IncP_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/rep_cluster_1115_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__rep_cluster_1115/rep_cluster_1115_all_aligned.fasta
fi

echo 'Concatenating IncL_M__IncU IncL_M'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/*IncL_M.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncL_M_all.fa || true
echo 'Concatenating IncL_M__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncL_M__IncU IncL_M'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncL_M_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncL_M_all_aligned.fasta
  echo 'Running muscle for IncL_M__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncL_M__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncL_M_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncL_M_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncR IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncR IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncL_M IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncL_M IncL_M'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/*IncL_M.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncL_M_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncL_M IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncL_M IncL_M'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncL_M_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncL_M_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncL_M';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncL_M_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncL_M/IncL_M_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2244__rep_cluster_2313 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2244_all.fa || true
echo 'Concatenating rep_cluster_2244__rep_cluster_2313 rep_cluster_2313'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/*rep_cluster_2313.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2313_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2244__rep_cluster_2313 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2244_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2244__rep_cluster_2313 rep_cluster_2313'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2313_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2244__rep_cluster_2313';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2244_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2313_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2244__rep_cluster_2313/rep_cluster_2313_all_aligned.fasta
fi

echo 'Concatenating IncC__IncHI1B IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncC_all.fa || true
echo 'Concatenating IncC__IncHI1B IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncHI1B_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncHI1B IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncHI1B IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncHI1B_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncHI1B';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncHI1B/IncHI1B_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncN IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncFII_all.fa || true
echo 'Concatenating IncFII__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncN IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncC__IncFII IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncC_all.fa || true
echo 'Concatenating IncC__IncFII IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncFII_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncFII IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncFII IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncFII_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncFII';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFII/IncFII_all_aligned.fasta
fi

echo 'Concatenating IncC__rep_cluster_2183 IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/IncC_all.fa || true
echo 'Concatenating IncC__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__rep_cluster_2183 IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncFIA__IncX3 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncFIA_all.fa || true
echo 'Concatenating IncFIA__IncX3 IncX3'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/*IncX3.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncX3_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__IncX3 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__IncX3 IncX3'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncX3_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncX3_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__IncX3';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncX3_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__IncX3/IncX3_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1018__rep_cluster_1142 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1018_all.fa || true
echo 'Concatenating rep_cluster_1018__rep_cluster_1142 rep_cluster_1142'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/*rep_cluster_1142.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1142_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1142 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1018_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1142 rep_cluster_1142'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1142_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1142_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1018__rep_cluster_1142';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1018_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1142_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1142/rep_cluster_1142_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1733__rep_cluster_2176 rep_cluster_1733'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/*rep_cluster_1733.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_1733_all.fa || true
echo 'Concatenating rep_cluster_1733__rep_cluster_2176 rep_cluster_2176'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/*rep_cluster_2176.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_2176_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2176 rep_cluster_1733'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_1733_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_1733_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1733__rep_cluster_2176 rep_cluster_2176'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_2176_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1733__rep_cluster_2176';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_1733_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_1733_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_2176_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1733__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2100__rep_cluster_2176 rep_cluster_2100'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/*rep_cluster_2100.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2100_all.fa || true
echo 'Concatenating rep_cluster_2100__rep_cluster_2176 rep_cluster_2176'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/*rep_cluster_2176.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2176_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2100__rep_cluster_2176 rep_cluster_2100'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2100_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2100_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2100__rep_cluster_2176 rep_cluster_2176'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2176_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2100__rep_cluster_2176';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2100_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2100_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2176_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2100__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_1195 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_1195 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1195 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1195 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_1195 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_1195 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_1195 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_1195 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating IncC__IncFIB IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncC_all.fa || true
echo 'Concatenating IncC__IncFIB IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncFIB_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncFIB IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncFIB IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncFIB_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncFIB';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIB/IncFIB_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1216 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1216 rep_cluster_1216'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/*rep_cluster_1216.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1216_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1216 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1216 rep_cluster_1216'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1216_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1216_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1216';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1216_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1216/rep_cluster_1216_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2374 ColRNAI_rep_cluster_1987'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/*ColRNAI_rep_cluster_1987.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/ColRNAI_rep_cluster_1987_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1987__rep_cluster_2374 rep_cluster_2374'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/*rep_cluster_2374.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/rep_cluster_2374_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2374 ColRNAI_rep_cluster_1987'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/ColRNAI_rep_cluster_1987_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/ColRNAI_rep_cluster_1987_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1987__rep_cluster_2374 rep_cluster_2374'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/rep_cluster_2374_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/rep_cluster_2374_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1987__rep_cluster_2374';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/ColRNAI_rep_cluster_1987_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/ColRNAI_rep_cluster_1987_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/rep_cluster_2374_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1987__rep_cluster_2374/rep_cluster_2374_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2327__rep_cluster_2358 rep_cluster_2327'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/*rep_cluster_2327.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2327_all.fa || true
echo 'Concatenating rep_cluster_2327__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2327__rep_cluster_2358 rep_cluster_2327'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2327_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2327_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2327__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2327__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2327_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2327_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2327__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_980 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_980 rep_cluster_980'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/*rep_cluster_980.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_980_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_980 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_980 rep_cluster_980'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_980_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_980_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_980';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_980_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_980/rep_cluster_980_all_aligned.fasta
fi

echo 'Concatenating Inc18__rep_cluster_1118 Inc18'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/*Inc18.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/Inc18_all.fa || true
echo 'Concatenating Inc18__rep_cluster_1118 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/rep_cluster_1118_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Inc18__rep_cluster_1118 Inc18'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/Inc18_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/Inc18_all_aligned.fasta
  echo 'Running muscle for Inc18__rep_cluster_1118 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Inc18__rep_cluster_1118';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/Inc18_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/Inc18_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc18__rep_cluster_1118/rep_cluster_1118_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_992 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_992 rep_cluster_992'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/*rep_cluster_992.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_992_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_992 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_992 rep_cluster_992'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_992_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_992_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_992';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_992_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_992/rep_cluster_992_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1018 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1018 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1018_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1018 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1018 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1018_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1018';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1018/rep_cluster_1018_all_aligned.fasta
fi

echo 'Concatenating IncI_gamma_K1__IncX1 IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncI_gamma_K1_all.fa || true
echo 'Concatenating IncI_gamma_K1__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncI_gamma_K1__IncX1 IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncI_gamma_K1_all_aligned.fasta
  echo 'Running muscle for IncI_gamma_K1__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncI_gamma_K1__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncI_gamma_K1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating IncC__IncR IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncC_all.fa || true
echo 'Concatenating IncC__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncR IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__rep_cluster_2183 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__rep_cluster_2183 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncHI1B IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncFII_all.fa || true
echo 'Concatenating IncFII__IncHI1B IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncHI1B_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncHI1B IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncHI1B IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncHI1B_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncHI1B';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncHI1B/IncHI1B_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_414__rep_cluster_554 rep_cluster_414'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/*rep_cluster_414.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_414_all.fa || true
echo 'Concatenating rep_cluster_414__rep_cluster_554 rep_cluster_554'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/*rep_cluster_554.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_554_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_414__rep_cluster_554 rep_cluster_414'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_414_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_414_all_aligned.fasta
  echo 'Running muscle for rep_cluster_414__rep_cluster_554 rep_cluster_554'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_554_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_554_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_414__rep_cluster_554';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_414_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_414_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_554_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_414__rep_cluster_554/rep_cluster_554_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_554__rep_cluster_656 rep_cluster_554'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/*rep_cluster_554.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_554_all.fa || true
echo 'Concatenating rep_cluster_554__rep_cluster_656 rep_cluster_656'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/*rep_cluster_656.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_656_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_554__rep_cluster_656 rep_cluster_554'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_554_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_554_all_aligned.fasta
  echo 'Running muscle for rep_cluster_554__rep_cluster_656 rep_cluster_656'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_656_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_656_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_554__rep_cluster_656';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_554_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_554_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_656_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_656/rep_cluster_656_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1879__rep_cluster_1910 rep_cluster_1879'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/*rep_cluster_1879.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1879_all.fa || true
echo 'Concatenating rep_cluster_1879__rep_cluster_1910 rep_cluster_1910'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/*rep_cluster_1910.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1910_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1879__rep_cluster_1910 rep_cluster_1879'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1879_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1879_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1879__rep_cluster_1910 rep_cluster_1910'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1910_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1910_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1879__rep_cluster_1910';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1879_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1879_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1910_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1879__rep_cluster_1910/rep_cluster_1910_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1152__rep_cluster_1320 rep_cluster_1152'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/*rep_cluster_1152.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1152_all.fa || true
echo 'Concatenating rep_cluster_1152__rep_cluster_1320 rep_cluster_1320'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/*rep_cluster_1320.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1320_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1152__rep_cluster_1320 rep_cluster_1152'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1152_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1152_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1152__rep_cluster_1320 rep_cluster_1320'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1320_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1320_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1152__rep_cluster_1320';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1152_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1152_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1320_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1152__rep_cluster_1320/rep_cluster_1320_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1142__rep_cluster_1281 rep_cluster_1142'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/*rep_cluster_1142.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1142_all.fa || true
echo 'Concatenating rep_cluster_1142__rep_cluster_1281 rep_cluster_1281'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/*rep_cluster_1281.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1281_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1142__rep_cluster_1281 rep_cluster_1142'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1142_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1142_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1142__rep_cluster_1281 rep_cluster_1281'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1281_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1142__rep_cluster_1281';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1142_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1142_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1281_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1142__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_560__rep_cluster_969 rep_cluster_560'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/*rep_cluster_560.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_560_all.fa || true
echo 'Concatenating rep_cluster_560__rep_cluster_969 rep_cluster_969'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/*rep_cluster_969.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_969_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_560__rep_cluster_969 rep_cluster_560'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_560_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_560_all_aligned.fasta
  echo 'Running muscle for rep_cluster_560__rep_cluster_969 rep_cluster_969'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_969_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_969_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_560__rep_cluster_969';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_560_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_560_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_969_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_560__rep_cluster_969/rep_cluster_969_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_163__rep_cluster_459 rep_cluster_163'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/*rep_cluster_163.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_163_all.fa || true
echo 'Concatenating rep_cluster_163__rep_cluster_459 rep_cluster_459'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/*rep_cluster_459.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_459_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_163__rep_cluster_459 rep_cluster_163'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_163_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_163_all_aligned.fasta
  echo 'Running muscle for rep_cluster_163__rep_cluster_459 rep_cluster_459'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_459_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_459_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_163__rep_cluster_459';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_163_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_163_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_459_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_163__rep_cluster_459/rep_cluster_459_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1520__rep_cluster_1698 rep_cluster_1520'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/*rep_cluster_1520.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1520_all.fa || true
echo 'Concatenating rep_cluster_1520__rep_cluster_1698 rep_cluster_1698'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/*rep_cluster_1698.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1698_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1520__rep_cluster_1698 rep_cluster_1520'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1520_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1520_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1520__rep_cluster_1698 rep_cluster_1698'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1698_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1698_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1520__rep_cluster_1698';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1520_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1520_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1698_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1520__rep_cluster_1698/rep_cluster_1698_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1848__rep_cluster_1895 rep_cluster_1848'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/*rep_cluster_1848.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1848_all.fa || true
echo 'Concatenating rep_cluster_1848__rep_cluster_1895 rep_cluster_1895'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/*rep_cluster_1895.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1895_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1848__rep_cluster_1895 rep_cluster_1848'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1848_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1848_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1848__rep_cluster_1895 rep_cluster_1895'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1895_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1895_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1848__rep_cluster_1895';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1848_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1848_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1895_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1848__rep_cluster_1895/rep_cluster_1895_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_490__rep_cluster_553 rep_cluster_490'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/*rep_cluster_490.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_490_all.fa || true
echo 'Concatenating rep_cluster_490__rep_cluster_553 rep_cluster_553'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/*rep_cluster_553.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_553_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_490__rep_cluster_553 rep_cluster_490'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_490_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_490_all_aligned.fasta
  echo 'Running muscle for rep_cluster_490__rep_cluster_553 rep_cluster_553'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_553_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_553_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_490__rep_cluster_553';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_490_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_490_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_553_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_490__rep_cluster_553/rep_cluster_553_all_aligned.fasta
fi

echo 'Concatenating Inc11__rep_cluster_556 Inc11'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/*Inc11.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/Inc11_all.fa || true
echo 'Concatenating Inc11__rep_cluster_556 rep_cluster_556'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/*rep_cluster_556.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/rep_cluster_556_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Inc11__rep_cluster_556 Inc11'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/Inc11_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/Inc11_all_aligned.fasta
  echo 'Running muscle for Inc11__rep_cluster_556 rep_cluster_556'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/rep_cluster_556_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/rep_cluster_556_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Inc11__rep_cluster_556';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/Inc11_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/Inc11_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/rep_cluster_556_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Inc11__rep_cluster_556/rep_cluster_556_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1018__rep_cluster_1442 rep_cluster_1018'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/*rep_cluster_1018.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1018_all.fa || true
echo 'Concatenating rep_cluster_1018__rep_cluster_1442 rep_cluster_1442'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/*rep_cluster_1442.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1442_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1442 rep_cluster_1018'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1018_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1018_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1018__rep_cluster_1442 rep_cluster_1442'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1442_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1442_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1018__rep_cluster_1442';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1018_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1018_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1442_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1018__rep_cluster_1442/rep_cluster_1442_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_125__rep_cluster_164 rep_cluster_125'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/*rep_cluster_125.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_125_all.fa || true
echo 'Concatenating rep_cluster_125__rep_cluster_164 rep_cluster_164'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/*rep_cluster_164.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_164_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_125__rep_cluster_164 rep_cluster_125'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_125_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_125_all_aligned.fasta
  echo 'Running muscle for rep_cluster_125__rep_cluster_164 rep_cluster_164'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_164_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_164_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_125__rep_cluster_164';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_125_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_125_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_164_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_164/rep_cluster_164_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_172__rep_cluster_707 rep_cluster_172'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/*rep_cluster_172.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_172_all.fa || true
echo 'Concatenating rep_cluster_172__rep_cluster_707 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_707_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_172__rep_cluster_707 rep_cluster_172'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_172_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_172_all_aligned.fasta
  echo 'Running muscle for rep_cluster_172__rep_cluster_707 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_707_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_172__rep_cluster_707';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_172_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_172_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_172__rep_cluster_707/rep_cluster_707_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_125__rep_cluster_459 rep_cluster_125'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/*rep_cluster_125.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_125_all.fa || true
echo 'Concatenating rep_cluster_125__rep_cluster_459 rep_cluster_459'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/*rep_cluster_459.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_459_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_125__rep_cluster_459 rep_cluster_125'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_125_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_125_all_aligned.fasta
  echo 'Running muscle for rep_cluster_125__rep_cluster_459 rep_cluster_459'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_459_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_459_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_125__rep_cluster_459';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_125_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_125_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_459_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_125__rep_cluster_459/rep_cluster_459_all_aligned.fasta
fi

echo 'Concatenating IncN__rep_cluster_2183 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/IncN_all.fa || true
echo 'Concatenating IncN__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__rep_cluster_2183 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1006__rep_cluster_731 rep_cluster_1006'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/*rep_cluster_1006.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_1006_all.fa || true
echo 'Concatenating rep_cluster_1006__rep_cluster_731 rep_cluster_731'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/*rep_cluster_731.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_731_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1006__rep_cluster_731 rep_cluster_1006'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_1006_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_1006_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1006__rep_cluster_731 rep_cluster_731'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_731_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_731_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1006__rep_cluster_731';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_1006_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_1006_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_731_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_731/rep_cluster_731_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncN IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncN IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncI_gamma_K1__IncN IncI_gamma_K1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/*IncI_gamma_K1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncI_gamma_K1_all.fa || true
echo 'Concatenating IncI_gamma_K1__IncN IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncN_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncI_gamma_K1__IncN IncI_gamma_K1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncI_gamma_K1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncI_gamma_K1_all_aligned.fasta
  echo 'Running muscle for IncI_gamma_K1__IncN IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncN_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncI_gamma_K1__IncN';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncI_gamma_K1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncI_gamma_K1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncI_gamma_K1__IncN/IncN_all_aligned.fasta
fi

echo 'Concatenating IncN__rep_cluster_2244 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/IncN_all.fa || true
echo 'Concatenating IncN__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__rep_cluster_2244 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncP__IncU IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncP_all.fa || true
echo 'Concatenating IncP__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncP__IncU IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncP_all_aligned.fasta
  echo 'Running muscle for IncP__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncP__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncP_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncP__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1006__rep_cluster_707 rep_cluster_1006'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/*rep_cluster_1006.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_1006_all.fa || true
echo 'Concatenating rep_cluster_1006__rep_cluster_707 rep_cluster_707'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/*rep_cluster_707.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_707_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1006__rep_cluster_707 rep_cluster_1006'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_1006_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_1006_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1006__rep_cluster_707 rep_cluster_707'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_707_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_707_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1006__rep_cluster_707';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_1006_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_1006_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_707_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1006__rep_cluster_707/rep_cluster_707_all_aligned.fasta
fi

echo 'Concatenating IncQ1__IncR IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncQ1_all.fa || true
echo 'Concatenating IncQ1__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__IncR IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_2358 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_2358 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating IncR__IncY IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncR_all.fa || true
echo 'Concatenating IncR__IncY IncY'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/*IncY.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncY_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__IncY IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__IncY IncY'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncY_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncY_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__IncY';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncY_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__IncY/IncY_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_312 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_312 rep_cluster_312'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/*rep_cluster_312.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/rep_cluster_312_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_312 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_312 rep_cluster_312'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/rep_cluster_312_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/rep_cluster_312_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_312';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/rep_cluster_312_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_312/rep_cluster_312_all_aligned.fasta
fi

echo 'Concatenating IncFIA__rep_cluster_2370 IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/IncFIA_all.fa || true
echo 'Concatenating IncFIA__rep_cluster_2370 rep_cluster_2370'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/*rep_cluster_2370.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/rep_cluster_2370_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIA__rep_cluster_2370 IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/IncFIA_all_aligned.fasta
  echo 'Running muscle for IncFIA__rep_cluster_2370 rep_cluster_2370'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/rep_cluster_2370_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/rep_cluster_2370_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIA__rep_cluster_2370';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/IncFIA_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/rep_cluster_2370_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIA__rep_cluster_2370/rep_cluster_2370_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__rep_cluster_2358 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__rep_cluster_2358 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2203 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2203 rep_cluster_2203'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/*rep_cluster_2203.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/rep_cluster_2203_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2203 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2203 rep_cluster_2203'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/rep_cluster_2203_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/rep_cluster_2203_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2203';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/rep_cluster_2203_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2203/rep_cluster_2203_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_2176 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_2176 rep_cluster_2176'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/*rep_cluster_2176.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_2176_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2176 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_2176 rep_cluster_2176'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_2176_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_2176';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_2176_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_2176/rep_cluster_2176_all_aligned.fasta
fi

echo 'Concatenating Col156__IncFIA Col156'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/*Col156.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/Col156_all.fa || true
echo 'Concatenating Col156__IncFIA IncFIA'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/*IncFIA.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/IncFIA_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for Col156__IncFIA Col156'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/Col156_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/Col156_all_aligned.fasta
  echo 'Running muscle for Col156__IncFIA IncFIA'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/IncFIA_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/IncFIA_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for Col156__IncFIA';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/Col156_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/Col156_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/IncFIA_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/Col156__IncFIA/IncFIA_all_aligned.fasta
fi

echo 'Concatenating IncN__rep_cluster_1418 IncN'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/*IncN.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/IncN_all.fa || true
echo 'Concatenating IncN__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncN__rep_cluster_1418 IncN'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/IncN_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/IncN_all_aligned.fasta
  echo 'Running muscle for IncN__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncN__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/IncN_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/IncN_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncN__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1763__rep_cluster_889 rep_cluster_1763'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/*rep_cluster_1763.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_1763_all.fa || true
echo 'Concatenating rep_cluster_1763__rep_cluster_889 rep_cluster_889'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/*rep_cluster_889.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_889_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1763__rep_cluster_889 rep_cluster_1763'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_1763_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_1763_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1763__rep_cluster_889 rep_cluster_889'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_889_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_889_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1763__rep_cluster_889';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_1763_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_1763_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_889_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1763__rep_cluster_889/rep_cluster_889_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1465__rep_cluster_731 rep_cluster_1465'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/*rep_cluster_1465.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_1465_all.fa || true
echo 'Concatenating rep_cluster_1465__rep_cluster_731 rep_cluster_731'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/*rep_cluster_731.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_731_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1465__rep_cluster_731 rep_cluster_1465'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_1465_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_1465_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1465__rep_cluster_731 rep_cluster_731'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_731_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_731_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1465__rep_cluster_731';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_1465_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_1465_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_731_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1465__rep_cluster_731/rep_cluster_731_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1259__rep_cluster_1903 rep_cluster_1259'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/*rep_cluster_1259.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1259_all.fa || true
echo 'Concatenating rep_cluster_1259__rep_cluster_1903 rep_cluster_1903'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/*rep_cluster_1903.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1903_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1259__rep_cluster_1903 rep_cluster_1259'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1259_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1259_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1259__rep_cluster_1903 rep_cluster_1903'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1903_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1903_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1259__rep_cluster_1903';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1259_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1259_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1903_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1259__rep_cluster_1903/rep_cluster_1903_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__rep_cluster_2183 ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__rep_cluster_2183 rep_cluster_2183'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/*rep_cluster_2183.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/rep_cluster_2183_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__rep_cluster_2183 ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__rep_cluster_2183 rep_cluster_2183'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/rep_cluster_2183_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__rep_cluster_2183';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/rep_cluster_2183_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__rep_cluster_2183/rep_cluster_2183_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1017__rep_cluster_1596 rep_cluster_1017'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/*rep_cluster_1017.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1017_all.fa || true
echo 'Concatenating rep_cluster_1017__rep_cluster_1596 rep_cluster_1596'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/*rep_cluster_1596.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1596_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1596 rep_cluster_1017'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1017_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1017_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1017__rep_cluster_1596 rep_cluster_1596'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1596_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1596_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1017__rep_cluster_1596';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1017_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1017_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1596_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1017__rep_cluster_1596/rep_cluster_1596_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__rep_cluster_1254 IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__rep_cluster_1254 IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1088__rep_cluster_1254 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1088_all.fa || true
echo 'Concatenating rep_cluster_1088__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1088__rep_cluster_1254 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1088_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1088__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1088__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1088_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2268 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2268 rep_cluster_2268'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/*rep_cluster_2268.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/rep_cluster_2268_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2268 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2268 rep_cluster_2268'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/rep_cluster_2268_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/rep_cluster_2268_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2268';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/rep_cluster_2268_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2268/rep_cluster_2268_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_889__rep_cluster_943 rep_cluster_889'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/*rep_cluster_889.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_889_all.fa || true
echo 'Concatenating rep_cluster_889__rep_cluster_943 rep_cluster_943'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/*rep_cluster_943.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_943_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_889__rep_cluster_943 rep_cluster_889'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_889_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_889_all_aligned.fasta
  echo 'Running muscle for rep_cluster_889__rep_cluster_943 rep_cluster_943'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_943_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_943_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_889__rep_cluster_943';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_889_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_889_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_943_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_889__rep_cluster_943/rep_cluster_943_all_aligned.fasta
fi

echo 'Concatenating IncC__IncU IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncC_all.fa || true
echo 'Concatenating IncC__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncU IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncHI2A IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncHI2A IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncHI2A_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncHI2A IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncHI2A IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncHI2A_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncHI2A';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncHI2A/IncHI2A_all_aligned.fasta
fi

echo 'Concatenating IncFIC__rep_cluster_1088 IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/IncFIC_all.fa || true
echo 'Concatenating IncFIC__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__rep_cluster_1088 IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_160__rep_cluster_392 rep_cluster_160'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/*rep_cluster_160.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_160_all.fa || true
echo 'Concatenating rep_cluster_160__rep_cluster_392 rep_cluster_392'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/*rep_cluster_392.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_392_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_160__rep_cluster_392 rep_cluster_160'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_160_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_160_all_aligned.fasta
  echo 'Running muscle for rep_cluster_160__rep_cluster_392 rep_cluster_392'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_392_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_392_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_160__rep_cluster_392';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_160_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_160_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_392_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_160__rep_cluster_392/rep_cluster_392_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_429__rep_cluster_461 rep_cluster_429'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/*rep_cluster_429.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_429_all.fa || true
echo 'Concatenating rep_cluster_429__rep_cluster_461 rep_cluster_461'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/*rep_cluster_461.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_461_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_429__rep_cluster_461 rep_cluster_429'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_429_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_429_all_aligned.fasta
  echo 'Running muscle for rep_cluster_429__rep_cluster_461 rep_cluster_461'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_461_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_461_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_429__rep_cluster_461';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_429_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_429_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_461_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_429__rep_cluster_461/rep_cluster_461_all_aligned.fasta
fi

echo 'Concatenating IncC__IncFIC IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncC_all.fa || true
echo 'Concatenating IncC__IncFIC IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncFIC_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncFIC IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncFIC IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncFIC_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncFIC';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncFIC/IncFIC_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1948__rep_cluster_2119 rep_cluster_1948'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/*rep_cluster_1948.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_1948_all.fa || true
echo 'Concatenating rep_cluster_1948__rep_cluster_2119 rep_cluster_2119'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/*rep_cluster_2119.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_2119_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1948__rep_cluster_2119 rep_cluster_1948'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_1948_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_1948_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1948__rep_cluster_2119 rep_cluster_2119'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_2119_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_2119_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1948__rep_cluster_2119';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_1948_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_1948_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_2119_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1948__rep_cluster_2119/rep_cluster_2119_all_aligned.fasta
fi

echo 'Concatenating IncL_M__rep_cluster_1254 IncL_M'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/*IncL_M.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/IncL_M_all.fa || true
echo 'Concatenating IncL_M__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncL_M__rep_cluster_1254 IncL_M'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/IncL_M_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/IncL_M_all_aligned.fasta
  echo 'Running muscle for IncL_M__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncL_M__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/IncL_M_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/IncL_M_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating IncFIB__rep_cluster_1804 IncFIB'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/*IncFIB.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/IncFIB_all.fa || true
echo 'Concatenating IncFIB__rep_cluster_1804 rep_cluster_1804'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/*rep_cluster_1804.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/rep_cluster_1804_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIB__rep_cluster_1804 IncFIB'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/IncFIB_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/IncFIB_all_aligned.fasta
  echo 'Running muscle for IncFIB__rep_cluster_1804 rep_cluster_1804'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/rep_cluster_1804_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/rep_cluster_1804_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIB__rep_cluster_1804';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/IncFIB_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/IncFIB_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/rep_cluster_1804_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIB__rep_cluster_1804/rep_cluster_1804_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__rep_cluster_1418 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__rep_cluster_1418 rep_cluster_1418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/*rep_cluster_1418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/rep_cluster_1418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__rep_cluster_1418 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__rep_cluster_1418 rep_cluster_1418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/rep_cluster_1418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__rep_cluster_1418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/rep_cluster_1418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__rep_cluster_1418/rep_cluster_1418_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1218__rep_cluster_639 rep_cluster_1218'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/*rep_cluster_1218.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_1218_all.fa || true
echo 'Concatenating rep_cluster_1218__rep_cluster_639 rep_cluster_639'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/*rep_cluster_639.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_639_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1218__rep_cluster_639 rep_cluster_1218'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_1218_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_1218_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1218__rep_cluster_639 rep_cluster_639'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_639_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_639_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1218__rep_cluster_639';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_1218_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_1218_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_639_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1218__rep_cluster_639/rep_cluster_639_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1088__rep_cluster_2244 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_1088_all.fa || true
echo 'Concatenating rep_cluster_1088__rep_cluster_2244 rep_cluster_2244'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/*rep_cluster_2244.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_2244_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1088__rep_cluster_2244 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_1088_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1088__rep_cluster_2244 rep_cluster_2244'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_2244_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1088__rep_cluster_2244';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_1088_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_2244_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1088__rep_cluster_2244/rep_cluster_2244_all_aligned.fasta
fi

echo 'Concatenating IncC__IncX1 IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncC_all.fa || true
echo 'Concatenating IncC__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncX1 IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating IncHI1B__IncX1 IncHI1B'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/*IncHI1B.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncHI1B_all.fa || true
echo 'Concatenating IncHI1B__IncX1 IncX1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/*IncX1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncX1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI1B__IncX1 IncHI1B'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncHI1B_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncHI1B_all_aligned.fasta
  echo 'Running muscle for IncHI1B__IncX1 IncX1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncX1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncX1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI1B__IncX1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncHI1B_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncHI1B_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncX1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI1B__IncX1/IncX1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1328__rep_cluster_1607 rep_cluster_1328'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/*rep_cluster_1328.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1328_all.fa || true
echo 'Concatenating rep_cluster_1328__rep_cluster_1607 rep_cluster_1607'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/*rep_cluster_1607.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1607_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1328__rep_cluster_1607 rep_cluster_1328'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1328_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1328_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1328__rep_cluster_1607 rep_cluster_1607'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1607_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1607_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1328__rep_cluster_1607';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1328_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1328_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1607_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1328__rep_cluster_1607/rep_cluster_1607_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1093__rep_cluster_889 rep_cluster_1093'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/*rep_cluster_1093.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_1093_all.fa || true
echo 'Concatenating rep_cluster_1093__rep_cluster_889 rep_cluster_889'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/*rep_cluster_889.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_889_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1093__rep_cluster_889 rep_cluster_1093'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_1093_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_1093_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1093__rep_cluster_889 rep_cluster_889'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_889_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_889_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1093__rep_cluster_889';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_1093_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_1093_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_889_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1093__rep_cluster_889/rep_cluster_889_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2078 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2078 rep_cluster_2078'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/*rep_cluster_2078.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/rep_cluster_2078_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2078 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2078 rep_cluster_2078'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/rep_cluster_2078_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/rep_cluster_2078_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2078';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/rep_cluster_2078_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2078/rep_cluster_2078_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1118__rep_cluster_1281 rep_cluster_1118'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/*rep_cluster_1118.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1118_all.fa || true
echo 'Concatenating rep_cluster_1118__rep_cluster_1281 rep_cluster_1281'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/*rep_cluster_1281.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1281_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1281 rep_cluster_1118'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1118_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1118_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1118__rep_cluster_1281 rep_cluster_1281'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1281_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1118__rep_cluster_1281';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1118_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1118_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1281_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1118__rep_cluster_1281/rep_cluster_1281_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_2341__rep_cluster_418 rep_cluster_2341'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/*rep_cluster_2341.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_2341_all.fa || true
echo 'Concatenating rep_cluster_2341__rep_cluster_418 rep_cluster_418'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/*rep_cluster_418.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_418_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_2341__rep_cluster_418 rep_cluster_2341'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_2341_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_2341_all_aligned.fasta
  echo 'Running muscle for rep_cluster_2341__rep_cluster_418 rep_cluster_418'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_418_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_418_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_2341__rep_cluster_418';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_2341_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_2341_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_418_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_2341__rep_cluster_418/rep_cluster_418_all_aligned.fasta
fi

echo 'Concatenating IncQ1__IncU IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncQ1_all.fa || true
echo 'Concatenating IncQ1__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncQ1__IncU IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncQ1_all_aligned.fasta
  echo 'Running muscle for IncQ1__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncQ1__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncQ1_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncQ1__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncFII__IncP IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncFII_all.fa || true
echo 'Concatenating IncFII__IncP IncP'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/*IncP.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncP_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__IncP IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__IncP IncP'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncP_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncP_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__IncP';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncP_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__IncP/IncP_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1115__rep_cluster_1254 rep_cluster_1115'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/*rep_cluster_1115.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1115_all.fa || true
echo 'Concatenating rep_cluster_1115__rep_cluster_1254 rep_cluster_1254'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/*rep_cluster_1254.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1254_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1115__rep_cluster_1254 rep_cluster_1115'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1115_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1115_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1115__rep_cluster_1254 rep_cluster_1254'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1254_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1115__rep_cluster_1254';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1115_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1115_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1254_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1115__rep_cluster_1254/rep_cluster_1254_all_aligned.fasta
fi

echo 'Concatenating IncFII__rep_cluster_2358 IncFII'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/*IncFII.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/IncFII_all.fa || true
echo 'Concatenating IncFII__rep_cluster_2358 rep_cluster_2358'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/*rep_cluster_2358.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/rep_cluster_2358_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFII__rep_cluster_2358 IncFII'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/IncFII_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/IncFII_all_aligned.fasta
  echo 'Running muscle for IncFII__rep_cluster_2358 rep_cluster_2358'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/rep_cluster_2358_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFII__rep_cluster_2358';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/IncFII_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/IncFII_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/rep_cluster_2358_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFII__rep_cluster_2358/rep_cluster_2358_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncU ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncU ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating IncC__IncQ1 IncC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/*IncC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncC_all.fa || true
echo 'Concatenating IncC__IncQ1 IncQ1'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/*IncQ1.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncQ1_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncC__IncQ1 IncC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncC_all_aligned.fasta
  echo 'Running muscle for IncC__IncQ1 IncQ1'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncQ1_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncQ1_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncC__IncQ1';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncQ1_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncC__IncQ1/IncQ1_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_554__rep_cluster_556 rep_cluster_554'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/*rep_cluster_554.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_554_all.fa || true
echo 'Concatenating rep_cluster_554__rep_cluster_556 rep_cluster_556'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/*rep_cluster_556.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_556_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_554__rep_cluster_556 rep_cluster_554'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_554_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_554_all_aligned.fasta
  echo 'Running muscle for rep_cluster_554__rep_cluster_556 rep_cluster_556'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_556_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_556_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_554__rep_cluster_556';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_554_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_554_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_556_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_554__rep_cluster_556/rep_cluster_556_all_aligned.fasta
fi

echo 'Concatenating IncL_M__IncR IncL_M'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/*IncL_M.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncL_M_all.fa || true
echo 'Concatenating IncL_M__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncL_M__IncR IncL_M'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncL_M_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncL_M_all_aligned.fasta
  echo 'Running muscle for IncL_M__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncL_M__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncL_M_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncL_M_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncL_M__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncR__rep_cluster_1195 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/IncR_all.fa || true
echo 'Concatenating IncR__rep_cluster_1195 rep_cluster_1195'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/*rep_cluster_1195.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/rep_cluster_1195_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__rep_cluster_1195 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__rep_cluster_1195 rep_cluster_1195'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/rep_cluster_1195_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__rep_cluster_1195';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/rep_cluster_1195_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1195/rep_cluster_1195_all_aligned.fasta
fi

echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIC ColRNAI_rep_cluster_1857'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/*ColRNAI_rep_cluster_1857.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/ColRNAI_rep_cluster_1857_all.fa || true
echo 'Concatenating ColRNAI_rep_cluster_1857__IncFIC IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/IncFIC_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIC ColRNAI_rep_cluster_1857'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/ColRNAI_rep_cluster_1857_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/ColRNAI_rep_cluster_1857_all_aligned.fasta
  echo 'Running muscle for ColRNAI_rep_cluster_1857__IncFIC IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/IncFIC_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for ColRNAI_rep_cluster_1857__IncFIC';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/ColRNAI_rep_cluster_1857_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/ColRNAI_rep_cluster_1857_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/ColRNAI_rep_cluster_1857__IncFIC/IncFIC_all_aligned.fasta
fi

echo 'Concatenating IncHI2A__IncR IncHI2A'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/*IncHI2A.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncHI2A_all.fa || true
echo 'Concatenating IncHI2A__IncR IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncR_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncHI2A__IncR IncHI2A'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncHI2A_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncHI2A_all_aligned.fasta
  echo 'Running muscle for IncHI2A__IncR IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncR_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncHI2A__IncR';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncHI2A_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncHI2A_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncHI2A__IncR/IncR_all_aligned.fasta
fi

echo 'Concatenating IncR__rep_cluster_1088 IncR'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/*IncR.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/IncR_all.fa || true
echo 'Concatenating IncR__rep_cluster_1088 rep_cluster_1088'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/*rep_cluster_1088.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/rep_cluster_1088_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncR__rep_cluster_1088 IncR'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/IncR_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/IncR_all_aligned.fasta
  echo 'Running muscle for IncR__rep_cluster_1088 rep_cluster_1088'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/rep_cluster_1088_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncR__rep_cluster_1088';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/IncR_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/IncR_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/rep_cluster_1088_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncR__rep_cluster_1088/rep_cluster_1088_all_aligned.fasta
fi

echo 'Concatenating IncFIC__IncU IncFIC'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/*IncFIC.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncFIC_all.fa || true
echo 'Concatenating IncFIC__IncU IncU'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/*IncU.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncU_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for IncFIC__IncU IncFIC'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncFIC_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncFIC_all_aligned.fasta
  echo 'Running muscle for IncFIC__IncU IncU'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncU_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncU_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for IncFIC__IncU';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncFIC_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncFIC_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncU_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/IncFIC__IncU/IncU_all_aligned.fasta
fi

echo 'Concatenating rep_cluster_1974__rep_cluster_43 rep_cluster_1974'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/*rep_cluster_1974.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_1974_all.fa || true
echo 'Concatenating rep_cluster_1974__rep_cluster_43 rep_cluster_43'; cat /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/*rep_cluster_43.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_43_all.fa || true
if command -v muscle >/dev/null 2>&1; then
  echo 'Running muscle for rep_cluster_1974__rep_cluster_43 rep_cluster_1974'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_1974_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_1974_all_aligned.fasta
  echo 'Running muscle for rep_cluster_1974__rep_cluster_43 rep_cluster_43'; muscle -align /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_43_all.fa -output /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_43_all_aligned.fasta
else
  echo 'muscle not found, using mafft --auto for rep_cluster_1974__rep_cluster_43';
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_1974_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_1974_all_aligned.fasta
  mafft --auto --thread 8 /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_43_all.fa > /home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/letsshowmultirepps/treesreplicons/rep_cluster_1974__rep_cluster_43/rep_cluster_43_all_aligned.fasta
fi
