#!/usr/bin/env python3
"""Independent OriTDB + native CONJScan analysis; no MOB-suite inputs."""
import argparse, collections, csv, hashlib, json, shutil, subprocess, time, xml.etree.ElementTree as ET
from pathlib import Path
ROOT=None
NATIVE=None
MODELS=None
TABLE=None
BIN=None
ORIT_REFERENCE=None
def sha(path):
 h=hashlib.sha256()
 with open(path,'rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
 return h.hexdigest()
def fasta(path):
 name=None; parts=[]
 with open(path) as f:
  for line in f:
   if line.startswith('>'):
    if name is not None: yield name,''.join(parts).upper()
    name=line[1:].strip(); parts=[]
   else: parts.append(line.strip())
 if name is not None: yield name,''.join(parts).upper()
def normalize(x): return x.removeprefix('NZ_')
def unique_normalized(names):
 d={}
 for n in names:
  k=normalize(n)
  if k in d: raise ValueError('Normalized identifier collision: '+n)
  d[k]=n
 return d
def write_tsv(path,rows,fields=None):
 rows=list(rows)
 with open(path,'w') as f:
  w=csv.DictWriter(f,fieldnames=fields or list(rows[0]),delimiter='\t'); w.writeheader(); w.writerows(rows)
def read_tsv(path):
 with open(path) as f:return list(csv.DictReader(f,delimiter='\t'))
def classify(complete,relax,orit):
 return 'pCONJ' if complete and relax else 'pMOB' if relax else 'pOriT' if orit else 'pNT'
def pdconj(complete,proteins):return not complete and len(set(proteins))>=2
def accepted(h,special=False):
 if special:return h['qlen']==13 and h['qstart']==1 and h['qend']==13 and h['length']==13 and h['gapopen']==0 and h['mismatch']<=1
 return h['evalue']<0.01 and h['pident']>80 and 100*(h['qend']-h['qstart']+1)/h['qlen']>80
FIELDS='qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen'.split()
def blast_rows(path):
 with open(path) as f:
  for line in f:
   r=dict(zip(FIELDS,line.rstrip().split('\t')))
   for k in FIELDS[2:]:r[k]=float(r[k]) if k in ('pident','evalue','bitscore') else int(r[k])
   r['start'],r['end']=sorted((r['sstart'],r['send']));yield r
def best_overlap(hits):
 # Greedy best-first: rejected overlaps cannot erase a better accepted hit.
 kept=[]
 for h in sorted(hits,key=lambda h:(h['evalue'],-h['bitscore'],-h['pident'],-h['length'],h['qseqid'],h['start'],h['end'])):
  if not any(h['start']<=k['end'] and k['start']<=h['end'] for k in kept):kept.append(h)
 return sorted(kept,key=lambda h:(h['start'],h['end'],h['qseqid']))
def run(cmd):
 t=time.monotonic();p=subprocess.run([str(x) for x in cmd],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
 entry={'command':[str(x) for x in cmd],'exit_code':p.returncode,'wall_seconds':round(time.monotonic()-t,3),'stdout':p.stdout,'stderr':p.stderr}
 with open(ROOT/'logs/commands.jsonl','a') as f:f.write(json.dumps(entry)+'\n')
 if p.returncode:raise RuntimeError(entry)
 return p.stdout

def prepare():
 source=ORIT_REFERENCE; dest=ROOT/'inputs/oritdb_experimental_original.fasta'
 if dest.exists() and sha(dest)!=sha(source):raise ValueError("Different OriTDB reference already cached; use a fresh output directory")
 if not dest.exists():dest.write_bytes(source.read_bytes())
 refs=collections.OrderedDict()
 for header,seq in fasta(dest):
  if not seq or set(seq)-set('ACGTN'):raise ValueError('Invalid reference '+header)
  refs.setdefault(seq,[]).append(header)
 aliases=[];special=[]
 with open(ROOT/'inputs/oritdb_unique.fasta','w') as out,open(ROOT/'inputs/oritdb_13nt_special.fasta','w') as short:
  for i,(seq,names) in enumerate(refs.items(),1):
   q=f'oriT_{i:03}';out.write(f'>{q}\n{seq}\n')
   is_special=len(seq)==13 and any('clodf13' in n.lower() or 'pad1 ' in n.lower() for n in names)
   if is_special:short.write(f'>{q}\n{seq}\n');special.append(q)
   aliases.append({'query_id':q,'length':len(seq),'ambiguous_N':seq.count('N'),'rocha_13nt_exception':int(is_special),'aliases':' | '.join(names),'sequence':seq})
 write_tsv(ROOT/'inputs/reference_aliases.tsv',aliases)
 metadata=read_tsv(TABLE); ids=unique_normalized([r['plasmid_id'] for r in metadata]); mapped={};manifest=[]
 paths=NATIVE.joinpath('input_fastas.txt').read_text().splitlines()
 with open(ROOT/'inputs/plasmids.fasta','w') as f:
  for path in paths:
   p=Path(path)
   if not p.is_file():raise FileNotFoundError(path)
   records=list(fasta(p))
   if len(records)!=1:raise ValueError('Expected one plasmid record '+path)
   header,seq=records[0]; original=header.split()[0];key=normalize(original)
   if key not in ids or key in mapped:raise ValueError('Missing or duplicate ID '+original)
   pid=ids[key];mapped[key]=pid;f.write(f'>{pid}\n{seq}\n')
   manifest.append({'plasmid_id':pid,'original_fasta_id':original,'path':path,'length':len(seq),'sha256':sha(p)})
 if set(mapped)!=set(ids):raise ValueError('Missing FASTA inputs')
 write_tsv(ROOT/'inputs/plasmid_manifest.tsv',manifest)
 return metadata,aliases,special

def model_roles(directory):
 names=set();groups=[]
 for p in sorted(directory.glob('T4SS*.xml')):
  tree=ET.parse(p)
  names.update(g.attrib['name'] for g in tree.iter('gene'))
  for gene in tree.getroot().findall('gene'):
   groups.append({g.attrib['name'] for g in gene.iter('gene')})
 mob={n for n in names if n.startswith('T4SS_MOB')}
 cp={n for n in names if n.startswith('T4SS_t4cp')}
 # Coupling protein names need not contain t4cp: propagate XML exchangeability.
 while True:
  extended=cp|set().union(*(group for group in groups if group&cp))
  if extended==cp:break
  cp=extended
 if mob&cp:raise ValueError('Overlapping relaxase/coupling profile roles')
 return names,mob,cp,names-mob-cp

def write_conflicts(details):
 # Include excluded structural-profile assignments too, although MPF field is zero.
 roles={r['profile']:r['role'] for r in read_tsv(ROOT/'inputs/profile_roles.tsv')}
 conflicts=[h for h in details if len({roles[p] for p in h['profiles'].split(',')})>1]
 write_tsv(ROOT/'outputs/cross_role_profile_conflicts.tsv',conflicts,['plasmid_id','protein_id','profiles','relaxase','MPF','T4CP'])

def validate_native_counts(path, models):
 """Fail before output creation if complete-system evidence is not specified."""
 expected={'n_'+p.stem for p in models.glob('T4SS_type*.xml')}
 if not expected:raise ValueError('No T4SS_type XML definitions found')
 with path.open(newline='') as handle:
  reader=csv.DictReader(handle,delimiter='\t');fields=reader.fieldnames or []
  if len(fields)!=len(set(fields)):raise ValueError('Duplicate native count columns')
  missing=({'plasmid_id','replicon_status'}|expected)-set(fields)
  if missing:raise ValueError('Missing native count columns: '+', '.join(sorted(missing)))
  rows=list(reader)
 if not rows:raise ValueError('Empty native model-count table')
 for row in rows:
  pid=row['plasmid_id']
  if not pid or pid!=pid.strip():raise ValueError('Missing or whitespace-padded plasmid_id')
  if row['replicon_status'] not in ('Single-replicon','Multi-replicon'):raise ValueError('Invalid replicon_status')
  for column in fields:
   if column.startswith('n_'):
    try:value=int(row[column])
    except (ValueError,TypeError):raise ValueError('Noninteger or missing native count: '+column) from None
    if value<0:raise ValueError('Negative native count: '+column)
 unique_normalized([row['plasmid_id'] for row in rows])
 return rows

def proteins(metadata):
 names,mob,cp,mpf=model_roles(MODELS)
 snapshot=ROOT/'inputs/native_model_xml';snapshot.mkdir(exist_ok=True)
 for p in MODELS.glob('*.xml'):shutil.copyfile(p,snapshot/p.name)
 write_tsv(ROOT/'inputs/profile_roles.tsv',[{'profile':n,'role':'relaxase' if n in mob else 'T4CP' if n in cp else 'MPF'} for n in sorted(names)])
 models=[{'path':str(p),'sha256':sha(p)} for p in sorted(MODELS.glob('*.xml'))]
 write_tsv(ROOT/'inputs/model_manifest.tsv',models)
 rows=[];details=[];extractions=[]
 for i,r in enumerate(metadata):
  pid=r['plasmid_id'];directory=NATIVE/'conjscan_per_plasmid'/pid/'hmmer_results'
  if not directory.is_dir():raise FileNotFoundError(directory)
  files={p.name.removesuffix('.res_hmm_extract'):p for p in directory.glob('*.res_hmm_extract')}
  if not names<=files.keys():raise ValueError('Missing extracted profiles '+pid+': '+str(names-files.keys()))
  hits=collections.defaultdict(set); digest=hashlib.sha256()
  for name,p in sorted(files.items()):
   if name not in names:continue
   b=p.read_bytes();digest.update(name.encode()+b'\0'+b)
   for line in b.decode().splitlines():
    if not line or line.startswith('#'):continue
    cols=line.split('\t')
    if len(cols)!=11 or cols[4]!=name:raise ValueError('Malformed native HMM hit '+str(p))
    hits[cols[0]].add(name)
  relax={k for k,v in hits.items() if v&mob}; cpids={k for k,v in hits.items() if v&cp};mpfids={k for k,v in hits.items() if v&mpf}-relax-cpids
  # A protein hitting more than one profile counts once within each evidence axis.
  complete=any(int(v)>0 for k,v in r.items() if k.startswith('n_T4SS_type'))
  native_d=any(int(v)>0 for k,v in r.items() if k.startswith('n_dCONJ_type'))
  rows.append({'plasmid_id':pid,'replicon_status':r['replicon_status'],'complete_MPF':int(complete),'n_relaxase_proteins':len(relax),'n_MPF_proteins':len(mpfids),'n_T4CP_proteins':len(cpids),'native_dCONJ':int(native_d),'pdCONJ':int(pdconj(complete,mpfids))})
  for hit,profiles in hits.items():details.append({'plasmid_id':pid,'protein_id':hit,'profiles':','.join(sorted(profiles)),'relaxase':int(bool(profiles&mob)),'MPF':int(hit in mpfids),'T4CP':int(bool(profiles&cp))})
  extractions.append({'plasmid_id':pid,'n_profile_files':len(names),'sha256_ordered_profile_names_and_bytes':digest.hexdigest()})
  if i%1000==0:print('Protein extraction',i,flush=True)
 write_tsv(ROOT/'outputs/native_protein_evidence.tsv',details,['plasmid_id','protein_id','profiles','relaxase','MPF','T4CP'])
 write_tsv(ROOT/'inputs/native_extract_manifest.tsv',extractions)
 write_tsv(ROOT/'outputs/protein_summary.tsv',rows)
 write_conflicts(details)
 return rows

def summarize(rows,aliases,special):
 ref={r['query_id']:r for r in aliases};allhits=collections.defaultdict(list);subjects={r['plasmid_id'] for r in rows}
 for h in blast_rows(ROOT/'outputs/blast_standard.tsv'):
  if h['sseqid'] not in subjects:raise ValueError('Unknown BLAST subject')
  if accepted(h):h['special_13nt']=0;allhits[h['sseqid']].append(h)
 exploratory=collections.defaultdict(list)
 if special:
  for h in blast_rows(ROOT/'outputs/blast_13nt_special.tsv'):
   if accepted(h,True):h['special_13nt']=1;exploratory[h['sseqid']].append(h)
 write_tsv(ROOT/'outputs/exploratory_13nt_hits.tsv',[h for hh in exploratory.values() for h in hh],FIELDS+['start','end','special_13nt'])
 accepted_rows=[];summary=[]
 for r in rows:
  hits=best_overlap(allhits[r['plasmid_id']]);long_hits=best_overlap([h for h in allhits[r['plasmid_id']] if int(ref[h['qseqid']]['length'])>18])
  for h in hits:accepted_rows.append(dict(h,reference_aliases=ref[h['qseqid']]['aliases']))
  ori=bool(hits);long=bool(long_hits)
  summary.append(dict(r,orit_detected=int(ori),orit_long_reference_detected=int(long),orit_short_only=int(ori and not long),n_nonoverlapping_orit_hits=len(hits),exploratory_13nt_detected=int(bool(exploratory[r['plasmid_id']])),functional_category=classify(r['complete_MPF'],r['n_relaxase_proteins'],ori),category_excluding_short_motifs=classify(r['complete_MPF'],r['n_relaxase_proteins'],long)))
 write_tsv(ROOT/'outputs/accepted_orit_hits.tsv',accepted_rows,FIELDS+['start','end','special_13nt','reference_aliases'])
 write_tsv(ROOT/'outputs/plasmid_summary.tsv',summary)
 grouped=[]
 for status in ['Single-replicon','Multi-replicon','All']:
  subset=[r for r in summary if status=='All' or r['replicon_status']==status]
  for cat in ['pCONJ','pMOB','pOriT','pNT']:
   c=[r for r in subset if r['functional_category']==cat]
   grouped.append({'replicon_status':status,'functional_category':cat,'n_plasmids':len(c),'n_pdCONJ':sum(r['pdCONJ'] for r in c),'n_orit_positive':sum(r['orit_detected'] for r in c),'n_orit_negative':sum(not r['orit_detected'] for r in c),'n_short_only':sum(r['orit_short_only'] for r in c),'n_category_excluding_short_motifs':sum(r['category_excluding_short_motifs']==cat for r in subset)})
 write_tsv(ROOT/'outputs/category_counts.tsv',grouped);print(json.dumps(grouped,indent=2))

def main():
 ap=argparse.ArgumentParser(description=__doc__)
 ap.add_argument('--outdir',required=True)
 ap.add_argument('--native-dir',help='Native CONJScan directory, including input_fastas.txt and conjscan_per_plasmid/')
 ap.add_argument('--model-definitions',help='Installed CONJScan definitions/Plasmids XML directory')
 ap.add_argument('--model-counts',help='Per-plasmid native n_T4SS_type*/n_dCONJ_type* model counts')
 ap.add_argument('--orit-reference',help='Original experimental OriTDB FASTA, 122 records / 116 unique strings in the published analysis')
 ap.add_argument('--blast-bin',default='',help='Directory containing blastn/makeblastdb, or leave empty to use PATH')
 ap.add_argument('--protein-summary',help='Precomputed native protein_summary.tsv (accepted native HMM evidence)')
 ap.add_argument('--orit-blast',help='Precomputed standard BLAST output with documented 13-column schema')
 ap.add_argument('--reference-aliases',help='Precomputed reference_aliases.tsv matching oriT query IDs')
 args=ap.parse_args()
 global ROOT,NATIVE,MODELS,TABLE,BIN,ORIT_REFERENCE
 ROOT=Path(args.outdir);BIN=Path(args.blast_bin)
 if ROOT.exists() and (not ROOT.is_dir() or any(ROOT.iterdir())):raise ValueError('Output directory must be absent or empty; use a fresh directory')
 precomputed=any([args.protein_summary,args.orit_blast,args.reference_aliases])
 if precomputed:
  if not all([args.protein_summary,args.orit_blast,args.reference_aliases]):ap.error('Precomputed mode requires all three evidence tables')
 else:
  if not all([args.native_dir,args.model_definitions,args.model_counts,args.orit_reference]):ap.error('Native mode requires native dir, XML models, model counts and experimental reference')
  validate_native_counts(Path(args.model_counts),Path(args.model_definitions))
 for directory in ['inputs','outputs','logs']:(ROOT/directory).mkdir(parents=True,exist_ok=True)
 if precomputed:
  if not all([args.protein_summary,args.orit_blast,args.reference_aliases]):ap.error('Precomputed mode requires all three evidence tables')
  rows=read_tsv(Path(args.protein_summary));aliases=read_tsv(Path(args.reference_aliases))
  for row in rows:
   for column in row:
    if column not in ('plasmid_id','replicon_status'):row[column]=int(row[column])
  if len({r['plasmid_id'] for r in rows})!=len(rows):raise ValueError('Duplicate protein-summary accessions')
  for row in rows:
   if row['complete_MPF'] not in (0,1) or any(row[k]<0 for k in ['n_relaxase_proteins','n_MPF_proteins','n_T4CP_proteins']):raise ValueError('Invalid protein-summary counts')
   if row['pdCONJ'] != int(not row['complete_MPF'] and row['n_MPF_proteins']>=2):raise ValueError('Inconsistent incomplete-MPF flag')
  shutil.copyfile(args.protein_summary,ROOT/'outputs/protein_summary.tsv')
  shutil.copyfile(args.orit_blast,ROOT/'outputs/blast_standard.tsv')
  shutil.copyfile(args.reference_aliases,ROOT/'inputs/reference_aliases.tsv')
  summarize(rows,aliases,[])
  sources=[args.protein_summary,args.orit_blast,args.reference_aliases]
 else:
  if not all([args.native_dir,args.model_definitions,args.model_counts,args.orit_reference]):ap.error('Native mode requires native dir, XML models, model counts and experimental reference')
  NATIVE=Path(args.native_dir);MODELS=Path(args.model_definitions);TABLE=Path(args.model_counts);ORIT_REFERENCE=Path(args.orit_reference)
  metadata,aliases,special=prepare();rows=proteins(metadata)
  run([BIN/'makeblastdb','-in',ROOT/'inputs/plasmids.fasta','-dbtype','nucl','-out',ROOT/'inputs/plasmids_db'])
  run([BIN/'blastn','-task','blastn-short','-query',ROOT/'inputs/oritdb_unique.fasta','-db',ROOT/'inputs/plasmids_db','-evalue','0.01','-num_threads','8','-max_target_seqs',str(len(rows)),'-outfmt','6 '+' '.join(FIELDS),'-out',ROOT/'outputs/blast_standard.tsv'])
  # Exploratory permissive 13-nt hits never affect primary categories.
  summarize(rows,aliases,[])
  sources=[args.model_counts,args.orit_reference]
 summary=read_tsv(ROOT/'outputs/plasmid_summary.tsv')
 for row in summary:
  expected=classify(int(row['complete_MPF']),int(row['n_relaxase_proteins']),int(row['orit_detected']))
  if row['functional_category']!=expected:raise ValueError('Classification inconsistency')
 manifest={'mode':'precomputed-evidence' if precomputed else 'native-HMM-plus-new-BLAST','n_plasmids':len(summary),'sha256':{str(p):sha(Path(p)) for p in sources},'thresholds':{'evalue_strict_lt':0.01,'identity_strict_gt':80,'query_span_coverage_strict_gt':80},'limitations':['Native HMM acceptance is inherited, not rescreened','No circular-origin oriT search','pdCONJ is a flag, not a mutually exclusive fifth class','No primary classification changes from exploratory short-hit searches']}
 (ROOT/'outputs/run_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
if __name__=='__main__':main()
