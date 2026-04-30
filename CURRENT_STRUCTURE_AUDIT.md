# Current Structure Audit

## 1) Current full file tree

> Note: This tree reflects repository content excluding `.git/` internals for readability.

```text
.
├── 01_make_meta.py
├── 02_build_fasta.sh
├── 03_mmseqs_cluster.sh
├── 04_analyze_mr_familyspace.py
├── FILE_AUDIT.md
├── Multireplicon_plasmids_paper-1.pdf
├── Multireplicon_plasmids_paper.txt
├── RepliconCoocurrence.ipynb
├── RepliconCoocurrence_dedup.ipynb
├── Visnetwrork.ipynb
├── create_mmseqs_dbs.py
├── data__conteosingles.py
├── data__raw__cosilla.py
├── data__raw__cosilla2.py
├── data__raw__prep_dedup.sh
├── data__raw__unascounts.py
├── derep__Containment_networks.ipynb
├── derep__Mashddists.ipynb
├── derep__New_replicook.ipynb
├── derep__RepliCOOK2.ipynb
├── derep__RepliconCoocurrence.ipynb
├── derep__blast_things_all_plasmids__Untitled.ipynb
├── derep__cell_level__Cell_level.ipynb
├── derep__cell_level__Untitled.ipynb
├── derep__cell_level__homology_sharing__Homology_sharing.ipynb
├── derep__cell_level__homology_sharing__WHATDOTHEYSHARE__Untitled.ipynb
├── derep__cell_level__homology_sharing__collapse_plasmid_pairs_nonoverlap.py
├── derep__cell_level__homology_sharing__collapse_reps.py
├── derep__cell_level__homology_sharing__filter_delta99.sh
├── derep__cell_level__homology_sharing__parse_coords_all_hits.py
├── derep__cell_level__homology_sharing__parse_coords_all_hits_parallel_v3.py
├── derep__cell_level__homology_sharing__parse_coords_all_hits_parallel_v3_delta.py
├── derep__cell_level__homology_sharing__prepare_pairs.py
├── derep__cell_level__homology_sharing__run_nucmer.sh
├── derep__cell_level__meta__Untitled.ipynb
├── derep__containment_mm2__run_minimap_plans.sh
├── derep__efficiency_vs_mantel__Correlations_distancia_cointegration.ipynb
├── derep__efficiency_vs_mantel__Untitled.ipynb
├── derep__filter_nonzero_kmers.py
├── derep__hostrange__Hostrange.ipynb
├── derep__hostrange__checks_ejemplos__aeroejemplo__allthebacteriamcr3__mcr3allthebacteria.Rmd
├── derep__louvain_by_level_from_table_including_isolates__Untitled.ipynb
├── derep__louvain_by_level_from_table_including_isolates__defensefinder__Untitled.ipynb
├── derep__mobilizables__Mobilizables.ipynb
├── derep__revise_table.py
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS2__redoalignbreakpoints.ipynb
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__analyze_homolog_breakspoints.ipynb
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__get_top3_clusters_sequences.py
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__getalignments.py
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__run_breakpoint_blast.py
├── derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__summarize_bestlen.py
├── derep__uniones_entre_plasmidos__V3__Find_ISs.ipynb
├── derep__uniones_entre_plasmidos__V3__IS_length_distribution__Dist.Rmd
├── derep__uniones_entre_plasmidos__V3__IS_length_distribution__read.py
├── derep__uniones_entre_plasmidos__V3__hyperpal_full.py
├── derep__uniones_entre_plasmidos__V3__plot.py
├── derep__uniones_entre_plasmidos__V3__run_digis_breakpoints.sh
├── derep__uniones_entre_plasmidos__V3__run_digis_random_hw2000.sh
├── derep__uniones_entre_plasmidos__V3__run_mefinder.sh
├── derep__uniones_entre_plasmidos__V3__test_50s.py
├── derep__uniones_entre_plasmidos__V3__test_hyperpal.py
├── derep__uniones_entre_plasmidos__extract_breakpoints_windows_circular.py
├── derep__uniones_entre_plasmidos__hits_per_window_backgr.py
├── derep__uniones_entre_plasmidos__make_background.py
├── derep__uniones_entre_plasmidos__mge_hits_por_ventana.py
├── derep__uniones_entre_plasmidos__v2_4kbp__count_windows_by_hmm_corrected_v2.py
├── derep__uniones_entre_plasmidos__v2_4kbp__make_background_v2.py
├── derep__uniones_entre_plasmidos__v2_4kbp__summarise_mefinder.py
├── derep__uniones_entre_plasmidos__wits_per_indow_corrected.py
├── rafathings__fetch_nuccore_metadata.py
├── rafathings__figurametalvir.R
├── rep_distances__Distancias.ipynb
├── rep_distances__calcular_dist.py
├── rep_distances__getlist.py
├── rep_distances__letsshowmultirepps__control_mantel__01_run_missing_mobtyper.sh
├── rep_distances__letsshowmultirepps__control_mantel__02_prepare_missing_mobtyper_inputs.py
├── rep_distances__letsshowmultirepps__control_mantel__03_run_aligns_control.sh
├── rep_distances__letsshowmultirepps__control_mantel__ControlVsMantel.Rmd
├── rep_distances__letsshowmultirepps__control_mantel__Untitled.ipynb
├── rep_distances__letsshowmultirepps__control_mantel__buildusablepairs.py
├── rep_distances__letsshowmultirepps__control_mantel__fetchfastas2.py
├── rep_distances__letsshowmultirepps__treesreplicons__Mantelporpares.Rmd
├── rep_distances__letsshowmultirepps__treesreplicons__all_pairs__fetchallpairs.py
├── rep_distances__letsshowmultirepps__treesreplicons__fetchfastas.py
├── rep_distances__letsshowmultirepps__treesreplicons__run_aligns.sh
├── rep_distances__mobty.sh
├── run_rbh_fromdb_streaming_pairs.py
├── scripts/
│   └── NEEDS_REVIEW/
│       └── deprecated_breakpoint_versions/
│           ├── derep__uniones_entre_plasmidos__fetch_breakpoints_windows.sh
│           ├── derep__uniones_entre_plasmidos__v2_4kbp__extract_breakpoints_windows_circular.v2.py
│           └── derep__uniones_entre_plasmidos__v2_4kbp__fetch_breakpoints_windows.sh
├── sometests__mannwu.py
└── wGRR.ipynb
```

