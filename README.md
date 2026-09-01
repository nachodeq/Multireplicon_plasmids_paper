# Multireplicon plasmids analysis code

Code and supplementary datasets for *Multireplicon plasmids are enriched in
antimicrobial resistance genes and transfer associated features and show
broader observed host distributions* (de Quinto et al.).

The repository is organized in manuscript order. Analysis scripts generate
tables and statistical summaries; final publication figures are assembled
from those outputs outside this repository.

## Repository structure

```text
Supplementary_Datasets/                 Public supplementary workbooks
scripts/00_dataset_deduplication/       Mash and Louvain dereplication
scripts/01_abundance_size_content/      Abundance, size, content and adjusted GLMs
scripts/02_mobility_host_range/         Mobility, ConjScan and observed host range
scripts/03_cointegration_network/       Network and cell-level cointegration
scripts/04_coevolution_distance_analysis/ Spacing, phylogenies, Mantel and flanks
scripts/05_fusion_breakpoints/          Containment, homology and insertion sequences
examples/                               Small executable example
tests/                                  Fast repository integrity tests
environment.yml                         Conda environment specification
```

## Installation

```bash
git clone https://github.com/nachodeq/Multireplicon_plasmids_paper.git
cd Multireplicon_plasmids_paper
conda env create -f environment.yml
conda activate multireplicon-plasmids
```


| Software/data | Version |
|---|---|
| PLSDB release | `2024_05_31_v2` |
| MacSyFinder | 2.1.6 |
| MacSyLib | 1.0.4 |
| CONJScan | 2.1.0 |
| MUSCLE | 5.3 |
| MUMmer/NUCmer | 4 |
| cd-hit-est | 4.8.1 |
| digIS | 1.2 |


## Input data

The four supplementary datasets are included under `Supplementary_Datasets/`.
Full reruns additionally require data that are too large to distribute in Git, if needed, request them at idequintoc@gmail.com:

- PLSDB `2024_05_31_v2` plasmid nucleotide and predicted-protein FASTA files;
- PLSDB/MOB-typer typing and metadata tables;
- MOB-typer per-plasmid summaries and `replicon_blast_results.txt` files;
- precomputed ConjScan Likely-System calls for the 23,925 representative
  plasmids;
- the precomputed AllTheBacteria target-species table (1,863,797 unique
  assemblies) and consolidated MOB-typer master table (2,763,297 unique
  assemblies overall);

Input paths are supplied as command-line arguments. 

## Execution order

Use separate output directories. Commands below show the complete interfaces;
replace paths under `data/` with the corresponding local inputs.

### 0. Dataset deduplication

```bash
python3 scripts/00_dataset_deduplication/00_deduplicate_plasmids_mash_louvain.py \
  --plasmid-replicons data/plasmid_replicons.tsv \
  --outdir results/00_deduplication \
  --threads 8 --mash-k 9 --mash-sketch 2000 \
  --distance-threshold 0.01
```

Principal outputs include `cluster_assignments_by_level.tsv`,
`representatives_by_cluster_level.tsv`, `to_keep_louvain_by_level.txt` and
`Supplementary_Dataset_1.xlsx`. This stage runs Mash all-versus-all distance
calculations and is resource-intensive.

### 1. Abundance, size and genetic content


```bash
python3 scripts/01_abundance_size_content/input/01_section1_analysis.py \
  --supplementary-dataset Supplementary_Datasets/Supplementary_Dataset_1.xlsx \
  --metadata data/meta/nuccore.csv \
  --typing data/meta/typing.csv \
  --functional-table data/Plasmids_data_ok.tsv \
  --outdir results/01_abundance_size_content
```

The script writes the Figure 1 and Supplementary Figure 2–4 source tables and
their statistical summaries. 

Source-adjusted binomial GLMs are run with:

```bash
python3 scripts/01_abundance_size_content/01b_source_adjusted_glm.py \
  --supplementary-dataset Supplementary_Datasets/Supplementary_Dataset_1.xlsx \
  --plasmids-data data/Plasmids_data_ok.xlsx \
  --outdir results/01_source_adjusted_glm \
  --min-genus-n 200 --min-mobility-n 20

python3 scripts/01_abundance_size_content/01c_prepare_genus_source_tables.py \
  --model-table results/01_source_adjusted_glm/model_df_clean_for_source_adjusted_GLM.tsv \
  --outdir results/01_genus_prevalence
```

