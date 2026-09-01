# Quick reproducibility example

This example uses the public `Supplementary_Dataset_1.xlsx` already included
in the repository. It exercises the abundance, replicon-count, plasmid-length
and global correlation calculations without downloading sequence data or
rerunning Mash, MOB-typer or the other resource-intensive analyses.

Create the environment and run the example from the repository root:

```bash
conda env create -f environment.yml
conda activate multireplicon-plasmids

python3 scripts/01_abundance_size_content/input/01_section1_analysis.py \
  --supplementary-dataset Supplementary_Datasets/Supplementary_Dataset_1.xlsx \
  --outdir example_outputs
```

Expected files are:

```text
example_outputs/section1_master_table.tsv
example_outputs/fig1_overall_counts.tsv
example_outputs/fig1b_size_distribution_table.tsv
example_outputs/fig1c_spearman_global.tsv
example_outputs/suppfig2_size_distribution_by_genus_table.tsv
```

Check successful completion with:

```bash
python3 - <<'PY'
import pandas as pd
x = pd.read_csv("example_outputs/fig1_overall_counts.tsv", sep="\t")
assert int(x.loc[0, "n_total"]) == 23925
assert int(x.loc[0, "n_multi_replicon"]) == 7549
print("Example completed successfully")
PY
```

The example demonstrates that the included representative-plasmid dataset can
be read and that the basic Section 1 summary tables are reproduced. It does
not rerun sequence dereplication, annotation, host-range, cointegration,
phylogenetic or breakpoint analyses, all of which require external inputs.
