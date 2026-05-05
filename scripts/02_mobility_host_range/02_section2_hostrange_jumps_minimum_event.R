library(tidyverse)
library(ggalluvial)

# If SVG export fails, install this once:
# install.packages("svglite")

OUTDIR <- "sankey_minimum_taxonomic_jump"
dir.create(OUTDIR, showWarnings = FALSE, recursive = TRUE)

jump_order <- c("family", "order", "class", "phylum")

# ============================================================
# LOAD
# ============================================================

df <- read.csv(
  "Supplementary_Dataset_2.xlsx",
  sep = "\t",
  stringsAsFactors = FALSE
)

required_cols <- c(
  "replicon",
  "baseline_family", "new_family",
  "baseline_order", "new_order",
  "baseline_class", "new_class",
  "baseline_phylum", "new_phylum",
  "n_events",
  "cointegrating_replicons",
  "taxonomic_jump"
)

missing_cols <- setdiff(required_cols, colnames(df))

if (length(missing_cols) > 0) {
  stop(
    "Missing required columns: ",
    paste(missing_cols, collapse = ", ")
  )
}

df <- df %>%
  mutate(
    n_events = as.numeric(n_events)
  )

# ============================================================
# CLEAN AND KEEP MINIMUM TAXONOMIC JUMP PER EVENT
# ============================================================

df2 <- df %>%
  mutate(
    taxonomic_jump = factor(
      taxonomic_jump,
      levels = jump_order,
      ordered = TRUE
    )
  ) %>%
  filter(!is.na(taxonomic_jump))

# Event identity approximation:
# replicon + destination taxonomy + cointegrating_replicons

df_min_only <- df2 %>%
  group_by(
    replicon,
    new_family,
    new_order,
    new_class,
    new_phylum,
    cointegrating_replicons
  ) %>%
  mutate(
    minimum_jump_num = min(as.integer(taxonomic_jump), na.rm = TRUE),
    minimum_jump = factor(
      jump_order[minimum_jump_num],
      levels = jump_order,
      ordered = TRUE
    )
  ) %>%
  ungroup() %>%
  filter(taxonomic_jump == minimum_jump) %>%
  mutate(
    taxonomic_jump = factor(
      as.character(minimum_jump),
      levels = jump_order,
      ordered = TRUE
    )
  ) %>%
  select(-minimum_jump_num, -minimum_jump)

# ============================================================
# CHOOSE TAXONOMIC LEVEL TO DISPLAY BY FACET
# ============================================================

df_plot <- df_min_only %>%
  mutate(
    baseline_taxon = case_when(
      taxonomic_jump == "family" ~ baseline_family,
      taxonomic_jump == "order"  ~ baseline_order,
      taxonomic_jump == "class"  ~ baseline_class,
      taxonomic_jump == "phylum" ~ baseline_phylum,
      TRUE ~ NA_character_
    ),
    new_taxon = case_when(
      taxonomic_jump == "family" ~ new_family,
      taxonomic_jump == "order"  ~ new_order,
      taxonomic_jump == "class"  ~ new_class,
      taxonomic_jump == "phylum" ~ new_phylum,
      TRUE ~ NA_character_
    )
  ) %>%
  filter(
    !is.na(baseline_taxon),
    !is.na(new_taxon),
    !is.na(replicon),
    !is.na(n_events)
  )

# ============================================================
# COLLAPSE FLOWS
# ============================================================

