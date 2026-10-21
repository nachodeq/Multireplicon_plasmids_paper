# Revised analyses: inputs, execution and evidence

## What this revision changes

The default gene-content GLMs use the **independent OriTDB + CONJScan four-category
classification**, not the legacy mobility column in the metadata workbook. An
independent classification table is required, and missing/duplicate accessions
fail closed. Exact accession joins are preferred. Removing a leading `NZ_` is
allowed only if identifiers remain unique on both sides. All non-mobility model
covariates and outcome definitions remain unchanged.

The legacy MOB-typer component and three-category analyses remain available as
**sensitivity analyses**, not the default Figure 2a classification. No new
AllTheBacteria pipeline is introduced here. Existing host-distribution validation
scripts require **precomputed** assembly taxonomy and consolidated typing tables;
this repository does not provide an end-to-end reconstruction of those inputs.

## Independent mobility: two reproducible entry routes

Every invocation requires an absent or **empty output directory**. Nonempty output
directories are rejected before writes or tool execution, including directories
from a failed attempt. Use a fresh directory for retries. A failed native search
may leave intermediate files but does not produce a completed classification or
success manifest. The `outputs/run_manifest.json` file is written only after the
classification finishes successfully; do not treat intermediate files as results.

### Cached evidence (no new sequence search)

```sh
python3 scripts/02_mobility_host_range/02g_independent_mobility.py \
  --protein-summary data/independent/protein_summary.tsv \
  --orit-blast data/independent/blast_standard.tsv \
  --reference-aliases data/independent/reference_aliases.tsv \
  --outdir results/02_independent_mobility

python3 scripts/02_mobility_host_range/02h_independent_mobility_glm.py \
  --model-data data/model_cohort.tsv \
  --mobility-table results/02_independent_mobility/outputs/plasmid_summary.tsv \
  --outdir results/02_independent_mobility_models

python3 scripts/01_abundance_size_content/01b_source_adjusted_glm.py \
  --model-data data/model_cohort.tsv \
  --mobility-table results/02_independent_mobility/outputs/plasmid_summary.tsv \
  --outdir results/01_corrected_gene_models
```

`protein_summary.tsv` must contain `plasmid_id`, `replicon_status`,
`complete_MPF`, `n_relaxase_proteins`, `n_MPF_proteins`, `n_T4CP_proteins`,
`native_dCONJ` and `pdCONJ`. Protein counts derive from **distinct accepted native
HMM protein IDs**, including unassigned hits. Proteins assigned relaxase or T4CP
roles are excluded from structural MPF counts. The cached evidence route inherits
these upstream acceptance decisions; it does not validate new HMM searches.

`blast_standard.tsv` is tab-separated BLAST format 6, without a header, columns:
`qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen`.
Coordinates are 1-based inclusive. Primary acceptance is E-value **<0.01**,
identity **>80%**, query-coordinate span / query length **>80%**. Greedy
non-overlap selection prioritizes lowest E-value, then bitscore, identity,
alignment length and deterministic IDs. Query sequences are exact-string
unique OriTDB references (122 original records, 116 unique strings in the
recorded reference). `reference_aliases.tsv` records `query_id`, `length` and
`aliases`, preserving the experimental-reference provenance. The script also
reports classifications excluding references <=18 nt. Dedicated permissive
13-nt searches are exploratory and **never** change primary categories.

### Native accepted HMM extracts plus a new oriT search

```sh
python3 scripts/02_mobility_host_range/02g_independent_mobility.py \
  --native-dir data/conjscan_native \
  --model-definitions data/CONJScan/definitions/Plasmids \
  --model-counts data/conjscan_native_model_counts_by_plasmid.tsv \
  --orit-reference data/oriT_exp.fasta \
  --outdir results/02_independent_mobility
```

