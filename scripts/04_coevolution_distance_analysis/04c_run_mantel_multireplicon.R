#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(phangorn)
  library(ape)
  library(vegan)
})

parse_args <- function(default_context) {
  args <- commandArgs(trailingOnly = TRUE)
  cfg <- list(
    input_dir = NULL,
    out_file = NULL,
    context = default_context,
    model = "GTR",
    opt_gamma = TRUE,
    opt_inv = FALSE,
    mantel_perm = 9999,
    mirror_perm = 2000,
    min_taxa = 4,
    seed = 42,
    write_trees = TRUE,
    write_patristic = TRUE
  )

  i <- 1
  while (i <= length(args)) {
    key <- args[[i]]
    val <- if (i < length(args)) args[[i + 1]] else NA

    if (key == "--input-dir") { cfg$input_dir <- val; i <- i + 2; next }
    if (key == "--out-file") { cfg$out_file <- val; i <- i + 2; next }
    if (key == "--context") { cfg$context <- val; i <- i + 2; next }
    if (key == "--model") { cfg$model <- val; i <- i + 2; next }
    if (key == "--opt-gamma") { cfg$opt_gamma <- as.logical(val); i <- i + 2; next }
    if (key == "--opt-inv") { cfg$opt_inv <- as.logical(val); i <- i + 2; next }
    if (key == "--mantel-perm") { cfg$mantel_perm <- as.integer(val); i <- i + 2; next }
    if (key == "--mirror-perm") { cfg$mirror_perm <- as.integer(val); i <- i + 2; next }
    if (key == "--min-taxa") { cfg$min_taxa <- as.integer(val); i <- i + 2; next }
    if (key == "--seed") { cfg$seed <- as.integer(val); i <- i + 2; next }
    if (key == "--write-trees") { cfg$write_trees <- as.logical(val); i <- i + 2; next }
    if (key == "--write-patristic") { cfg$write_patristic <- as.logical(val); i <- i + 2; next }

    stop(paste("Unknown argument:", key))
  }

  if (is.null(cfg$input_dir)) stop("--input-dir is required")
  if (is.null(cfg$out_file)) {
    cfg$out_file <- file.path(cfg$input_dir, paste0(cfg$context, "_pairwise_mantel_results.tsv"))
  }

  return(cfg)
}

rep_name_from_alignment <- function(path) {
  x <- basename(path)
  x <- sub("_all_aligned\\.f(ast)?a$", "", x)
  x <- sub("_aligned\\.f(ast)?a$", "", x)
  x <- sub("\\.f(ast)?a$", "", x)
  return(x)
}

tip_id <- function(x) {
  # FASTA headers are >plasmid|replicon... or >assembly|replicon...
  # The first token is the shared observation identifier.
  y <- sub("\\|.*$", "", x)
  y <- sub("\\s.*$", "", y)
  return(y)
}

safe_pair <- function(a, b) {
  paste(sort(c(a, b)), collapse = "__")
}

read_alignment <- function(path) {
  aln <- read.phyDat(path, format = "fasta", type = "DNA")
  ids <- vapply(names(aln), tip_id, character(1), USE.NAMES = FALSE)

  # Keep first occurrence if duplicate identifiers exist.
  if (any(duplicated(ids))) {
    keep <- !duplicated(ids)
    aln <- aln[keep]
    ids <- ids[keep]
  }

  names(aln) <- ids
  return(aln)
}

fit_ml_tree <- function(aln, cfg) {
  d <- dist.ml(aln)
  start <- NJ(d)
  fit0 <- pml(start, data = aln)
  fit <- optim.pml(
    fit0,
    model = cfg$model,
    optGamma = cfg$opt_gamma,
    optInv = cfg$opt_inv,
    control = pml.control(trace = 0)
  )
  return(fit$tree)
}

