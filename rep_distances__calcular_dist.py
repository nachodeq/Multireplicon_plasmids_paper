import os
import pandas as pd
from glob import glob

mobtyper_base_dir = '/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/mobtyper'
plasmid_replicons_path = '/home/nacho/HDD16/Nacho/RepliCOOC/data/plasmid_replicons.tsv'

plasmid_replicons_df = pd.read_csv(plasmid_replicons_path, sep='\t', dtype=str)
plasmid_replicons_df['size_bp'] = pd.to_numeric(plasmid_replicons_df['size_bp'], errors='coerce').fillna(0).astype(int)

MIN_DIST = 10  # mínimo de pares de bases

def process_plasmid_assignments(plasmid_id):
    analysis_folder = os.path.join(mobtyper_base_dir, f'{plasmid_id}_analysis')
    blast_file = os.path.join(analysis_folder, 'replicon_blast_results.txt')
    summary_file = os.path.join(mobtyper_base_dir, f'{plasmid_id}_summary.txt')

    if not os.path.isfile(blast_file):
        print(f'[WARN] No se encontró {blast_file} para {plasmid_id}')
        return None
    if not os.path.isfile(summary_file):
        print(f'[WARN] No se encontró {summary_file} para {plasmid_id}')
        return None

    df_summary = pd.read_csv(summary_file, sep='\t')
    rep_types_entry = df_summary.loc[df_summary['sample_id'] == plasmid_id, 'rep_type(s)']
    rep_accessions_entry = df_summary.loc[df_summary['sample_id'] == plasmid_id, 'rep_type_accession(s)']

    if rep_types_entry.empty or rep_accessions_entry.empty:
        print(f'[WARN] replicones o accesiones faltantes en Summary para {plasmid_id}')
        return None

    rep_types_list = [r.strip() for r in str(rep_types_entry.values[0]).split(',') if r.strip()]
    rep_accessions_list = [r.strip() for r in str(rep_accessions_entry.values[0]).split(',') if r.strip()]
    if len(rep_types_list) < 2 or len(rep_accessions_list) < 2:
        return None
    if len(rep_types_list) != len(rep_accessions_list):
        print(f"[WARN] Rep type and accession length mismatch in {plasmid_id}")
        return None

    cols = ['qseqid','sseqid','qlen','slen','qstart','qend','sstart','send','length',
            'mismatch','pident','qcovhsp','qcovs','sstrand','evalue','bitscore']
    df_blast = pd.read_csv(blast_file, sep='\t', names=cols, header=0)

    replicon_positions = []
    assigned_positions = []

    for rtype, racc in zip(rep_types_list, rep_accessions_list):
        rep_hits = df_blast[df_blast['qseqid'].str.contains(racc, regex=False)]
        rep_hits_sorted = rep_hits.sort_values(by='bitscore', ascending=False)
        assigned = False

        for idx, hit in rep_hits_sorted.iterrows():
            pos = hit['sstart']
            slen = hit['slen']

            # Comprobar mínima distancia respecto a posiciones ya asignadas
            too_close = False
            for prev in assigned_positions:
                ref_len = slen
                dist = min(abs(pos - prev), ref_len - abs(pos - prev))
                if dist < MIN_DIST:
                    too_close = True
                    break
            if not too_close:
                replicon_positions.append({
                    'replicon': rtype,
                    'accession': racc,
                    'sstart': pos,
                    'slen': slen
                })
                assigned_positions.append(pos)
                assigned = True
                break

        if not assigned and not rep_hits_sorted.empty:
            # Si no hay hits suficientemente lejos, asignar el mejor (esto puede provocar duplicados si no hay alternativa)
            hit = rep_hits_sorted.iloc[0]
            replicon_positions.append({
                'replicon': rtype,
                'accession': racc,
                'sstart': hit['sstart'],
                'slen': hit['slen']
            })
            assigned_positions.append(hit['sstart'])

    if len(replicon_positions) < 2:
        return None

    results = []
    for i in range(len(replicon_positions)):
        for j in range(i+1, len(replicon_positions)):
            r1 = replicon_positions[i]
            r2 = replicon_positions[j]
            pos1 = r1['sstart']
            pos2 = r2['sstart']
            plasmid_len = r1['slen']
            diff = abs(pos2 - pos1)
            dist_abs = min(diff, plasmid_len - diff)
            dist_rel = dist_abs / plasmid_len if plasmid_len > 0 else np.nan
            results.append({
                'plasmid_id': plasmid_id,
                'replicon_1': r1['replicon'],
                'replicon_2': r2['replicon'],
                'pos_1': pos1,
                'pos_2': pos2,
                'plasmid_length': plasmid_len,
                'distance_absolute': dist_abs,
                'distance_relative': dist_rel
            })
    return results

folders = glob(os.path.join(mobtyper_base_dir, '*_analysis'))
plasmid_ids = [os.path.basename(f).replace('_analysis', '') for f in folders]

all_results = []
for pid in plasmid_ids:
    res = process_plasmid_assignments(pid)
    if res:
        all_results.extend(res)

if all_results:
    df_results = pd.DataFrame(all_results)
    output_path = '/home/nacho/HDD16/Nacho/RepliCOOC/rep_distances/replicon_distances.tsv'
    df_results.to_csv(output_path, sep='\t', index=False)
    print(f'Resultados guardados en {output_path}')
else:
    print('No se encontraron resultados para guardar.')

