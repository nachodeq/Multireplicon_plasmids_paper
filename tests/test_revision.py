"""Small public synthetic fixtures for the revision's scientific contracts."""
import importlib.util
from pathlib import Path
import sys
import unittest
import tempfile
import pandas as pd
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'scripts/shared'))
from revision_utils import annotate_windows,covered_segments,intervals_overlap,correct_pair_regions,join_mobility

def module(name,relative):
 spec=importlib.util.spec_from_file_location(name,ROOT/relative);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m

class RevisionTests(unittest.TestCase):
 def test_circular_intervals(self):
  self.assertEqual(covered_segments(98,100,1,5,10),[(98,100),(1,2)])
  self.assertFalse(intervals_overlap([(1,5)],[(6,9)]))
  self.assertTrue(intervals_overlap([(98,100),(1,2)],[(2,4)]))
  with self.assertRaises(ValueError):covered_segments(1,100,1,11,10)
 def test_short_explicit_window(self):
  data=pd.DataFrame([dict(pair_id=1,plasmid='P',bp_kind='start',breakpoint_pos=2,plasmid_len=3,window_hw=2,window_start_genome=3,window_length=4)])
  self.assertEqual(annotate_windows(data).window_length.iloc[0],4)
  self.assertEqual(covered_segments(3,3,1,4,4),[(1,3)])
 def test_explicit_or_fail(self):
  base=pd.DataFrame([dict(pair_id=1,plasmid='P',bp_kind='start',breakpoint_pos=2,plasmid_len=100,window_hw=5)])
  with self.assertRaises(ValueError):annotate_windows(base)
  self.assertEqual(annotate_windows(base,'legacy-inclusive').window_start_genome.iloc[0],98)
  self.assertEqual(annotate_windows(base,'exact-2hw').window_start_genome.iloc[0],97)
 def test_overlap_same_or_different(self):
  master=pd.DataFrame([dict(pair_id=1,plasmid='P',bp_kind=k,breakpoint_pos=50,plasmid_len=100,window_hw=5,window_start_genome=45,window_length=10) for k in ['start','end']])
  for cls in ['2 IS (same)','2 IS (different)']:
   pairs=pd.DataFrame([dict(pair_id=1,plasmid='P',IS_class=cls,start_is_start_window=1,start_is_end_window=5,end_is_start_window=5,end_is_end_window=8)])
   corrected=correct_pair_regions(pairs,master)
   self.assertEqual(corrected.IS_class.iloc[0],'1 IS');self.assertEqual(corrected.IS_class_raw.iloc[0],cls)
 def test_mobility_rules_and_thresholds(self):
  m=module('independent','scripts/02_mobility_host_range/02g_independent_mobility.py')
  self.assertEqual(m.classify(True,True,False),'pCONJ')
  self.assertEqual(m.classify(False,True,False),'pMOB')
  self.assertEqual(m.classify(False,False,True),'pOriT')
  self.assertEqual(m.classify(False,False,False),'pNT')
  hit=dict(evalue=.009,pident=81,qstart=1,qend=81,qlen=100)
  self.assertTrue(m.accepted(hit));hit['pident']=80;self.assertFalse(m.accepted(hit))
 def test_native_protein_roles_and_deduplication(self):
  m=module('native_roles','scripts/02_mobility_host_range/02g_independent_mobility.py')
  with tempfile.TemporaryDirectory() as directory:
   root=Path(directory);m.ROOT=root/'out';m.NATIVE=root/'native';m.MODELS=root/'models'
   for path in [m.ROOT/'inputs',m.ROOT/'outputs',m.MODELS]:path.mkdir(parents=True)
   names=['T4SS_MOB_x','T4SS_t4cp_x','T4SS_struct1','T4SS_struct2']
   (m.MODELS/'T4SS_typeX.xml').write_text('<model>'+''.join('<gene name="'+name+'"/>' for name in names)+'</model>')
   hmmer=m.NATIVE/'conjscan_per_plasmid/P/hmmer_results';hmmer.mkdir(parents=True)
   for name in names:
    protein='relax' if name=='T4SS_MOB_x' else 'cp' if name=='T4SS_t4cp_x' else 'structural'
    columns=[protein,'x','x','x',name,'x','x','x','x','x','x']
    (hmmer/(name+'.res_hmm_extract')).write_text('\t'.join(columns)+'\n')
   rows=m.proteins([dict(plasmid_id='P',replicon_status='Single-replicon',n_T4SS_typeX=0)])
   self.assertEqual(rows[0]['n_relaxase_proteins'],1)
   self.assertEqual(rows[0]['n_MPF_proteins'],1)
   self.assertEqual(rows[0]['n_T4CP_proteins'],1)
   self.assertEqual(rows[0]['pdCONJ'],0)
 def test_safe_join(self):
  a=pd.DataFrame({'plasmid_id':['NZ_A'],'old':['unchanged']})
  b=pd.DataFrame({'plasmid_id':['A'],'functional_category':['pCONJ']})
  joined,audit=join_mobility(a,b);self.assertEqual(joined.old.iloc[0],'unchanged');self.assertEqual(joined.predicted_mobility_model.iloc[0],'pCONJ')
  with self.assertRaises(ValueError):join_mobility(a,pd.concat([b,b]))
  with self.assertRaises(ValueError):join_mobility(a,b.assign(plasmid_id='B'))
if __name__=='__main__':unittest.main()