## 2) Expected manuscript sections that currently have scripts

Based on file prefixes and naming conventions, these section-like areas currently have code:
- `data` / raw prep (`data__*`).
- `derep` core analyses (`derep__*`) including sub-areas:
  - host range,
  - containment,
  - cell-level homology sharing,
  - breakpoint/IS analyses (V2/V3),
  - mobilizables / louvain / efficiency.
- `rep_distances` analyses (`rep_distances__*`) including control Mantel and trees-by-replicon.
- `rafathings` one-off utilities/figures (`rafathings__*`).
- sequence/db build pipeline stubs (`01_make_meta.py`, `02_build_fasta.sh`, `03_mmseqs_cluster.sh`, `04_analyze_mr_familyspace.py`, `create_mmseqs_dbs.py`).

## 3) Expected section folders missing or empty

Assuming intended structure is folderized by section under `scripts/` (e.g., `scripts/derep/`, `scripts/rep_distances/`, `scripts/data/`):
- Missing: `scripts/derep/`
- Missing: `scripts/rep_distances/`
- Missing: `scripts/data/`
- Missing: `scripts/rafathings/`
- Missing: `scripts/pipeline/` (or equivalent for `01..04` scripts)
- Present but mostly staging-only: `scripts/NEEDS_REVIEW/`
- Non-empty in `scripts/`: only `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/` currently contains files.

## 4) Root-level scripts/notebooks remaining outside `scripts/`

- Nearly all scripts and notebooks remain at repository root (Python, shell, R/Rmd, and `.ipynb`).
- Only 3 files are currently under `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/`.

## 5) Required file existence check

- `README.md`: **missing**
- `MISSING_CODE.md`: **missing**
- `config/paths.yaml`: **missing**
- `FILE_AUDIT.md`: **present**

## 6) Inconsistencies between intended structure and current state

- Repository appears to be transitioning toward a `scripts/`-based organization, but almost all executable and analysis files are still root-level.
- `scripts/NEEDS_REVIEW/` exists and is used, but there is no broader section-based directory layout under `scripts/`.
- Key project-structure/documentation files expected in curated repositories (`README.md`, `MISSING_CODE.md`, `config/paths.yaml`) are absent.
- Mixed naming/style conventions remain (e.g., many `__`-delimited monolithic filenames, `Untitled` notebooks), suggesting partial cleanup but not a finalized structure.
