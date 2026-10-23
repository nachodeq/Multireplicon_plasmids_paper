# Corrected marker extraction and flanking contexts

## Scope

The shared `scripts/shared/replicon_markers.py` implementation is used by
04a (multireplicon sequences), 04b (separate-plasmid controls), and section4
spacing. 04e consumes their individual marker FASTA headers and clips paired
contexts. 04c/04d restore the original diagnostic-only bootstrap behavior.
No annotation search, manuscript data, ATB pipeline, or unrelated GLM/IS analysis
is changed by this revision.

## Reproduction contracts

- Native filtering source: MOB-suite 3.1.9 `utils.py`. The four native filtering
  functions are loaded from the supplied/installed package. Their order and the
  accession-key collapse reproduce the validated completed analysis; a generic
  greedy overlap approximation is not substituted.
- Selection: first assigned reference for each distinct exact type, then highest
  bit-score final retained HSP for the exact `reference|type` query. Genomic/query
  coordinate and strand order resolves ties. No raw fallback or circular fragment
  assembly. The selected HSP is a marker sequence, not proof of a functional
  autonomous replicon.
- Coordinates: inclusive nucleotide positions and strand, checked against the
  exact single-record nucleotide FASTA. Raw query/reference and true nucleotide
  length are exported. The old coordinate-separation heuristic is not applied.
- Flanks: freeze the common sorted cohort, apply the existing deterministic
  max-100 sampling, exclude the entire pair for any positive sampled annotation
  overlap, otherwise split each circular inter-marker gap at its floor midpoint.
  The current default is only 1 kb per side (nominal maximum after clipping).
  Explicit historical sensitivity-window overrides retain identical valid
  plasmids at requested windows. Actual lengths and exclusions are exported.
  The 1-kb focus was chosen after examining five windows, not prespecified anew;
  unchanged raw P values are reported for this selected view, while historical
  five-window BH results remain archived.
- Inference: original k=15 Jaccard, 99 context permutations, seed20260702; original
  NJ/pml/optim.pml GTR one-category tree fits, 100 bootstraps, 9,999 Pearson Mantel
  permutations and 2,000 mirror permutations. Bootstrap errors are diagnostics,
  never an extra successful-result filter.
- Operational safety: 04a/04b require fresh/empty output directories to avoid
  stale raw-marker FASTAs or old alignments. This does not select scientific
  observations. Failed required extraction is reported before alignment.

## Checks run

1. `MOB_SUITE_UTILS=/path/to/mob_suite/utils.py python3 -m unittest discover -s tests -v`
   — **28 tests passed**, including native boundary-fragment removal, retained
   accession collapse, exact accession/type matching, repeated-type first
   reference, reverse strand, observed/control extraction CLI, spacing agreement,
   ignored concatenates, and whole-pair exclusion for one 3-bp overlap.
2. `python3 -m compileall -q scripts` and `git diff --check` — passed.
3. All four changed Python command-line entry points accepted `--help`.
   Both R scripts parsed successfully.
4. `Rscript tests/test_mantel_bootstrap.R` — both R entry points preserved finite
   Mantel results when both bootstrap calls were deliberately forced to fail.
   This checks original control flow, not a new phylogenetic estimate. The local
   check used an explicitly supplied existing R library fallback; nothing was
   installed or downloaded.
5. `python3 tests/verify_marker_revision.py --markers <completed_selected_markers.tsv> --geometry <completed_context_geometry.tsv> --mobtyper-dir <cached_MOB_directory> --mob-suite-utils <native_utils.py> --limit 500`
   — **500 plasmids, 958 markers** independently replayed and DNA-hash matched;
   **35,170 geometry records** matched midpoint caps and independent circular arc
   intersection checks. Native source SHA256:
   `ff0cdff8f7e2d9f3b5df93f87c65eba10d6b8a4c278165cd9a8c5c090e6640ed`.

The expensive 550-pair alignment/tree analysis was not repeated for this code
change. A fresh environment installation and a complete annotation-to-figure
rerun were not performed. External cached inputs and MOB databases remain user
prerequisites. These limitations are not replaced by a claim of full end-to-end
reproduction.