These steps produce nested GLM coefficients, adjusted odds ratios, source
summaries, top-25-genus prevalence and binomial confidence intervals.

### 2. Mobility, ConjScan and observed host distributions

```bash
python3 scripts/02_mobility_host_range/02_section2_mobility_hostrange_analysis.py \
  --supplementary-dataset Supplementary_Datasets/Supplementary_Dataset_1.xlsx \
  --typing data/meta/typing.csv \
  --taxonomy data/taxonomy.tsv \
  --outdir results/02_mobility_host_range
```

```bash
python3 scripts/02_mobility_host_range/02b_prepare_conjscan_native.py \
  --systems data/conjscan_systems_long.tsv \
  --plasmid-metadata data/conjscan_vs_mobtyper_by_plasmid.tsv \
  --outdir results/02_conjscan

python3 scripts/02_mobility_host_range/02d_source_adjusted_mobility_components.py \
  --model-table results/01_source_adjusted_glm/model_df_clean_for_source_adjusted_GLM.tsv \
  --mobility-features data/mobility_feature_components_by_plasmid.tsv \
  --outdir results/02_mobility_components

Rscript scripts/02_mobility_host_range/02c_calculate_conjscan_odds_ratios.R \
  results/02_conjscan/conjscan_native_model_counts_by_plasmid.tsv \
  results/01_source_adjusted_glm/model_df_clean_for_source_adjusted_GLM.tsv \
  results/02_conjscan/conjscan_odds_ratios.tsv
```

The host-distribution analysis uses all 72,556 PLSDB plasmids rather
than the deduplicated subset:

```bash
python3 scripts/02_mobility_host_range/02e_observed_host_range_jumps.py \
  --typing data/all_plasmids/typing.csv \
  --genus data/all_plasmids/nuccore_acc_genus.csv \
  --descriptions data/all_plasmids/acc_desc.csv \
  --outdir results/02_observed_host_range

python3 scripts/02_mobility_host_range/02f_validate_host_range_jumps_atb.py \
  --raw-events results/02_observed_host_range/all_plasmids_host_range_jump_events_raw.tsv \
  --species-calls data/allthebacteria/target_samples_all_atb.tsv.gz \
  --mobtyper-master data/allthebacteria/ALLTHEBACTERIA.mobtyper.master.tsv \
  --outdir results/02_atb_validation
```

These stages process precomputed outputs and do not launch ConjScan, MOB-typer
or distributed AllTheBacteria jobs. The ConjScan result table supplied to
`02b_prepare_conjscan_native.py` was generated with MacSyFinder 2.1.6,
MacSyLib 1.0.4, CONJScan 2.1.0, `CONJScan/Plasmids` and
`--db-type unordered`.

### 3. Replicon network and cell-level cointegration

```bash
python3 scripts/03_cointegration_network/03_section3_cointegration_analysis.py \
  --nuccore data/cell_level/meta/nuccore.csv \
  --assembly data/cell_level/meta/assembly.csv \
  --typing data/cell_level/meta/typing.csv \
  --supplementary-dataset Supplementary_Datasets/Supplementary_Dataset_1.xlsx \
  --outdir results/03_cointegration
```

The genus-balanced and host-balanced sensitivity analysis is:

```bash
python3 scripts/03_cointegration_network/03b_rebalanced_cell_level_cointegration.py \
  --input-dir data/cell_level \
  --outdir results/03_cointegration_balanced \
  --min-cell 5 --min-genus-cell 5 \
  --dominant-frac 0.8 --subsample-cap 100 \
  --subsample-reps 300 --seed 20260704
```

Outputs include global and genus-specific conditional frequencies, exact
Clopper–Pearson intervals, high/low/mixed classifications, balanced
subsampling summaries and Pearson/Spearman correlation statistics. The 300
subsampling iterations make this stage slower than the basic summaries.

### 4. Replicon spacing and phylogenetic congruence

Compute spacing and its circular random null with:

```bash
python3 scripts/04_coevolution_distance_analysis/04_section4_spacing_coevolution_analysis.py \
  --mobtyper-dir data/mobtyper_outputs \
  --plasmid-replicons data/plasmid_replicons.tsv \
  --cointegration results/03_cointegration/global_conditional_cointegration.tsv \
  --mantel results/04_mantel/multireplicon_pairwise_mantel_results.tsv \
  --outdir results/04_spacing \
  --min-pair-n 5 --random-seed 123 --qcv-null-iterations 1000
```