plot_df <- df_plot %>%
  group_by(taxonomic_jump, baseline_taxon, replicon, new_taxon) %>%
  summarise(
    n_events = sum(n_events, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    taxonomic_jump = factor(
      taxonomic_jump,
      levels = jump_order,
      ordered = TRUE
    )
  )

# ============================================================
# SUMMARIES
# ============================================================

updated_summary <- plot_df %>%
  group_by(taxonomic_jump) %>%
  summarise(
    n_flows = n(),
    n_replicons = n_distinct(replicon),
    n_baseline_taxa = n_distinct(baseline_taxon),
    n_new_taxa = n_distinct(new_taxon),
    n_events = sum(n_events, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  complete(
    taxonomic_jump = factor(jump_order, levels = jump_order, ordered = TRUE),
    fill = list(
      n_flows = 0,
      n_replicons = 0,
      n_baseline_taxa = 0,
      n_new_taxa = 0,
      n_events = 0
    )
  ) %>%
  mutate(
    percent_events = if (sum(n_events) > 0) {
      100 * n_events / sum(n_events)
    } else {
      0
    }
  )

updated_by_replicon <- plot_df %>%
  group_by(taxonomic_jump, replicon) %>%
  summarise(
    n_events = sum(n_events, na.rm = TRUE),
    n_flows = n(),
    baseline_taxa = paste(sort(unique(baseline_taxon)), collapse = "; "),
    new_taxa = paste(sort(unique(new_taxon)), collapse = "; "),
    .groups = "drop"
  ) %>%
  arrange(taxonomic_jump, desc(n_events), replicon)

replicon_summary_by_taxonomic_level <- plot_df %>%
  group_by(taxonomic_jump) %>%
  summarise(
    n_distinct_replicons = n_distinct(replicon),
    n_flows = n(),
    n_events = sum(n_events, na.rm = TRUE),
    replicons = paste(sort(unique(replicon)), collapse = "; "),
    .groups = "drop"
  ) %>%
  complete(
    taxonomic_jump = factor(jump_order, levels = jump_order, ordered = TRUE),
    fill = list(
      n_distinct_replicons = 0,
      n_flows = 0,
      n_events = 0,
      replicons = ""
    )
  ) %>%
  arrange(taxonomic_jump)

all_flows <- plot_df %>%
  arrange(taxonomic_jump, replicon, baseline_taxon, new_taxon) %>%
  group_by(taxonomic_jump) %>%
  mutate(
    flow_id = row_number(),
    flow = paste(baseline_taxon, "->", replicon, "->", new_taxon)
  ) %>%
  ungroup() %>%
  select(
    taxonomic_jump,
    flow_id,
    baseline_taxon,
    replicon,
    new_taxon,
    n_events,
    flow
  )

order_flows <- all_flows %>%
  filter(as.character(taxonomic_jump) == "order")

print(updated_summary)
print(updated_by_replicon)
print(replicon_summary_by_taxonomic_level)
print(order_flows, n = Inf)

readr::write_tsv(
  updated_summary,
  file.path(OUTDIR, "taxonomic_jump_summary_minimum.tsv")
)

readr::write_tsv(
  updated_by_replicon,
  file.path(OUTDIR, "taxonomic_jump_by_replicon_minimum.tsv")
)

readr::write_tsv(
  replicon_summary_by_taxonomic_level,
  file.path(OUTDIR, "distinct_replicons_by_taxonomic_level.tsv")
)

readr::write_tsv(
  plot_df,
  file.path(OUTDIR, "sankey_minimum_plot_data.tsv")
)

readr::write_tsv(
  all_flows,
  file.path(OUTDIR, "all_flows_represented.tsv")
)

readr::write_tsv(
  order_flows,
  file.path(OUTDIR, "flows_represented_order.tsv")
)

# ============================================================
# ORDERING FUNCTION
# ============================================================

order_plot_df <- function(dat, weight_col = "plot_weight") {
  
  baseline_levels <- dat %>%
    group_by(baseline_taxon) %>%
    summarise(
      w = sum(.data[[weight_col]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    arrange(desc(w), baseline_taxon) %>%
    pull(baseline_taxon)
  
  replicon_levels <- dat %>%
    group_by(replicon) %>%
    summarise(
      w = sum(.data[[weight_col]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    arrange(desc(w), replicon) %>%
    pull(replicon)
  
  new_levels <- dat %>%
    group_by(new_taxon) %>%
    summarise(
      w = sum(.data[[weight_col]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    arrange(desc(w), new_taxon) %>%
    pull(new_taxon)
  
  dat %>%
    mutate(
      baseline_taxon = factor(baseline_taxon, levels = baseline_levels),
      replicon = factor(replicon, levels = replicon_levels),
      new_taxon = factor(new_taxon, levels = new_levels)
    )
}

# ============================================================
# COLOUR HELPERS
# ============================================================

lighten_col <- function(col, amount = 0.45) {
  rgb_col <- grDevices::col2rgb(col) / 255
  rgb_new <- rgb_col + (1 - rgb_col) * amount
  grDevices::rgb(rgb_new[1], rgb_new[2], rgb_new[3])
}

darken_col <- function(col, amount = 0.30) {
  rgb_col <- grDevices::col2rgb(col) / 255
  rgb_new <- rgb_col * (1 - amount)
  grDevices::rgb(rgb_new[1], rgb_new[2], rgb_new[3])
}

make_shades <- function(base_col, n) {
  if (n == 1) return(base_col)
  
  grDevices::colorRampPalette(
    c(
      lighten_col(base_col, amount = 0.40),
      base_col,
      darken_col(base_col, amount = 0.30)
    )
  )(n)
}

make_fill_values <- function(dat,
                             base_cols = c(
                               family = "#f7d769",
                               order  = "#0e9a85",
                               class  = "#007991ff",
                               phylum = "#ff7d00ff"
                             )) {
  
  key <- dat %>%
    group_by(taxonomic_jump, replicon) %>%
    summarise(
      total_weight = sum(plot_weight, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    mutate(
      fill_id = paste(taxonomic_jump, replicon, sep = "__")
    )
  
  fill_values <- c()
  
  for (jump in levels(dat$taxonomic_jump)) {
    
    reps <- key %>%
      filter(taxonomic_jump == jump) %>%
      arrange(desc(total_weight), replicon)
    
    if (nrow(reps) == 0) next
    
    cols <- make_shades(base_cols[[jump]], nrow(reps))
    names(cols) <- reps$fill_id
    
    fill_values <- c(fill_values, cols)
  }
  
  fill_values
}

# ============================================================
# PLOT FUNCTION
# ============================================================

make_sankey <- function(dat,
                        weighted = FALSE,
                        normalise_to = c("replicon", "taxa", "none"),
                        box_width = 0.30,
                        label_size = 2.3,
                        wrap_width = 12,
                        min_replicon_height = NULL,
                        base_cols = c(
                          family = "#f7d769",
                          order  = "#0e9a85",
                          class  = "#007991ff",
                          phylum = "#ff7d00ff"
                        )) {
  
  normalise_to <- match.arg(normalise_to)
  
  if (weighted) {
    dat_plot <- dat %>%
      mutate(raw_weight = n_events)
    
    title_lab <- "Minimum host-range expansion jumps"
    
  } else {
    dat_plot <- dat %>%
      mutate(raw_weight = 1)
    
    title_lab <- "Minimum host-range expansion jumps"
  }
  
  # ----------------------------------------------------------
  # Normalisation
  # ----------------------------------------------------------
  
  if (normalise_to == "replicon") {
    
    # Each replicon has total height = 1 within each facet.
    # With fixed y-scales, this is comparable across facets.
    dat_plot <- dat_plot %>%
      group_by(taxonomic_jump, replicon) %>%
      mutate(
        plot_weight = raw_weight / sum(raw_weight, na.rm = TRUE)
      ) %>%
      ungroup()
    
    title_lab <- paste0(title_lab, " | equal-size replicons")
    
  } else if (normalise_to == "taxa") {
    
    dat_plot <- dat_plot %>%
      add_count(
        taxonomic_jump,
        baseline_taxon,
        wt = raw_weight,
        name = "baseline_total"
      ) %>%
      add_count(
        taxonomic_jump,
        new_taxon,
        wt = raw_weight,
        name = "new_total"
      ) %>%
      mutate(
        plot_weight = raw_weight / sqrt(baseline_total * new_total)
      ) %>%
      select(-baseline_total, -new_total)
    
    title_lab <- paste0(title_lab, " | normalised by baseline and new taxa")
    
  } else {
    
    dat_plot <- dat_plot %>%
      mutate(plot_weight = raw_weight)
    
    title_lab <- paste0(title_lab, " | no normalisation")
  }
  
  # ----------------------------------------------------------
  # Optional minimum replicon height
  # Do not use this if normalise_to = "replicon" and you want
  # all replicons exactly equal.
  # ----------------------------------------------------------
  
  if (!is.null(min_replicon_height)) {
    
    dat_plot <- dat_plot %>%
      group_by(taxonomic_jump, replicon) %>%
      mutate(
        replicon_total = sum(plot_weight, na.rm = TRUE),
        inflate_factor = if_else(
          replicon_total < min_replicon_height,
          min_replicon_height / replicon_total,
          1
        ),
        plot_weight = plot_weight * inflate_factor
      ) %>%
      ungroup() %>%
      select(-replicon_total, -inflate_factor)
    
    title_lab <- paste0(title_lab, " | minimum replicon height applied")
  }
  
  # ----------------------------------------------------------
  # Order and create explicit flow identity
  # ----------------------------------------------------------
  
  dat_plot <- dat_plot %>%
    order_plot_df(weight_col = "plot_weight") %>%
    mutate(
      flow_id = row_number(),
      flow_id = paste(taxonomic_jump, flow_id, sep = "__"),
      fill_id = paste(taxonomic_jump, replicon, sep = "__")
    )
  
  fill_values <- make_fill_values(dat_plot, base_cols = base_cols)
  
  # ----------------------------------------------------------
  # Store factor levels for axis-specific stratum ordering
  # ----------------------------------------------------------
  
  baseline_levels <- levels(dat_plot$baseline_taxon)
  replicon_levels <- levels(dat_plot$replicon)
  new_levels <- levels(dat_plot$new_taxon)
  
  stratum_levels <- c(
    paste("Baseline taxon", baseline_levels, sep = "__"),
    paste("Replicon", replicon_levels, sep = "__"),
    paste("New taxon", new_levels, sep = "__")
  )
  
  # ----------------------------------------------------------
  # Convert to explicit lodes format
  # This guarantees:
  # baseline_taxon -> replicon -> new_taxon
  # ----------------------------------------------------------
  
  lodes_df <- dat_plot %>%
    select(
      flow_id,
      taxonomic_jump,
      baseline_taxon,
      replicon,
      new_taxon,
      plot_weight,
      fill_id
    ) %>%
    pivot_longer(
      cols = c(baseline_taxon, replicon, new_taxon),
      names_to = "axis_raw",
      values_to = "stratum_label"
    ) %>%
    mutate(
      axis = factor(
        axis_raw,
        levels = c("baseline_taxon", "replicon", "new_taxon"),
        labels = c("Baseline taxon", "Replicon", "New taxon")
      ),
      
      stratum_label = as.character(stratum_label),
      
      # Critical fix:
      # The same taxon name on different axes is treated as a different stratum.
      # Example:
      # Baseline taxon__Bacillales != New taxon__Bacillales
      stratum_id = paste(axis, stratum_label, sep = "__"),
      stratum_id = factor(stratum_id, levels = stratum_levels)
    ) %>%
    select(-axis_raw)
  
  # Safety check 1:
  # Each flow must have exactly three points.
  bad_flows <- lodes_df %>%
    count(taxonomic_jump, flow_id) %>%
    filter(n != 3)
  
  if (nrow(bad_flows) > 0) {
    stop("Some flows do not have exactly three steps: baseline -> replicon -> new.")
  }
  
  # Safety check 2:
  # Save the final explicit paths used for plotting.
  readr::write_tsv(
    lodes_df,
    file.path(OUTDIR, "sankey_lodes_explicit_paths.tsv")
  )
  
  # ----------------------------------------------------------
  # Plot
  # ----------------------------------------------------------
  
  ggplot(
    lodes_df,
    aes(
      x = axis,
      stratum = stratum_id,
      alluvium = flow_id,
      y = plot_weight
    )
  ) +
    geom_alluvium(
      aes(fill = fill_id),
      width = box_width,
      alpha = 0.85,
      knot.pos = 0.35,
      decreasing = FALSE
    ) +
    geom_stratum(
      width = box_width,
      fill = "grey92",
      color = "black",
      linewidth = 0.25
    ) +
    geom_text(
      stat = "stratum",
      aes(
        label = stringr::str_wrap(
          stringr::str_remove(
            as.character(after_stat(stratum)),
            "^.*__"
          ),
          width = wrap_width
        )
      ),
      size = label_size,
      lineheight = 0.9
    ) +
    scale_x_discrete(
      limits = c("Baseline taxon", "Replicon", "New taxon"),
      expand = c(0.12, 0.12)
    ) +
    facet_wrap(~ taxonomic_jump, scales = "fixed") +
    scale_fill_manual(values = fill_values, drop = FALSE) +
    labs(
      x = NULL,
      y = "Normalised weight",
      title = title_lab,
      fill = "Replicon"
    ) +
    theme_bw(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 13),
      strip.background = element_rect(fill = "grey95", color = "black"),
      strip.text = element_text(face = "bold"),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid = element_blank(),
      legend.position = "none"
    )
}

# ============================================================
# FINAL PLOT: EQUAL REPLICON HEIGHTS
# ============================================================

p_final <- make_sankey(
  plot_df,
  weighted = FALSE,
  normalise_to = "replicon",
  box_width = 0.30,
  label_size = 2.3,
  wrap_width = 12,
  min_replicon_height = NULL,
  base_cols = c(
    family = "#f7d769",
    order  = "#0e9a85",
    class  = "#007991ff",
    phylum = "#ff7d00ff"
  )
)

print(p_final)

# ============================================================
# SAVE OUTPUTS
# ============================================================

ggsave(
  filename = file.path(OUTDIR, "sankey_minimum_taxonomic_jump_equal_replicons.pdf"),
  plot = p_final,
  width = 16,
  height = 10
)

ggsave(
  filename = file.path(OUTDIR, "sankey_minimum_taxonomic_jump_equal_replicons.png"),
  plot = p_final,
  width = 16,
  height = 10,
  dpi = 300
)

ggsave(
  filename = file.path(OUTDIR, "sankey_minimum_taxonomic_jump_equal_replicons.svg"),
  plot = p_final,
  width = 16,
  height = 10,
  device = "svg"
)

# ============================================================
# PRINT FINAL LABELS FOR MANUSCRIPT
# ============================================================

cat("\nUpdated event summary:\n")

updated_summary %>%
  mutate(
    label = paste0(
      as.character(taxonomic_jump),
      ": ",
      n_events,
      " events (",
      round(percent_events, 1),
      "%), ",
      n_replicons,
      " replicons, ",
      n_flows,
      " flows"
    )
  ) %>%
  pull(label) %>%
  cat(sep = "\n")

cat("\n\nDistinct replicons by taxonomic level:\n")

replicon_summary_by_taxonomic_level %>%
  mutate(
    label = paste0(
      as.character(taxonomic_jump),
      ": ",
      n_distinct_replicons,
      " distinct replicons, ",
      n_events,
      " events, ",
      n_flows,
      " flows"
    )
  ) %>%
  pull(label) %>%
  cat(sep = "\n")

cat("\n\nFiles written to: ", OUTDIR, "\n")
