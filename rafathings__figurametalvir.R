library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

# ============================================================
# INPUT
# ============================================================

xlsx_file <- "Data_AMR_Metal_Virulence..xlsx"

# ============================================================
# 1. CARGAR HOJAS
#    OJO: estaban al revés
# ============================================================

# METAL / BIOCIDE  -> sheet 3
Fig_metal <- read_excel(
  xlsx_file,
  sheet = 3,
  skip = 1,
  col_names = c(
    "Class",
    "Mean_per_size_SR",
    "Median_SR",
    "Total_SR",
    "Mean_per_size_MR",
    "Median_MR",
    "Total_MR",
    "U_stat",
    "p_value",
    "p_FDR",
    "Significant_FDR"
  )
) %>%
  filter(Class != "Class") %>%   # quitar cabecera duplicada
  mutate(
    Mean_per_size_SR = as.numeric(Mean_per_size_SR),
    Median_SR        = as.numeric(Median_SR),
    Total_SR         = as.numeric(Total_SR),
    Mean_per_size_MR = as.numeric(Mean_per_size_MR),
    Median_MR        = as.numeric(Median_MR),
    Total_MR         = as.numeric(Total_MR),
    U_stat           = as.numeric(U_stat),
    p_value          = as.numeric(p_value),
    p_FDR            = as.numeric(p_FDR)
  )

# VIRULENCE -> sheet 4
Fig_virulence <- read_excel(
  xlsx_file,
  sheet = 4,
  skip = 1,
  col_names = c(
    "Class",
    "Mean_per_size_SR",
    "Median_SR",
    "Total_SR",
    "Mean_per_size_MR",
    "Median_MR",
    "Total_MR",
    "U_stat",
    "p_value",
    "p_FDR",
    "Significant_FDR"
  )
) %>%
  filter(Class != "Class") %>%   # quitar cabecera duplicada
  mutate(
    Mean_per_size_SR = as.numeric(Mean_per_size_SR),
    Median_SR        = as.numeric(Median_SR),
    Total_SR         = as.numeric(Total_SR),
    Mean_per_size_MR = as.numeric(Mean_per_size_MR),
    Median_MR        = as.numeric(Median_MR),
    Total_MR         = as.numeric(Total_MR),
    U_stat           = as.numeric(U_stat),
    p_value          = as.numeric(p_value),
    p_FDR            = as.numeric(p_FDR)
  )

# comprobar
Fig_metal
Fig_virulence

# ============================================================
# 2. FUNCIÓN GENERAL
# ============================================================

make_top5_other_plot <- function(df, xlab_text = "Genes per kb", ylab_text = "Class") {
  
  df_top5_other <- df %>%
    arrange(desc(Mean_per_size_MR)) %>%
    slice_head(n = 5) %>%
    bind_rows(
      df %>%
        arrange(desc(Mean_per_size_MR)) %>%
        slice(-(1:5)) %>%
        summarise(
          Class = "Other",
          Mean_per_size_SR = mean(Mean_per_size_SR, na.rm = TRUE),
          Median_SR        = median(Median_SR, na.rm = TRUE),
          Total_SR         = sum(Total_SR, na.rm = TRUE),
          Mean_per_size_MR = mean(Mean_per_size_MR, na.rm = TRUE),
          Median_MR        = median(Median_MR, na.rm = TRUE),
          Total_MR         = sum(Total_MR, na.rm = TRUE),
          U_stat           = NA_real_,
          p_value          = NA_real_,
          p_FDR            = NA_real_,
          Significant_FDR  = NA
        )
    )
  
  df_long <- df_top5_other %>%
    select(
      Class,
      Mean_per_size_SR, Median_SR, Total_SR,
      Mean_per_size_MR, Median_MR, Total_MR
    ) %>%
    pivot_longer(
      cols = -Class,
      names_to = c(".value", "Replicon_Status"),
      names_pattern = "^(Mean_per_size|Median|Total)_(SR|MR)$"
    ) %>%
    mutate(
      Replicon_Status = recode(
        Replicon_Status,
        SR = "Single-replicon",
        MR = "Multi-replicon"
      )
    )
  
  y_lvls <- c(df_top5_other$Class[1:5], "Other")
  
  p <- df_long %>%
    mutate(Class = factor(Class, levels = rev(y_lvls))) %>%
    ggplot(aes(y = Class, x = Mean_per_size, color = Replicon_Status, fill = Replicon_Status)) +
    geom_col(alpha = 0.5, position = position_dodge(width = 0.9), width = 0.8) +
    theme_bw() +
    theme(
      panel.background = element_blank(),
      panel.grid = element_blank(),
      aspect.ratio = 1,
      strip.background = element_blank(),
      legend.position = c(0.98, 0.02),
      legend.justification = c(1, 0),
      legend.background = element_rect(fill = alpha("white", 0.7), colour = NA),
      legend.key.background = element_rect(fill = "transparent", colour = NA),
      axis.text.x = element_text(size = 11),
      axis.text.y = element_text(size = 11),
      axis.title = element_text(size = 13, face = "bold")
    ) +
    labs(x = xlab_text, y = ylab_text) +
    scale_fill_manual(
      values = c("#ff7d00ff", "#007991ff"),
      name = "Number of replicons"
    ) +
    scale_color_manual(
      values = c("#ca6300ff", "#007991ff"),
      name = "Number of replicons"
    )
  
  list(
    raw = df,
    top5_other = df_top5_other,
    long = df_long,
    plot = p
  )
}

# ============================================================
# 3. PLOTS
# ============================================================

metal_res <- make_top5_other_plot(
  Fig_metal,
  xlab_text = "Genes per kb",
  ylab_text = "Metal/biocide resistance class"
)

virulence_res <- make_top5_other_plot(
  Fig_virulence,
  xlab_text = "Genes per kb",
  ylab_text = "Virulence class"
)

Fig_metal_plot <- metal_res$plot
Fig_virulence_plot <- virulence_res$plot

Fig_metal_plot
Fig_virulence_plot
