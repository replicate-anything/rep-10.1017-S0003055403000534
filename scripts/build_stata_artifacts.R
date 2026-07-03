study <- normalizePath(".", winslash = "/", mustWork = FALSE)
stata <- Sys.which("StataMP-64")
if (!nzchar(stata)) {
  stata <- "C:/Program Files/Stata17/StataMP-64.exe"
}
if (!file.exists(stata)) {
  stop("Stata executable not found.")
}

old_wd <- getwd()
on.exit(setwd(old_wd), add = TRUE)

do_file <- file.path("code", "tab_1.do")
message("Running ", do_file, " ...")
setwd(study)
status <- system2(
  stata,
  c("/e", "do", shQuote(do_file, type = "cmd")),
  wait = TRUE,
  stdout = "",
  stderr = ""
)
log_path <- file.path(study, "artifacts/staging", "tab_1_stata.log")
if (!file.exists(log_path)) {
  stop("Expected log not found after tab_1.do (status=", status, ")", call. = FALSE)
}

stray <- list.files(study, pattern = "^replicate_.*\\.log$", full.names = TRUE)
if (length(stray)) {
  unlink(stray)
}

source(file.path(study, "scripts/format_stata_artifacts.R"))
