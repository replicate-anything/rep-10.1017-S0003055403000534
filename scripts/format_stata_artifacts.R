study <- normalizePath(".", winslash = "/", mustWork = FALSE)
source(file.path(study, "code/format_stata.R"))

artifact_dir <- file.path(study, "artifacts")
staging_dir <- file.path(artifact_dir, "staging")
dir.create(artifact_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(staging_dir, recursive = TRUE, showWarnings = FALSE)

id <- "tab_1_stata"
log_path <- file.path(staging_dir, paste0(id, ".log"))
out_path <- file.path(artifact_dir, paste0(id, ".html"))
if (!file.exists(log_path)) {
  stop("Stata log missing at ", log_path, call. = FALSE)
}
html <- format_stata_log(list(output_path = log_path))
writeLines(html, out_path, useBytes = TRUE)
message("Wrote ", out_path)

manifest_path <- file.path(artifact_dir, "manifest.json")
manifest <- if (file.exists(manifest_path)) {
  jsonlite::fromJSON(manifest_path, simplifyVector = FALSE)
} else {
  list(
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    folder = basename(study),
    doi = "10.1017/s0003055403000534",
    replications = list()
  )
}
manifest$replications[[id]] <- list(
  status = "ok",
  artifact = paste0("artifacts/", id, ".html"),
  format = "html"
)
jsonlite::write_json(manifest, manifest_path, auto_unbox = TRUE, pretty = TRUE)
message("Updated ", manifest_path)
