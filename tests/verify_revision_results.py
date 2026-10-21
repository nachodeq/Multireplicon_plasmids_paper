#!/usr/bin/env python3
"""Optional production regression check from explicitly supplied local cached inputs."""
import argparse,importlib.util,json,subprocess,sys,tempfile
from pathlib import Path
import numpy as np
import pandas as pd
ROOT=Path(__file__).resolve().parents[1]

def run(script,*args):subprocess.run([sys.executable,str(ROOT/script),*map(str,args)],check=True)
def load(relative):
 spec=importlib.util.spec_from_file_location('digis',ROOT/relative);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m

def historical_master(path,random=False):
 master=pd.read_csv(path,sep='\t').copy()
 if random:master['breakpoint_pos']=master.random_center
 master['window_hw']=2000
 start=master.breakpoint_pos-2000
 master['window_start_genome']=(start-1+(start<1).astype(int))%master.plasmid_len+1
 if 'fasta_path' not in master:raise ValueError('Historical regression requires actual FASTA paths to verify lengths')
 def size(path):
  with open(path) as handle:return sum(len(line.strip()) for line in handle if not line.startswith('>'))
 master['window_length']=master.fasta_path.map(size)
 # Preserve historical best-hit ranking. Genomic correction uses actual origins above.
 master['breakpoint_window_position']=2001
 return master

def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--gene-model-data',required=True)
 p.add_argument('--mobility-analysis',required=True,help='Existing independent analysis directory with outputs/ and inputs/')
 p.add_argument('--v3',required=True,help='Existing historical junction output directory')
 a=p.parse_args();mob=Path(a.mobility_analysis);v3=Path(a.v3)
 with tempfile.TemporaryDirectory(prefix='revision-results-') as directory:
  out=Path(directory)
  run('scripts/02_mobility_host_range/02g_independent_mobility.py','--outdir',out/'mob','--protein-summary',mob/'outputs/protein_summary.tsv','--orit-blast',mob/'outputs/blast_standard.tsv','--reference-aliases',mob/'inputs/reference_aliases.tsv')
  summary=out/'mob/outputs/plasmid_summary.tsv';calls=pd.read_csv(summary,sep='\t')
  assert calls.functional_category.value_counts().to_dict()=={'pCONJ':7864,'pNT':7836,'pMOB':5952,'pOriT':2273}
  run('scripts/01_abundance_size_content/01b_source_adjusted_glm.py','--model-data',a.gene_model_data,'--mobility-table',summary,'--outdir',out/'genes')
  run('scripts/02_mobility_host_range/02h_independent_mobility_glm.py','--model-data',a.gene_model_data,'--mobility-table',summary,'--outdir',out/'mob_models')
  genes=pd.read_csv(out/'genes/all_GLM_source_adjusted_results_full.tsv',sep='\t')
  genes=genes[genes.model.eq('M3_length_mobility_genus_source')&genes.term.eq('multireplicon_status')]
  np.testing.assert_allclose(genes.set_index('outcome').OR.loc[['AMR_presence','metal_biocide_presence','virulence_presence']],[1.775360,1.765137,4.403767],rtol=1e-6)
  categories=pd.read_csv(out/'mob_models/primary_M3_results.tsv',sep='\t').set_index('outcome')
  fixture=json.loads((ROOT/'tests/fixtures/revision_metrics.json').read_text())
  for table in [genes.set_index('outcome'),categories]:
   for outcome,row in table.iterrows():
    np.testing.assert_allclose(row[['OR','CI_low','CI_high','p_value']].astype(float),[fixture[outcome][key] for key in ['OR','CI_low','CI_high','p_value']],rtol=1e-6,atol=0)
  np.testing.assert_allclose(categories.OR.loc[['pCONJ','pMOB','pOriT','pNT']],[1.2200489457082375,1.1347006968939954,2.1055271885622657,.49695543121073216],rtol=1e-6)
  digis=load('scripts/05_fusion_breakpoints/05d_summarize_digis_is_architecture.py')
  trace=v3/'TRACEABLE_hardcut_95pid_2000_onebest_per_pair'
  for name,master,csv,expected in [
   ('real',historical_master(trace/'breakpoints_master.tsv'),trace/'digis_output/results/breakpoints_windows.csv',[495,661,374,87]),
   ('random',historical_master(trace/'random_control_two_random_points_hw2000/random_windows_master.tsv',True),trace/'random_control_two_random_points_hw2000/digis_output/results/random_windows.csv',[721,641,55,200])]:
   path=out/f'{name}_master.tsv';master.to_csv(path,sep='\t',index=False)
   _,_,pairs=digis.build_pair_classification(path,csv,name)
   assert pairs.IS_class.value_counts().reindex(digis.CLASS_ORDER,fill_value=0).tolist()==expected
   if name=='real':
    same=pairs[pairs.IS_class.eq('2 IS (same)')]
    assert same.start_is_name_norm.eq('IS6').sum()==345
    assert same.IS_orientation.value_counts().to_dict()=={'repeat/direct':204,'inverted':170}
   print(name,expected)
 print('PASS: cached evidence rebuilt independent categories, seven focal ORs, corrected real/control IS classes, IS6 and orientation. No new sequence search.')
if __name__=='__main__':main()
