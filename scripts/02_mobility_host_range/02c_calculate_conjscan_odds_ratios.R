#!/usr/bin/env Rscript

# Odds ratios for each ConjScan Likely-System call.
# The adjusted analyses use the same covariates as the MOB-typer analyses:
# plasmid length, host genus, and isolation source.

options(stringsAsFactors = FALSE)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 3) {
  stop("Usage: Rscript 02c_calculate_conjscan_odds_ratios.R <conjscan_counts.tsv> <covariates.tsv> <output.tsv>")
}
calls_path <- args[[1]]
covariate_path <- args[[2]]
output_path <- args[[3]]
dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

calls <- read.delim(
  calls_path,
  sep = "\t",
  check.names = FALSE,
  quote = "",
  comment.char = ""
)
covariates <- read.delim(
  covariate_path,
  sep = "\t",
  check.names = FALSE,
  quote = "",
  comment.char = ""
)

if (anyDuplicated(calls$plasmid_id) || anyDuplicated(covariates$plasmid_id)) {
  stop("Plasmid identifiers must be unique in both input tables.")
}
if (!setequal(calls$plasmid_id, covariates$plasmid_id)) {
  stop("ConjScan and covariate tables do not contain the same plasmids.")
}

covariates <- covariates[
  match(calls$plasmid_id, covariates$plasmid_id),
  ,
  drop = FALSE
]
if (!identical(calls$plasmid_id, covariates$plasmid_id)) {
  stop("Failed to align plasmids between input tables.")
}

analysis <- data.frame(
  plasmid_id = calls$plasmid_id,
  multireplicon_status = as.numeric(covariates$multireplicon_status),
  log10_length = as.numeric(covariates$log10_length),
  host_genus_model = factor(covariates$host_genus_model),
  source_model = factor(covariates$source_model)
)

call_columns <- grep("^n_", names(calls), value = TRUE)
call_columns <- setdiff(call_columns, "n_all_likely_systems")

result_rows <- vector("list", length(call_columns))
for (i in seq_along(call_columns)) {
  column_name <- call_columns[[i]]
  call_name <- sub("^n_", "", column_name)
  outcome <- as.numeric(calls[[column_name]] > 0)
  analysis$outcome <- outcome

  multi <- analysis$multireplicon_status == 1
  single <- !multi
  multi_positive <- sum(outcome[multi] == 1)
  multi_negative <- sum(outcome[multi] == 0)
  single_positive <- sum(outcome[single] == 1)
  single_negative <- sum(outcome[single] == 0)

  contingency <- matrix(
    c(
      multi_positive,
      multi_negative,
      single_positive,
      single_negative
    ),
    nrow = 2,
    byrow = TRUE,
    dimnames = list(
      replicon_status = c("Multi-replicon", "Single-replicon"),
      call = c("Present", "Absent")
    )
  )
  fisher <- fisher.test(contingency)

  adjusted <- glm(
    outcome ~ multireplicon_status + log10_length +
      host_genus_model + source_model,
    data = analysis,
    family = binomial()
  )
  coefficient <- summary(adjusted)$coefficients[
    "multireplicon_status",
    ,
    drop = FALSE
  ]
  estimate <- coefficient[1, "Estimate"]
  standard_error <- coefficient[1, "Std. Error"]

  result_rows[[i]] <- data.frame(
    conjscan_call = call_name,
    single_positive = single_positive,
    single_total = sum(single),
    single_percent = 100 * single_positive / sum(single),
    multi_positive = multi_positive,
    multi_total = sum(multi),
    multi_percent = 100 * multi_positive / sum(multi),
    unadjusted_OR = unname(fisher$estimate),
    unadjusted_CI_low = fisher$conf.int[[1]],
    unadjusted_CI_high = fisher$conf.int[[2]],
    unadjusted_p_value = fisher$p.value,
    adjusted_OR = exp(estimate),
    adjusted_CI_low = exp(estimate - 1.96 * standard_error),
    adjusted_CI_high = exp(estimate + 1.96 * standard_error),
    adjusted_p_value = coefficient[1, "Pr(>|z|)"],
    adjusted_n = nrow(analysis),
    adjusted_converged = adjusted$converged
  )
}

results <- do.call(rbind, result_rows)
results$unadjusted_FDR <- p.adjust(
  results$unadjusted_p_value,
  method = "BH"
)
results$adjusted_FDR <- p.adjust(
  results$adjusted_p_value,
  method = "BH"
)
results$unadjusted_OR_95CI <- sprintf(
  "%.2f (%.2f–%.2f)",
  results$unadjusted_OR,
  results$unadjusted_CI_low,
  results$unadjusted_CI_high
)
results$adjusted_OR_95CI <- sprintf(
  "%.2f (%.2f–%.2f)",
  results$adjusted_OR,
  results$adjusted_CI_low,
  results$adjusted_CI_high
)

results <- results[
  order(-pmax(results$single_percent, results$multi_percent)),
  ,
  drop = FALSE
]

write.table(
  results,
  output_path,
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

cat("ConjScan odds-ratio table written to:\n", output_path, "\n", sep = "")
