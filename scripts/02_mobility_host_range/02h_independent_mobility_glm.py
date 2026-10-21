#!/usr/bin/env python3
"""Final one-versus-rest models for independent four-category mobility calls."""
import os
for variable in ('OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS'):os.environ[variable]='4'
import argparse,json,sys,warnings
from pathlib import Path
import numpy as np
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.stats.multitest import multipletests
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'shared'))
from revision_utils import join_mobility,CATEGORIES

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--model-data',required=True,help='Model cohort and original non-mobility covariates')
 parser.add_argument('--mobility-table',required=True)
 parser.add_argument('--outdir',required=True)
 args=parser.parse_args();out=Path(args.outdir);out.mkdir(parents=True,exist_ok=True)
 data,audit=join_mobility(pd.read_csv(args.model_data,sep='\t'),pd.read_csv(args.mobility_table,sep='\t'))
 rows=[];diagnostics=[]
 for outcome in CATEGORIES:
  data[outcome]=data.predicted_mobility_model.eq(outcome).astype(int)
  formula=f'{outcome} ~ multireplicon_status + log10_length + C(host_genus_model) + C(source_model)'
  with warnings.catch_warnings(record=True) as caught:
   warnings.simplefilter('always');fit=smf.glm(formula,data=data,family=sm.families.Binomial(),missing='raise').fit()
  ci=fit.conf_int()
  for term in fit.params.index:
   with np.errstate(over='ignore',under='ignore'):low,high=np.exp(ci.loc[term]).tolist();odds=float(np.exp(fit.params[term]))
   rows.append(dict(outcome=outcome,term=term,formula=formula,n=int(fit.nobs),n_positive=int(data[outcome].sum()),coef=fit.params[term],SE=fit.bse[term],OR=odds,CI_low=low,CI_high=high,p_value=fit.pvalues[term],converged=bool(fit.converged)))
  pure={}
  for field in ['host_genus_model','source_model']:
   levels=data.groupby(field)[outcome].agg(['sum','count']);pure[field]=levels.index[(levels['sum']==0)|(levels['sum']==levels['count'])].tolist()
  diagnostics.append(dict(outcome=outcome,converged=bool(fit.converged),pure_levels=pure,warnings=[str(w.message) for w in caught]))
 results=pd.DataFrame(rows);mask=results.term.eq('multireplicon_status')
 results.loc[mask,'FDR']=multipletests(results.loc[mask,'p_value'],method='fdr_bh')[1]
 results.to_csv(out/'full_coefficients.tsv',sep='\t',index=False)
 results[mask].to_csv(out/'primary_M3_results.tsv',sep='\t',index=False)
 data.to_csv(out/'model_dataset.tsv',sep='\t',index=False)
 (out/'audit.json').write_text(json.dumps(dict(input=audit,models=diagnostics),indent=2))
 if not all(d['converged'] for d in diagnostics):raise RuntimeError('Nonconverged model; outputs are diagnostic, not validated results')
if __name__=='__main__':main()
