# Small control-flow check: bootstrap failure must not reject ML/Mantel results.
fallback <- Sys.getenv("R_CHECK_FALLBACK")
if (nzchar(fallback)) .libPaths(c(.libPaths(), fallback))
for (script in c("04c_run_mantel_multireplicon.R", "04d_run_mantel_separate_plasmid_control.R")) {
  env <- new.env(parent = globalenv())
  expressions <- parse(file = file.path("scripts/04_coevolution_distance_analysis", script))
  for (expression in expressions[-length(expressions)]) eval(expression, envir = env)
  root <- tempfile(); dir.create(root)
  file.create(file.path(root, c("A_all_aligned.fasta", "B_all_aligned.fasta")))
  env$read_alignment <- function(path) setNames(as.list(rep("ACGT", 4)), c("a", "b", "c", "d"))
  env$fit_ml_tree <- function(aln, cfg) list(tree = ape::read.tree(text = "((a:1,b:2):1,(c:3,d:4):1);"))
  env$bootstrap.pml <- function(...) stop("forced diagnostic-only bootstrap failure")
  cfg <- list(min_taxa = 4, write_trees = FALSE, write_patristic = FALSE,
              bootstrap_reps = 100, seed = 42, mantel_perm = 9, mirror_perm = 9,
              context = "test", model = "GTR", opt_gamma = TRUE, opt_inv = FALSE)
  result <- env$process_pair(root, cfg)
  stopifnot(nrow(result) == 1, is.finite(result$mantel_r), is.finite(result$mantel_p))
  warnings <- readLines(file.path(root, paste0(basename(root), "_bootstrap_warnings.txt")))
  stopifnot(length(warnings) == 2, all(grepl("forced diagnostic-only", warnings)))
  unlink(root, recursive = TRUE)
  cat("PASS bootstrap errors do not filter Mantel:", script, "\n")
}
