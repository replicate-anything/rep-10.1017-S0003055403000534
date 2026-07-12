# Analysis dataset — Fearon & Laitin (2003)
# Study repo: rep-10.1017-S0003055403000534

make_analysis_data <- function(data) {
  df <- data

  # Stata variable lpopl is stored as lpopl1 in the replication data set.
  df$lpopl <- df$lpopl1

  # Data not actually binary but treated as binary by Stata
  for (v in c("onset", "ethonset", "emponset", "cowonset")) {
    df[[v]] <- ifelse(df[[v]] >= 1, 1, 0)
  }

  root <- Sys.getenv("REPLICATE_STUDY_ROOT", unset = "")
  if (!nzchar(root)) {
    root <- normalizePath(file.path(".."), winslash = "/", mustWork = FALSE)
  }
  out_dir <- file.path(root, "outputs")
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  saveRDS(df, file.path(out_dir, "analysis_data.rds"))
  haven::write_dta(df, file.path(out_dir, "analysis_data.dta"))

  df
}
