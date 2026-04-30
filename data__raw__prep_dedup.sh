# Nueva lista solo con FASTA válidos (al menos una cabecera '>'):
cd /home/nacho/HDD16/Nacho/RepliCOOC/data/raw/fasta/prodigal_results

ls *.faa | sort > faa_nonempty.list

# Sketch único en AA (-a), k=9 y s=2000
mash sketch -a -k 9 -s 2000 -o plasmids_aa -l faa_nonempty.list

# Distancias all-vs-all
mash dist -p 8 plasmids_aa.msh plasmids_aa.msh > mash_dist.tsv

# Containment all-vs-all (para detectar A ⊂ AB)
mash screen plasmids_aa.msh plasmids_aa.msh > screen_all.tsv

