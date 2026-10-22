"""Select one exact final MOB-suite marker HSP and derive disjoint circular flanks.

Filtering is replayed from the configured native MOB-suite utils.py, not replaced
with a greedy overlap approximation. Input BLAST reports are the cached native
identity/coverage-filtered replicon_blast_results.txt files.
"""
import ast
from functools import lru_cache
import hashlib
import importlib.util
import json
import re
from pathlib import Path
import pandas as pd


def native_path(path=None):
    if path is not None:
        return Path(path).resolve()
    spec=importlib.util.find_spec('mob_suite')
    if spec is None or not spec.submodule_search_locations:
        raise RuntimeError('Install MOB-suite 3.1.9 or provide --mob-suite-utils /path/to/mob_suite/utils.py')
    return Path(next(iter(spec.submodule_search_locations)))/'utils.py'


@lru_cache(maxsize=4)
def native_functions(path):
    namespace={}
    wanted={'fixStart','remove_split_hits','filter_overlaping_records','recursive_filter_overlap_records'}
    for node in ast.parse(Path(path).read_text()).body:
        if isinstance(node,ast.FunctionDef) and node.name in wanted:
            exec(compile(ast.Module(body=[node],type_ignores=[]),str(path),'exec'),namespace)
    if not wanted<=namespace.keys():
        raise ValueError('Configured MOB utils.py lacks the native filtering functions')
    return namespace


def retained_rows(raw,native):
    if raw.empty:return raw.copy()
    data=native['fixStart'](raw.copy(deep=True))
    data=native['remove_split_hits'](data,'qseqid','sseqid','sstart','send','bitscore')
    data=data.sort_values(['sseqid','sstart','send','bitscore'],ascending=[True,True,True,False])
    data=native['recursive_filter_overlap_records'](data,5,'sseqid','sstart','send','bitscore')
    # identify_biomarkers -> sort_biomarkers uses accession keys and last type.
    accepted=dict(value.split('|',1) for value in data.qseqid)
    return data[data.qseqid.map(lambda value:accepted[value.split('|',1)[0]]==value.split('|',1)[1])].copy()


def assigned_references(summary):
    def field(names):
        for name in names:
            if name in summary:return str(summary[name])
        raise ValueError('Missing paired MOB type/accession summary columns')
    types=field(['rep_type(s)','replicon_types','rep_types']).split(',')
    refs=field(['rep_type_accession(s)','rep_type_accessions','rep_accession(s)']).split(',')
    if len(types)!=len(refs):raise ValueError('Unpaired MOB type/accession lists')
    result={}
    for typ,ref in zip(types,refs):
        typ,ref=typ.strip(),ref.strip()
        if typ not in ['', '-']:
            if ref in ['', '-']:raise ValueError('Assigned type lacks reference accession')
            result.setdefault(typ,ref)
    return result


def select_marker(retained,marker_type,accession):
    expected=accession+'|'+marker_type
    hits=retained[retained.qseqid.eq(expected)].copy()
    if hits.empty:raise ValueError(f'No final retained HSP for assigned query {expected}')
    hits=hits.sort_values(['bitscore','sstart','send','qstart','qend','sstrand'],ascending=[False,True,True,True,True,True],kind='stable')
    return hits.iloc[0]


def final_markers(mob_dir,plasmid,native):
    summary=pd.read_csv(Path(mob_dir)/(plasmid+'_summary.txt'),sep='\t',keep_default_na=False).iloc[0]
    assignments=assigned_references(summary)
    raw=pd.read_csv(Path(mob_dir)/(plasmid+'_analysis')/'replicon_blast_results.txt',sep='\t')
    retained=retained_rows(raw,native)
    return assignments,{typ:select_marker(retained,typ,ref) for typ,ref in assignments.items()}


def extract_sequence(sequence,hit):
    start,end=int(hit.sstart),int(hit.send)
    if not 1<=start<=end<=len(sequence):raise ValueError('Invalid inclusive genomic coordinates')
    marker=str(sequence[start-1:end]).upper()
    if hit.sstrand=='minus':marker=marker.translate(str.maketrans('ACGTRYMKSWBDHVN','TGCAYRKMSWVHDBN'))[::-1]
    elif hit.sstrand!='plus':raise ValueError('Unknown HSP strand')
    return marker


def annotation_overlap(a,b):
    return max(0,min(max(a.sstart,a.send),max(b.sstart,b.send))-max(min(a.sstart,a.send),min(b.sstart,b.send))+1)


def context_caps(a,b,length,flank):
    if annotation_overlap(a,b)>0:raise ValueError('Overlapping marker annotations')
    sa,ea=sorted([int(a.sstart),int(a.send)]);sb,eb=sorted([int(b.sstart),int(b.send)])
    if not 1<=sa<=ea<=length or not 1<=sb<=eb<=length:raise ValueError('Coordinates outside nucleotide plasmid')
    ab=(sb-1-ea)%length;ba=(sa-1-eb)%length
    la=rb=min(flank,ba//2);ra=lb=min(flank,ab//2)
    return la,ra,lb,rb


def write_provenance(outdir,path):
    path=Path(path)
    (Path(outdir)/'marker_filter_provenance.json').write_text(json.dumps(dict(native_utils_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),native_utils_name=path.name,reference_version='MOB-suite 3.1.9',order=['fixStart','remove_split_hits','sort sseqid/sstart/send/bitscore','recursive_filter_overlap_records threshold5','sort_biomarkers accession-key last-type collapse'],selection='First assigned accession per distinct exact type; highest retained bitscore, then genomic/query coordinates and strand; no raw fallback or circular assembly'),indent=2))


def resolve_cached_id(plasmid,mob_dir):
    """Permit legacy versionless metadata only when its cached accession is unique."""
    if (Path(mob_dir)/(plasmid+'_summary.txt')).exists():return plasmid
    if '.' in plasmid and plasmid.rsplit('.',1)[1].isdigit():raise FileNotFoundError('No exact cached MOB accession '+plasmid)
    candidates=[p.name[:-len('_summary.txt')] for p in Path(mob_dir).glob(plasmid+'.*_summary.txt')]
    candidates=[x for x in candidates if x.rsplit('.',1)[0]==plasmid and x.rsplit('.',1)[1].isdigit()]
    if len(candidates)!=1:raise ValueError('Missing or ambiguous versionless cached MOB accession '+plasmid)
    return candidates[0]


def find_nucleotide_fasta(plasmid,fasta_dir):
    fasta_dir=Path(fasta_dir)
    exact=[fasta_dir/(plasmid+ext) for ext in ['.fasta','.fa','.fna'] if (fasta_dir/(plasmid+ext)).is_file()]
    if len(exact)==1:return exact[0]
    if len(exact)>1:raise ValueError('Ambiguous duplicate nucleotide FASTA files for '+plasmid)
    return None


def normalized_type(value):
    """Filename/join identifier used by the corrected original analysis, never a hit matcher."""
    return re.sub(r'[^A-Za-z0-9_]+','_',str(value).strip())
