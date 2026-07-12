DOI <- "10.1017/S0003055403000534"
WHAT <- "tab_1"
FOLDER <- "10.1017S0003055403000534"
STUDY_REPO <- "replicate-anything/rep-10.1017-S0003055403000534"

study_test_context <- function() {
  study_root <- normalizePath(
    testthat::test_path("..", ".."),
    winslash = "/",
    mustWork = FALSE
  )
  registry_root <- normalizePath(
    file.path(study_root, "..", "registry"),
    winslash = "/",
    mustWork = FALSE
  )
  monorepo_root <- normalizePath(
    file.path(study_root, ".."),
    winslash = "/",
    mustWork = FALSE
  )

  local_index <- data.frame(
    folder = FOLDER,
    doi = paste0("https://doi.org/", DOI),
    title = "Ethnicity, Insurgency, and Civil War",
    journal = "APSR",
    year = 2003,
    authors = "Fearon, Laitin",
    repo = STUDY_REPO,
    stringsAsFactors = FALSE
  )

  list(
    study_root = study_root,
    registry_root = registry_root,
    monorepo_root = monorepo_root,
    local_index = local_index
  )
}

compact_html <- function(html) {
  html <- replicateEverything::normalize_html_table(as.character(html))
  gsub("\\s+", "", html)
}

test_that("run_replication executes tab_1", {
  testthat::skip_if_not_installed("replicateEverything")
  testthat::skip_if_not_installed("haven")
  testthat::skip_if_not_installed("modelsummary")
  testthat::skip_if_not_installed("kableExtra")

  ctx <- study_test_context()
  testthat::skip_if_not(dir.exists(ctx$registry_root), "registry checkout missing")
  testthat::skip_if_not(
    file.exists(file.path(ctx$study_root, "data", "repdata.dta")),
    "study data missing"
  )

  withr::with_options(
    list(
      replicateEverything.registry_root = ctx$registry_root,
      replicateEverything.index = ctx$local_index,
      replicateEverything.use_sibling_packages = TRUE,
      replicateEverything.study_folders_root = ctx$monorepo_root
    ),
    {
      models <- replicateEverything::run_replication(DOI, WHAT)
      testthat::expect_type(models, "list")
      testthat::expect_length(models, 5L)
      testthat::expect_true(all(vapply(models, inherits, logical(1), "glm")))

      source(file.path(ctx$study_root, "tests/substantive/tab_1.R"), local = TRUE)
      substantive_check_tab_1(models)
    }
  )
})

test_that("tab_1 matches published Table 1 prior-war benchmarks", {
  testthat::skip_if_not_installed("replicateEverything")
  testthat::skip_if_not_installed("haven")

  ctx <- study_test_context()
  testthat::skip_if_not(dir.exists(ctx$registry_root), "registry checkout missing")
  testthat::skip_if_not(
    file.exists(file.path(ctx$study_root, "data", "repdata.dta")),
    "study data missing"
  )

  withr::with_options(
    list(
      replicateEverything.registry_root = ctx$registry_root,
      replicateEverything.index = ctx$local_index,
      replicateEverything.use_sibling_packages = TRUE,
      replicateEverything.study_folders_root = ctx$monorepo_root
    ),
    {
      models <- replicateEverything::run_replication(DOI, WHAT)
      source(file.path(ctx$study_root, "tests/substantive/tab_1.R"), local = TRUE)
      replicateEverything::check_glm_table_benchmark(
        models,
        tab_1_prior_war_benchmark()
      )
    }
  )
})

test_that("formatted live table matches precomputed artifact", {
  testthat::skip_if_not_installed("replicateEverything")
  testthat::skip_if_not_installed("haven")
  testthat::skip_if_not_installed("modelsummary")
  testthat::skip_if_not_installed("kableExtra")

  ctx <- study_test_context()
  testthat::skip_if_not(dir.exists(ctx$registry_root), "registry checkout missing")
  artifact_path <- file.path(ctx$study_root, "outputs", "tab_1.html")
  testthat::skip_if_not(file.exists(artifact_path), "tab_1 artifact missing")

  withr::with_options(
    list(
      replicateEverything.registry_root = ctx$registry_root,
      replicateEverything.index = ctx$local_index,
      replicateEverything.use_sibling_packages = TRUE,
      replicateEverything.study_folders_root = ctx$monorepo_root
    ),
    {
      models <- replicateEverything::run_replication(DOI, WHAT)
      live_html <- replicateEverything::format_for_display(
        models,
        DOI,
        WHAT,
        folder = FOLDER
      )
      artifact_html <- replicateEverything::load_artifact(
        DOI,
        WHAT,
        folder = FOLDER
      )

      testthat::expect_true(grepl("<table", live_html, ignore.case = TRUE))
      testthat::expect_true(grepl("<table", artifact_html, ignore.case = TRUE))
      testthat::expect_equal(compact_html(live_html), compact_html(artifact_html))
    }
  )
})

test_that("tab_1_stata artifact is available", {
  testthat::skip_if_not_installed("replicateEverything")

  ctx <- study_test_context()
  artifact_path <- file.path(ctx$study_root, "outputs", "tab_1_stata.html")
  testthat::skip_if_not(file.exists(artifact_path), "tab_1_stata artifact missing")

  withr::with_options(
    list(
      replicateEverything.registry_root = ctx$registry_root,
      replicateEverything.index = ctx$local_index,
      replicateEverything.use_sibling_packages = TRUE,
      replicateEverything.study_folders_root = ctx$monorepo_root
    ),
    {
      html <- replicateEverything::load_artifact(
        DOI,
        "tab_1_stata",
        folder = FOLDER
      )
      testthat::expect_true(grepl("logit", html, ignore.case = TRUE))
    }
  )
})