Prepare sequences and run the multireplicon and separate-plasmid Mantel
analyses in this order:

```bash
python3 scripts/04_coevolution_distance_analysis/04a_prepare_align_multireplicon_replicons.py \
  --mobtyper-dir data/mobtyper_outputs --fasta-dir data/plasmid_fastas \
  --derep-representatives data/representatives.tsv \
  --outdir results/04_multireplicon_alignments \
  --min-count 5 --threads 8 --aligner muscle

Rscript scripts/04_coevolution_distance_analysis/04c_run_mantel_multireplicon.R \
  --input-dir results/04_multireplicon_alignments \
  --out-file results/04_mantel/multireplicon_pairwise_mantel_results.tsv \
  --mantel-perm 9999 --mirror-perm 2000 --min-taxa 4 --seed 42

python3 scripts/04_coevolution_distance_analysis/04b_prepare_align_separate_plasmid_controls.py \
  --nuccore data/cell_level/meta/nuccore.csv \
  --assembly data/cell_level/meta/assembly.csv \
  --typing data/cell_level/meta/typing.csv \
  --mantel-results results/04_mantel/multireplicon_pairwise_mantel_results.tsv \
  --mobtyper-dir data/mobtyper_outputs --fasta-dir data/plasmid_fastas \
  --outdir results/04_control_alignments --threads 8 --aligner muscle

Rscript scripts/04_coevolution_distance_analysis/04d_run_mantel_separate_plasmid_control.R \
  --input-dir results/04_control_alignments \
  --out-file results/04_mantel/control_pairwise_mantel_results.tsv \
  --mantel-perm 9999 --mirror-perm 2000 --min-taxa 4 --seed 42
```

The flanking-context analysis uses five symmetric window sizes:

```bash
python3 scripts/04_coevolution_distance_analysis/04e_run_flanking_context_mantel.py \
  --mantel-results results/04_mantel/multireplicon_pairwise_mantel_results.tsv \
  --trees-dir results/04_multireplicon_alignments \
  --fasta-dir data/plasmid_fastas \
  --outdir results/04_flanking_context \
  --flanks 500,1000,2000,4000,8000 \
  --kmer 15 --min-n 5 --max-n 200 \
  --permutations 199 --seed 20260702
```

Alignment, tree reconstruction and permutation tests are resource-intensive.

### 5. Fusion breakpoints, homology and insertion sequences

```bash
python3 'scripts/05_fusion_breakpoints/05a_nucmer_containment_events(1).py' \
  --plasmid-table data/plasmid_table.tsv \
  --fasta-dir data/plasmid_fastas \
  --outdir results/05_containment \
  --threads 30 --min-coverage 0.90 --min-identity 90

python3 scripts/05_fusion_breakpoints/05b_breakpoint_homology_analysis.py \
  --containment-events results/05_containment/containment_events.tsv \
  --fasta-dir data/plasmid_fastas \
  --outdir results/05_homology \
  --half-window 500 --min-pident 95 --seed 42 \
  --run-cdhit --cdhit-identity 0.95

python3 scripts/05_fusion_breakpoints/05c_run_digis_on_windows.py \
  --breakpoint-windows results/05_homology/breakpoints_windows.fa \
  --random-windows results/05_homology/random_windows.fa \
  --digis-script /path/to/digIS_search.py \
  --outdir results/05_digis

python3 scripts/05_fusion_breakpoints/05d_summarize_digis_is_architecture.py \
  --breakpoints-master results/05_homology/breakpoints_master.tsv \
  --breakpoints-digis-csv results/05_digis/breakpoints/digis_output/results/breakpoints_windows.csv \
  --random-master results/05_homology/random_windows_master.tsv \
  --random-digis-csv results/05_digis/random/digis_output/results/random_windows.csv \
  --outdir results/05_digis_summary

python3 scripts/05_fusion_breakpoints/05e_section5_final_tables.py \
  --homology-dir results/05_homology \
  --digis-summary-dir results/05_digis_summary \
  --outdir results/05_final_tables
```

This pipeline runs NUCmer, BLASTn, cd-hit-est and digIS and is
resource-intensive. It produces containment events, paired breakpoint and
random windows, best homology hits, homologous sequence clusters and IS
architecture summaries.

## Quick example and tests

The executable example is documented in `examples/README.md`. It requires no
external download and completes in a few seconds.

Run all fast integrity checks with:

```bash
python3 -m unittest discover -s tests -v
```


