"""Validated accession joins and explicit circular-window geometry."""
import json
import numpy as np
import pandas as pd

CATEGORIES = ('pCONJ', 'pMOB', 'pOriT', 'pNT')

def join_mobility(data, mobility):
    """Prefer exact IDs; allow NZ_ normalization only with proven uniqueness."""
    data, mobility = data.copy(), mobility.copy()
    for table in (data, mobility):
        if table.plasmid_id.isna().any() or not table.plasmid_id.is_unique:
            raise ValueError('Missing/duplicate plasmid identifiers')
    if mobility.functional_category.isna().any() or not mobility.functional_category.isin(CATEGORIES).all():
        raise ValueError('Expected independent pCONJ/pMOB/pOriT/pNT categories')
    exact = set(data.plasmid_id) <= set(mobility.plasmid_id)
    for table in (data, mobility):
        table['_join_id'] = table.plasmid_id if exact else table.plasmid_id.str.replace(r'^NZ_', '', regex=True)
        if not table._join_id.is_unique:
            raise ValueError('Normalized accession collision')
    mapping = mobility.set_index('_join_id').functional_category
    assigned = data._join_id.map(mapping)
    if assigned.isna().any():
        raise ValueError('Missing independent mobility assignments')
    data['predicted_mobility'] = assigned
    data['predicted_mobility_model'] = assigned
    return data.drop(columns='_join_id'), {'accession_join': 'exact' if exact else 'unique NZ-prefix normalization',
        'n': len(data), 'categories': assigned.value_counts().to_dict(), 'reference': 'pCONJ'}

def annotate_windows(master, convention=None):
    """Require actual origin/length, or an explicitly named historical convention."""
    master = master.copy()
    if 'breakpoint_pos' not in master and 'random_center' in master:
        master['breakpoint_pos'] = master.random_center
    required = {'pair_id', 'plasmid', 'bp_kind', 'breakpoint_pos', 'plasmid_len', 'window_hw'}
    if required - set(master):
        raise ValueError('Window master missing: ' + str(sorted(required-set(master))))
    if not master.bp_kind.isin(['start', 'end']).all():
        raise ValueError('Unknown endpoint kind')
    if master.duplicated(['pair_id', 'bp_kind']).any():
        raise ValueError('Duplicate endpoint metadata')
    if not {'window_start_genome', 'window_length'} <= set(master):
        if convention not in ('legacy-inclusive', 'exact-2hw'):
            raise ValueError('Provide explicit window_start_genome/window_length or --coordinate-convention')
        starts = master.breakpoint_pos - master.window_hw
        if convention == 'legacy-inclusive':
            # Actual notebook left-origin extraction starts one base later.
            master['window_start_genome'] = ((starts-1+(starts<1).astype(int)) % master.plasmid_len)+1
            master['window_length'] = 2*master.window_hw + (starts>=1).astype(int)
            # Short historical windows can be truncated. Never invent their geometry.
            if (master.plasmid_len < 2*master.window_hw+1).any():
                raise ValueError('Short legacy window: actual start/length metadata required')
        else:
            master['window_start_genome'] = ((starts-1) % master.plasmid_len)+1
            master['window_length'] = 2*master.window_hw
    for column in ['breakpoint_pos', 'plasmid_len', 'window_start_genome', 'window_length']:
        master[column] = pd.to_numeric(master[column], errors='raise').astype(int)
    if (master.plasmid_len<=0).any() or (master.window_length<=0).any():
        raise ValueError('Nonpositive window/genome length')
    if not ((master.window_start_genome>=1)&(master.window_start_genome<=master.plasmid_len)).all():
        raise ValueError('Window origin outside plasmid')
    return master

def covered_segments(origin, length, lo, hi, window_length):
    """1-based inclusive window-hit coordinates mapped to circular intervals."""
    origin, length, lo, hi, window_length = map(int, (origin,length,lo,hi,window_length))
    if not 1 <= lo <= hi <= window_length:
        raise ValueError('Annotation outside actual extracted sequence')
    span = hi-lo+1
    if span>=length:
        return [(1,length)]
    start = (origin+lo-2)%length+1
    end = start+span-1
    return [(start,end)] if end<=length else [(start,length),(1,end-length)]

def intervals_overlap(a, b):
    return any(max(x,u)<=min(y,v) for x,y in a for u,v in b)

def correct_pair_regions(pairs, master):
    """Recode overlapping selected annotations as one IS-associated region."""
    pairs = pairs.copy()
    if (master.groupby('pair_id').plasmid_len.nunique()>1).any():
        raise ValueError('Inconsistent plasmid lengths between endpoints')
    if not master.groupby('pair_id').size().eq(2).all():
        raise ValueError('Every pair requires both endpoint records')
    metadata = master.set_index(['pair_id','bp_kind'])
    pairs['IS_class_raw'] = pairs.IS_class
    pairs['selected_hits_overlap'] = False
    for index,row in pairs.iterrows():
        if row.IS_class == '0 IS':
            continue
        two_hits = row.IS_class in ('2 IS (same)','2 IS (different)')
        segments=[]
        for kind in ('start','end'):
            if not two_hits and not bool(row.get(kind+'_has_is', False)):
                continue
            m=metadata.loc[(row.pair_id,kind)]
            if m.plasmid != row.plasmid:
                raise ValueError('Pair/window accession mismatch')
            segments.append(covered_segments(m.window_start_genome,m.plasmid_len,
                row[kind+'_is_start_window'],row[kind+'_is_end_window'],m.window_length))
            pairs.at[index,kind+'_genomic_intervals'] = json.dumps(segments[-1])
        overlap=intervals_overlap(*segments) if len(segments)==2 else False
        pairs.at[index,'selected_hits_overlap']=overlap
        if overlap:
            pairs.at[index,'IS_class']='1 IS'
    return pairs