The native directory contains `input_fastas.txt` (one existing single-record
FASTA path per line) and `conjscan_per_plasmid/<accession>/hmmer_results/*.res_hmm_extract`.
Native model counts must include `plasmid_id`, `replicon_status` and
`n_T4SS_type*`/`n_dCONJ_type*` columns. Every complete-system count column implied
by the supplied `T4SS_type*.xml` files is required; misspelled/missing columns,
noninteger/negative counts, missing IDs and duplicate normalized IDs fail before
output creation. Missing complete-system evidence is never interpreted as zero.
XML models identify profile roles and
exchangeable coupling proteins. Native HMM extracts retain the original
acceptance thresholds (independent E-value <=0.001, profile coverage >=0.5);
the parser does not invent a second HMM filter. This route runs local
`makeblastdb` and `blastn -task blastn-short`, eight threads. It does not download
references, install models or run MacSyFinder itself. No circular-origin oriT
search is performed, so an origin-spanning match can be missed.

Classification is plasmid-wide:

| Class/flag | Rule |
|---|---|
| pCONJ | Accepted complete native `T4SS_type*` system and detected relaxase; oriT is **not required** |
| pMOB | Relaxase, no complete MPF |
| pOriT | oriT, no relaxase |
| pNT | Residual, provisional; phage-plasmid and rolling-circle classes are not screened |
| pdCONJ | >=2 distinct structural MPF proteins, no complete MPF; an independent flag, not a fifth class |

`model_cohort.tsv` must contain unique `plasmid_id`, `multireplicon_status`,
`log10_length`, `host_genus_model`, and `source_model`; gene analyses also require
`AMR_presence`, `metal_biocide_presence`, `virulence_presence`, their original
count columns and descriptive metadata used for summary tables. Use the original
23,925-row model cohort and pooled categorical values rather than rebuilding
pooling on a filtered subset. The gene CLI can instead read its original source
workbooks, but still requires the independent mobility table. Gene formulas add
`C(predicted_mobility_model)` with pCONJ as the default treatment reference.
Mobility category models are separate one-versus-rest binomial-logit models.
Ordinary standard errors, original genus/source levels and all observations are
retained. Sparse levels, particularly pOriT in Pantoea and Streptomyces, can
produce quasi-separation even when a model converges. Full coefficients and
model diagnostics must be inspected, not only the focal AOR.

## Homology and IS windows are separate

Use `05b` at **half-window 500** for homology. Use `05g_extract_is_windows.py` at
**half-window 2000** for IS annotation, then `05c`, then `05d`. The README provides
these separate commands. `05g` performs no BLAST/homology analysis. Both new
extractors record `window_start_genome`, `window_length` and
`breakpoint_window_position` in the master. The sequence begins at that genomic
origin and proceeds on the forward strand, wrapping circularly. IS strand comes
from digIS; these extractors do not reverse-complement individual windows.

The master schema is `pair_id`, `plasmid`, `bp_kind` (`start`/`end`),
`breakpoint_pos`, `plasmid_len`, `window_hw`, `window_start_genome`,
`window_length`; `breakpoint_window_position` optionally records the exact
within-window center used to rank hits. Annotation endpoints are 1-based inclusive.
`05d` maps each selected hit into one or two circular genomic intervals and
recodes **any** overlap, whether labels match or differ, as one IS-associated
region. It preserves `IS_class_raw`, `selected_hits_overlap` and mapped intervals.
The same rule is applied to real and random pairs. Family and orientation
summaries use retained two-region same-label pairs. A matching model label is
not proof of identical sequence or complete IS copies.

For masters without explicit geometry, `--coordinate-convention exact-2hw`
is available for this repository's extractor, while `legacy-inclusive` declares
the actual historical notebook convention: usually 2hw+1 bases, 2hw when crossing
the left origin, with a one-base left-wrap shift. **Never silently mix these
conventions.** Short historical windows require actual origins and FASTA lengths;
nominal size is not a valid substitute. The production regression adapter reads
actual cached FASTA lengths and preserves historical best-hit ranking at hw+1.
Newly extracted random windows are not asserted to reproduce the historical
random draw or its truncated windows.

