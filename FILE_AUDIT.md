# Breakpoint Script Audit (old/v2/v3 duplicates)

Audit scope: old/v2/v3 breakpoint-related scripts. Kept the likely manuscript-relevant V3 pipeline files in place, and moved older-version candidates to `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/` for safe review.

| file path | inferred purpose | manuscript relevance | related figure/section | action | justification |
|---|---|---|---|---|---|
| `derep__uniones_entre_plasmidos__V3__run_digis_breakpoints.sh` | Run V3 breakpoint detection workflow | likely high | breakpoint discovery methods/results | KEEP | Explicit V3 naming suggests final generation used for manuscript workflow. |
| `derep__uniones_entre_plasmidos__V3__ALIGNBREAKPOINTS__run_breakpoint_blast.py` | BLAST step for V3 breakpoint alignment pipeline | likely high | breakpoint alignment/validation methods | KEEP | Explicit V3 pipeline component; likely manuscript-relevant. |
| `derep__uniones_entre_plasmidos__extract_breakpoints_windows_circular.py` | Breakpoint-window extraction helper (unversioned) | unclear | methods helper | KEEP (UNCERTAIN) | Unversioned; could still be active. Kept to avoid deleting uncertain or potentially relevant logic. |
| `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/derep__uniones_entre_plasmidos__v2_4kbp__fetch_breakpoints_windows.sh` | Older v2.4kbp window-fetching workflow | likely superseded | prior method iteration | MOVE | Explicit v2 marker indicates older generation; moved for review, not deleted. |
| `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/derep__uniones_entre_plasmidos__v2_4kbp__extract_breakpoints_windows_circular.v2.py` | Older v2 circular-window extraction | likely superseded | prior method iteration | MOVE | Version-suffixed v2 script likely predecessor to later pipeline. |
| `scripts/NEEDS_REVIEW/deprecated_breakpoint_versions/derep__uniones_entre_plasmidos__fetch_breakpoints_windows.sh` | Non-V3 fetch helper potentially older duplicate | uncertain | breakpoint preprocessing | MOVE (UNCERTAIN) | Moved to review bucket because V3-specific scripts exist; retained for manual comparison. |
