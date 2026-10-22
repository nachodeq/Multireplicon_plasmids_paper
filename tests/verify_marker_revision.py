#!/usr/bin/env python3
"""Compare the portable marker/flank code to explicitly supplied completed local evidence."""
import argparse,hashlib,json,sys
from pathlib import Path
from types import SimpleNamespace
import numpy as np,pandas as pd
from Bio import SeqIO
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'scripts/shared'))
from replicon_markers import native_functions,final_markers,extract_sequence,context_caps

def segments(start,length,L):
 start%=L
 return {(start+i)%L for i in range(length)}

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--markers',type=Path,required=True);p.add_argument('--geometry',type=Path,required=True);p.add_argument('--mobtyper-dir',type=Path,required=True);p.add_argument('--mob-suite-utils',type=Path,required=True);p.add_argument('--limit',type=int,default=500);a=p.parse_args()
 markers=pd.read_csv(a.markers,sep='\t');ids=sorted(markers.plasmid.unique());ids=[ids[i] for i in np.linspace(0,len(ids)-1,min(a.limit,len(ids)),dtype=int)];native=native_functions(str(a.mob_suite_utils));total=0
 for acc,g in markers[markers.plasmid.isin(ids)].groupby('plasmid'):
  assignments,chosen=final_markers(a.mobtyper_dir,acc,native);genome=str(SeqIO.read(g.iloc[0].genome_path,'fasta').seq)
  assert set(assignments)==set(g.type)
  for r in g.itertuples():
   h=chosen[r.type];assert (assignments[r.type],h.qseqid,int(h.sstart),int(h.send),h.sstrand)==(r.reference_accession,r.query,r.start,r.end,r.strand)
   assert hashlib.sha256(extract_sequence(genome,h).encode()).hexdigest()==r.sequence_sha256;total+=1
 geometry=pd.read_csv(a.geometry,sep='\t')
 for r in geometry.itertuples():
  aa=SimpleNamespace(sstart=r.hitA_start,send=r.hitA_end);bb=SimpleNamespace(sstart=r.hitB_start,send=r.hitB_end);caps=context_caps(aa,bb,r.plasmid_length,r.flank_bp_each_side);assert caps==(r.leftA,r.rightA,r.leftB,r.rightB)
  # Independent arc intersection using half-open segments, not the cap implementation.
  def arcs(start,n,L):
   start%=L
   return [(start,min(L,start+n))]+([(0,start+n-L)] if start+n>L else [])
  def intersect(a,b):return sum(max(0,min(y,v)-max(x,u)) for x,y in a for u,v in b)
  a_arcs=arcs(r.hitA_start-1-r.leftA,r.leftA,r.plasmid_length)+arcs(r.hitA_end,r.rightA,r.plasmid_length);b_arcs=arcs(r.hitB_start-1-r.leftB,r.leftB,r.plasmid_length)+arcs(r.hitB_end,r.rightB,r.plasmid_length);genes=[(r.hitA_start-1,r.hitA_end),(r.hitB_start-1,r.hitB_end)]
  assert intersect(a_arcs,b_arcs)==intersect(a_arcs,genes)==intersect(b_arcs,genes)==0
 print(json.dumps(dict(status='PASS',plasmids=len(ids),markers_replayed_and_DNA_verified=total,geometric_records_verified=len(geometry),native_source_sha256=hashlib.sha256(a.mob_suite_utils.read_bytes()).hexdigest())))
if __name__=='__main__':main()