process_pair <- function(pair_dir, cfg) {
  aligned <- list.files(
    pair_dir,
    pattern = "_all_aligned\\.f(ast)?a$|_aligned\\.f(ast)?a$",
    full.names = TRUE
  )

  if (length(aligned) < 2) {
    stop("fewer_than_two_aligned_fastas")
  }

  aligned <- sort(aligned)[1:2]
  aln_a_path <- aligned[[1]]
  aln_b_path <- aligned[[2]]

  repA <- rep_name_from_alignment(aln_a_path)
  repB <- rep_name_from_alignment(aln_b_path)
  pair_label <- basename(pair_dir)

  cat("=== Processing:", pair_label, "\n")
  cat("  ", repA, ":", aln_a_path, "\n")
  cat("  ", repB, ":", aln_b_path, "\n")

  aln1 <- read_alignment(aln_a_path)
  aln2 <- read_alignment(aln_b_path)

  if (length(aln1) < cfg$min_taxa || length(aln2) < cfg$min_taxa) {
    stop("too_few_sequences_before_tree")
  }

  tree1 <- fit_ml_tree(aln1, cfg)
  tree2 <- fit_ml_tree(aln2, cfg)

  out_prefix <- file.path(pair_dir, pair_label)

  if (cfg$write_trees) {
    write.tree(tree1, file = paste0(out_prefix, "_", repA, "_ML.tree"))
    write.tree(tree2, file = paste0(out_prefix, "_", repB, "_ML.tree"))
  }

  D1 <- as.matrix(cophenetic.phylo(tree1)); diag(D1) <- 0
  D2 <- as.matrix(cophenetic.phylo(tree2)); diag(D2) <- 0

  common <- intersect(rownames(D1), rownames(D2))
  if (length(common) < cfg$min_taxa) {
    stop("too_few_common_taxa")
  }

  D1c <- D1[common, common]
  D2c <- D2[common, common]

  if (cfg$write_patristic) {
    write.table(D1c, file = paste0(out_prefix, "_", repA, "_patristic.tsv"), sep = "\t", quote = FALSE)
    write.table(D2c, file = paste0(out_prefix, "_", repB, "_patristic.tsv"), sep = "\t", quote = FALSE)
  }

  set.seed(cfg$seed)
  mant <- mantel(
    as.dist(D1c),
    as.dist(D2c),
    method = "pearson",
    permutations = cfg$mantel_perm
  )

  v1 <- as.vector(as.dist(D1c))
  v2 <- as.vector(as.dist(D2c))
  mirror_r <- cor(v1, v2, method = "pearson")

  set.seed(cfg$seed)
  labels <- rownames(D1c)
  perm_cor <- numeric(cfg$mirror_perm)

  for (i in seq_len(cfg$mirror_perm)) {
    perm <- sample(labels)
    D2perm <- D2c[perm, perm]
    perm_cor[[i]] <- cor(as.vector(as.dist(D1c)), as.vector(as.dist(D2perm)), method = "pearson")
  }

  mirror_p_emp <- (sum(abs(perm_cor) >= abs(mirror_r)) + 1) / (cfg$mirror_perm + 1)

  data.frame(
    context = cfg$context,
    pair = pair_label,
    pair_clean = safe_pair(repA, repB),
    repA = repA,
    repB = repB,
    alnA = aln_a_path,
    alnB = aln_b_path,
    n_taxa = length(common),
    mantel_r = as.numeric(mant$statistic),
    mantel_p = as.numeric(mant$signif),
    mirror_r = as.numeric(mirror_r),
    mirror_p_emp = as.numeric(mirror_p_emp),
    model = cfg$model,
    opt_gamma = cfg$opt_gamma,
    opt_inv = cfg$opt_inv,
    mantel_perm = cfg$mantel_perm,
    mirror_perm = cfg$mirror_perm,
    stringsAsFactors = FALSE
  )
}

run_pipeline <- function(default_context) {
  cfg <- parse_args(default_context)

  dirs <- list.dirs(cfg$input_dir, recursive = FALSE, full.names = TRUE)
  if (length(dirs) == 0) stop("No pair directories found in --input-dir")

  results <- data.frame()
  failures <- data.frame(
    pair = character(),
    error = character(),
    stringsAsFactors = FALSE
  )

  for (d in dirs) {
    pair_label <- basename(d)

    res <- tryCatch(
      process_pair(d, cfg),
      error = function(e) {
        cat("[FAIL]", pair_label, "->", conditionMessage(e), "\n")
        failures <<- rbind(
          failures,
          data.frame(pair = pair_label, error = conditionMessage(e), stringsAsFactors = FALSE)
        )
        NULL
      }
    )

    if (!is.null(res)) {
      results <- rbind(results, res)
    }
  }

  write.table(results, file = cfg$out_file, sep = "\t", quote = FALSE, row.names = FALSE)

  failures_file <- sub("\\.tsv$", "_failures.tsv", cfg$out_file)
  if (failures_file == cfg$out_file) failures_file <- paste0(cfg$out_file, "_failures.tsv")

  write.table(failures, file = failures_file, sep = "\t", quote = FALSE, row.names = FALSE)

  cat("Wrote results to:", cfg$out_file, "\n")
  cat("Wrote failures to:", failures_file, "\n")
}

run_pipeline("multireplicon")
