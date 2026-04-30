import pandas as pd
import os

# Ruta de la tabla con plásmidos y replicones
tabla_path = '/home/nacho/HDD16/Nacho/RepliCOOC/derep/louvain_by_level_from_table_including_isolates/representatives_by_cluster_level.tsv'

# Carpeta donde están los archivos fasta individuales de cada plásmido
fasta_dir = '/home/nacho/HDD16/Nacho/RepliCOOC/data/raw/fasta'

# Archivo donde guardaremos la lista de rutas
output_list_path = './multi_replicon_fasta_paths.txt'

# Leer tabla y filtrar plásmidos con >1 replicon
df = pd.read_csv(tabla_path, sep='\t')
multi_replicon = df[df['level'] > 1]

# Obtener lista de contigs
contigs = multi_replicon['representative'].tolist()

# Generar rutas completas asumiendo que el nombre del archivo es contig + '.fasta'
with open(output_list_path, 'w') as f:
    for contig in contigs:
        path = os.path.join(fasta_dir, contig + '.fasta')
        f.write(path + '\n')

print(f'Lista de rutas de archivos fasta guardada en {output_list_path}')

