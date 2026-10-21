#!/usr/bin/env python3
"""Extract separate ±2,000-bp IS windows without rerunning homology BLAST."""
import argparse
import importlib.util
from pathlib import Path
import random
import pandas as pd
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--containment-events', required=True)
    parser.add_argument('--fasta-dir', required=True)
    parser.add_argument('--outdir', required=True)
    parser.add_argument('--half-window',type=int,default=2000)
    parser.add_argument('--seed',type=int,default=12345)
    args=parser.parse_args()
    spec=importlib.util.spec_from_file_location('homology',Path(__file__).with_name('05b_breakpoint_homology_analysis.py'))
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    events=module.read_table(args.containment_events)
    if not {'event_id','big_id','big_start','big_end'} <= set(events):raise ValueError('Containment event schema incomplete')
    out=Path(args.outdir);out.mkdir(parents=True,exist_ok=True)
    index=module.index_fastas(Path(args.fasta_dir));rng=random.Random(args.seed)
    masters={'real':[],'random':[]};records={'real':[],'random':[]}
    for event in events.itertuples(index=False):
        path=module.find_fasta(str(event.big_id),index,Path(args.fasta_dir))
        if path is None:raise FileNotFoundError(event.big_id)
        sequence=module.read_plasmid_sequence(path);length=len(sequence)
        for dataset,centers in [('real',[int(event.big_start),int(event.big_end)]),('random',[rng.randint(1,length),rng.randint(1,length)])]:
            for kind,center in zip(['start','end'],centers):
                window=module.circular_subseq(sequence,center,args.half_window)
                sid=module.fasta_header(int(event.event_id),str(event.big_id),kind,center,args.half_window,dataset)
                masters[dataset].append(dict(pair_id=int(event.event_id),plasmid=str(event.big_id),bp_kind=kind,breakpoint_pos=center,plasmid_len=length,window_hw=args.half_window,window_start_genome=(center-args.half_window-1)%length+1,window_length=len(window),breakpoint_window_position=args.half_window+1,sid=sid))
                records[dataset].append(SeqRecord(Seq(window),id=sid,description=''))
    for dataset in masters:
        prefix='breakpoints' if dataset=='real' else 'random'
        pd.DataFrame(masters[dataset]).to_csv(out/f'{prefix}_master.tsv',sep='\t',index=False)
        module.write_fasta(records[dataset],out/f'{prefix}_windows.fa')
if __name__=='__main__':main()