This correction does **not** regenerate or repair the original breakpoint
containment input. Known accession inconsistencies and short historical control
windows remain upstream limitations. The original manuscript's 1,617 wording is
not changed by this code revision; tables here count **candidate pairs**, not
confirmed origins or necessarily distinct plasmids. We do not claim those
upstream defects are fixed.

## Flanking-context parameters and limitations

The recorded run used k=15, minimum 5 plasmids, deterministic maximum 100,
99 context Mantel permutations, seed 20260702, flanks 500/1000/2000/4000/8000 bp
per side, and `--context-only-permutations`. Defaults and the README command now
match that run. The algorithm itself is unchanged: distinct noncanonical k-mer
sets, Jaccard distances and Pearson Mantel tests. Context concatenation introduces
up to 14 artificial 15-mers across the deleted replicon interval; only N-containing
k-mers are excluded. Possible physical overlap of the two replicon contexts is
not excluded. This is not a context-tree reconstruction or origin-frequency test.

## Verification and reference metrics

```sh
python3 -m unittest discover -s tests -v
python3 -m compileall -q scripts
python3 tests/verify_revision_results.py \
  --gene-model-data data/model_cohort.tsv \
  --mobility-analysis data/independent_cached_analysis \
  --v3 data/historical_junction_outputs
```

The last command requires the declared cached production inputs, reads originals
only, and writes to a temporary directory. It rebuilds classification from
primitive protein/BLAST evidence and refits seven final M3 models; it does not run
BLAST/HMM, NUCmer or ATB. Without those inputs, unit tests/compilation are **not**
full reproduction. Aggregated expected metrics, not private workbooks, are stored
in `tests/fixtures/revision_metrics.json`.

| Check | Recorded result |
|---|---|
| Cohort | 23,925; 16,376 single / 7,549 multi |
| Independent categories | pCONJ 7,864; pMOB 5,952; pOriT 2,273; pNT 7,836 |
| Corrected gene AOR | AMR 1.775360; metal/biocide 1.765137; virulence 4.403767 |
| Mobility AOR | pCONJ 1.220049; pMOB 1.134701; pOriT 2.105527; pNT 0.496955 |
| Real corrected IS classes | 0 IS 495; 1 region 661; 2 same 374; 2 different 87 |
| Random corrected IS classes | 0 IS 721; 1 region 641; 2 same 55; 2 different 200 |
| Real retained same-label hits | IS6 345/374; direct 204, inverted 170 |

The three gene AORs supersede 1.92/1.93/4.37 from the erroneous legacy mobility
covariate. The 28% pCONJ / AOR 1.91 legacy classification is not the independent
47.28% versus 26.23% pCONJ definition / AOR 1.22.

## Environment evidence

The numerical regression check was run with Python 3.10.12, NumPy 2.2.6,
pandas 2.2.3, SciPy 1.14.1, statsmodels 0.14.4 and Biopython 1.80. These are
**verified test-environment versions**, not proof that every upstream annotation
used this environment. Recorded annotation versions are BLAST 2.16.0+,
MacSyFinder 2.1.6, MacSyLib 1.0.4, CONJScan 2.1.0, digIS 1.2 and cd-hit-est
4.8.1. CONJScan XML definitions, accepted extracts and experimental OriTDB
reference hashes are separate reproducibility inputs, not Python packages.

The conda specification pins the verified numerical Python package versions. It is
not a solved lockfile; a fresh conda solve was not performed during this update.
Specialized
annotation tools and databases must be installed separately according to their
own distribution instructions. Provide `--digis-script` for the recorded digIS
implementation. No installation or database download is performed automatically.
The original experimental reference URL is
`https://bioinfo-mml.sjtu.edu.cn/oriTDB2/download/sequence/oriT_exp.fasta`;
retain its retrieved bytes and checksum rather than assuming a future download
is unchanged. Two Supplementary Dataset 1 workbooks are retained in the public
repository; use the canonical `Supplementary_Dataset_1.xlsx` explicitly, not a
filename glob. The source-data requirements above remain necessary even with
that public workbook.
