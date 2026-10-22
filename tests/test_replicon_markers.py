import importlib.util,os,sys,tempfile,unittest
from pathlib import Path
from types import SimpleNamespace
import numpy as np,pandas as pd
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'scripts/shared'))
from replicon_markers import assigned_references,select_marker,extract_sequence,context_caps,annotation_overlap
class RepliconMarkerTests(unittest.TestCase):
 def test_accession_and_type_are_both_exact(self):
  d=pd.DataFrame([dict(qseqid='AP001918|IncFIB',bitscore=100,sstart=1,send=9,qstart=1,qend=9,sstrand='plus'),dict(qseqid='AP001918|IncFIC',bitscore=50,sstart=20,send=29,qstart=1,qend=10,sstrand='plus')]);self.assertEqual(select_marker(d,'IncFIC','AP001918').sstart,20)
  with self.assertRaises(ValueError):select_marker(d,'IncFIC','AP00191')
 def test_distinct_type_uses_first_assigned_reference(self):
  self.assertEqual(assigned_references({'rep_type(s)':'A,A,B','rep_type_accession(s)':'first,last,other'}),{'A':'first','B':'other'})
 def test_pair_identifier_matches_corrected_original_sanitizer(self):
  from replicon_markers import normalized_type
  self.assertEqual(normalized_type('IncI-gamma/K1'),'IncI_gamma_K1')
 def test_reverse_strand_inclusive(self):
  self.assertEqual(extract_sequence('AACCGGTT',SimpleNamespace(sstart=2,send=5,sstrand='minus')),'CGGT')
 def test_positive_overlap_excludes_even_native_allowed_residual(self):
  a=SimpleNamespace(sstart=10,send=30);b=SimpleNamespace(sstart=28,send=45);self.assertEqual(annotation_overlap(a,b),3)
  with self.assertRaises(ValueError):context_caps(a,b,100,10)
 def test_circular_midpoint_clips_both_contexts(self):
  a=SimpleNamespace(sstart=2,send=10);b=SimpleNamespace(sstart=80,send=90);self.assertEqual(context_caps(a,b,100,50),(5,34,34,5))

class NativeMarkerTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  from replicon_markers import native_functions
  path=os.environ.get('MOB_SUITE_UTILS')
  if not path:raise unittest.SkipTest('Optional native replay: set MOB_SUITE_UTILS to validated MOB-suite3.1.9 utils.py')
  cls.path=path;cls.native=native_functions(path)
 def row(self,query,start,end,score,qstart=1,qend=None,qlen=200,slen=1000):
  return dict(qseqid=query,sseqid='plasmid',qlen=qlen,slen=slen,qstart=qstart,qend=qend or qstart+end-start,sstart=start,send=end,length=end-start+1,mismatch=0,pident=100.,qcovhsp=80.,qcovs=100.,sstrand='plus',evalue=1e-30,bitscore=score)
 def test_native_discarded_boundary_high_score_not_reintroduced(self):
  from replicon_markers import retained_rows
  raw=pd.DataFrame([self.row('REF|A',1,80,200,qend=80),self.row('REF|A',900,1000,300,qstart=81,qend=181)])
  hit=select_marker(retained_rows(raw,self.native),'A','REF');self.assertEqual((hit.sstart,hit.bitscore),(1,200))
 def test_native_residual_and_accession_key_collapse(self):
  from replicon_markers import retained_rows
  raw=pd.DataFrame([self.row('ONE|A',100,179,300),self.row('TWO|B',177,256,200)])
  kept=retained_rows(raw,self.native);self.assertEqual(len(kept),2);self.assertEqual(annotation_overlap(kept.iloc[0],kept.iloc[1]),3)
  raw=pd.DataFrame([self.row('SHARED|A',100,179,300),self.row('SHARED|B',500,579,200)])
  self.assertEqual(list(retained_rows(raw,self.native).qseqid),['SHARED|B'])
 def test_cli_extraction_and_spacing_use_same_native_coordinates(self):
  import subprocess
  with tempfile.TemporaryDirectory() as directory:
   root=Path(directory);mob=root/'mob';dna=root/'dna';mob.mkdir();dna.mkdir()
   for acc in ['P1.1','P2.1']:
    (mob/(acc+'_analysis')).mkdir();pd.DataFrame([dict(sample_id=acc,**{'rep_type(s)':'A,A,B','rep_type_accession(s)':'R1,ALT,R2'})]).to_csv(mob/(acc+'_summary.txt'),sep='\t',index=False)
    pd.DataFrame([self.row('R1|A',50,79,100),self.row('ALT|A',300,329,110),self.row('R2|B',200,229,100)]).to_csv(mob/(acc+'_analysis')/'replicon_blast_results.txt',sep='\t',index=False)
    (dna/(acc+'.fasta')).write_text('>'+acc+'\n'+'ACGT'*250+'\n')
   reps=root/'reps.tsv';pd.DataFrame({'representative':['P1.1','P2.1']}).to_csv(reps,sep='\t',index=False)
   run=subprocess.run([sys.executable,str(ROOT/'scripts/04_coevolution_distance_analysis/04a_prepare_align_multireplicon_replicons.py'),'--mobtyper-dir',str(mob),'--fasta-dir',str(dna),'--derep-representatives',str(reps),'--outdir',str(root/'out'),'--mob-suite-utils',self.path,'--min-count','2','--skip-align'],capture_output=True,text=True)
   self.assertEqual(run.returncode,0,run.stdout+run.stderr);table=pd.read_csv(root/'out/multireplicon_extraction_summary.tsv',sep='\t');self.assertEqual(len(table),4);self.assertEqual(set(table.qseqid),{'R1|A','R2|B'});self.assertEqual(set(table.plasmid_length),{1000})
   spec=importlib.util.spec_from_file_location('spacing_markers',ROOT/'scripts/04_coevolution_distance_analysis/04_section4_spacing_coevolution_analysis.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
   spacing=module.compute_replicon_distances_from_mobtyper(mob,None,fasta_dir=dna,mob_suite_utils=Path(self.path));self.assertEqual(len(spacing),2);self.assertTrue(spacing.distance_absolute.eq(150).all())

 def test_separate_control_cli_resolves_exact_cached_reference(self):
  import subprocess
  with tempfile.TemporaryDirectory() as directory:
   root=Path(directory);mob=root/'mob';dna=root/'dna';mob.mkdir();dna.mkdir()
   for acc,typ,ref,start in [('C1.1','A','R1',50),('C2.1','B','R2',200)]:
    (mob/(acc+'_analysis')).mkdir();pd.DataFrame([{'rep_type(s)':typ,'rep_type_accession(s)':ref}]).to_csv(mob/(acc+'_summary.txt'),sep='\t',index=False);pd.DataFrame([self.row(ref+'|'+typ,start,start+29,100)]).to_csv(mob/(acc+'_analysis')/'replicon_blast_results.txt',sep='\t',index=False);(dna/(acc+'.fasta')).write_text('>'+acc+'\n'+'ACGT'*250+'\n')
   pd.DataFrame({'NUCCORE_UID':['1','2'],'NUCCORE_ACC':['C1.1','C2.1']}).to_csv(root/'nuccore.csv',index=False);pd.DataFrame({'ASSEMBLY_ACC':['ASM'],'NUCCORE_UID':['[1,2]']}).to_csv(root/'assembly.csv',index=False);pd.DataFrame({'NUCCORE_ACC':['C1.1','C2.1'],'rep_type(s)':['A','B']}).to_csv(root/'typing.csv',index=False);pd.DataFrame({'repA':['A'],'repB':['B']}).to_csv(root/'mantel.tsv',sep='\t',index=False)
   cmd=[sys.executable,str(ROOT/'scripts/04_coevolution_distance_analysis/04b_prepare_align_separate_plasmid_controls.py'),'--nuccore',str(root/'nuccore.csv'),'--assembly',str(root/'assembly.csv'),'--typing',str(root/'typing.csv'),'--mantel-results',str(root/'mantel.tsv'),'--mobtyper-dir',str(mob),'--fasta-dir',str(dna),'--outdir',str(root/'out'),'--mob-suite-utils',self.path,'--skip-align'];run=subprocess.run(cmd,capture_output=True,text=True);self.assertEqual(run.returncode,0,run.stdout+run.stderr)
   df=pd.read_csv(root/'out/control_extraction_summary.tsv',sep='\t');self.assertEqual(set(df.source_plasmid),{'C1.1','C2.1'});self.assertEqual(set(df.qseqid),{'R1|A','R2|B'});self.assertTrue(df.status.eq('ok').all())

class FlankMarkerTests(unittest.TestCase):
 def test_parser_ignores_concatenates_and_geometry_is_disjoint(self):
  spec=importlib.util.spec_from_file_location('flanks_markers',ROOT/'scripts/04_coevolution_distance_analysis/04e_run_flanking_context_mantel.py');m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
  with tempfile.TemporaryDirectory() as d:
   p=Path(d);header='>P|A|qseqid:R|A|sstart:2|send:10|sstrand:minus\n'
   (p/'P__A.fa').write_text(header+'ACGT\n');(p/'A_all.fa').write_text(header+'ACGT\n'+header+'ACGT\n');self.assertEqual(len(m.parse_pair_dir(p)),1)
  seq='ACGT'*25;a=m.RepHit('P','A',2,10,'minus','');b=m.RepHit('P','B',80,90,'plus','');la,ra,lb,rb=context_caps(a,b,len(seq),50)
  ca,_=m.extract_context(seq,a,50,la,ra);cb,_=m.extract_context(seq,b,50,lb,rb);self.assertEqual(len(ca),39);self.assertEqual(len(cb),39)
  def positions(hit,left,right):return {(min(hit.sstart,hit.send)-1-left+i)%len(seq) for i in range(left)}|{(max(hit.sstart,hit.send)+i)%len(seq) for i in range(right)}
  aa=positions(a,la,ra);bb=positions(b,lb,rb);genes=set(range(1,10))|set(range(79,90));self.assertFalse(aa&bb);self.assertFalse((aa|bb)&genes)
 def test_whole_pair_excluded_for_one_overlapping_plasmid(self):
  import subprocess
  with tempfile.TemporaryDirectory() as directory:
   root=Path(directory);trees=root/'trees/A__B';trees.mkdir(parents=True);dna=root/'dna';dna.mkdir()
   for i in range(5):
    acc=f'P{i}';(dna/(acc+'.fasta')).write_text('>'+acc+'\n'+'ACGT'*100+'\n')
    for rep,start,end in [('A',10,30),('B',28 if i==0 else 100,48 if i==0 else 120)]:
     (trees/(acc+'__'+rep+'.fa')).write_text(f'>{acc}|{rep}|qseqid:R|{rep}|sstart:{start}|send:{end}|sstrand:plus\nACGT\n')
   pd.DataFrame([dict(pair='A__B',n_taxa=5,mantel_r=.5,mantel_p=.01)]).to_csv(root/'mantel.tsv',sep='\t',index=False)
   run=subprocess.run([sys.executable,str(ROOT/'scripts/04_coevolution_distance_analysis/04e_run_flanking_context_mantel.py'),'--mantel-results',str(root/'mantel.tsv'),'--trees-dir',str(root/'trees'),'--fasta-dir',str(dna),'--outdir',str(root/'out')],capture_output=True,text=True)
   self.assertEqual(run.returncode,0,run.stdout+run.stderr);skip=pd.read_csv(root/'out/tables/context_mantel_skips.tsv',sep='\t');self.assertEqual(skip.reason.iloc[0],'positive_annotation_overlap_in_frozen_sample');self.assertEqual(skip.n_overlapping.iloc[0],1)
