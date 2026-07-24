# Fearon & Laitin (2003) — Ethnicity, Insurgency, and Civil War

Folder-backed replication materials for [10.1017/S0003055403000534](https://doi.org/10.1017/S0003055403000534).

## Layout

```
replication.yml
data/
code/
outputs/
tests/testthat/
```

The [registry](https://github.com/replicate-anything/registry) holds a lightweight stub at `studies/10.1017S0003055403000534.yml` that points here (no `registry/` materials are stored in this repo).

## Build display artifacts

From this repository root:

```r
library(replicateEverything)
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::build_study_outputs(".", install_deps = TRUE)
```

### Stata Table 1

Original Stata code is in `code/mkreptable1.do` (from Fearon & Laitin’s replication archive). The runner `code/tab_1.do` writes `outputs/staging/tab_1_stata.log`; format with:

```r
Rscript scripts/build_stata_artifacts.R
```

`replication.yml` lists both `tab_1` (R) and `tab_1_stata` under `group: tab_1` so Shiny shows R and Stata icons for Table 1.

## Tests

```r
testthat::test_dir("tests/testthat")
```

## Validate, then sync to registry

Contributor validates (optionally baking outputs); a maintainer with a local
registry checkout writes the stub — this repo never holds registry files:

```r
options(replicateEverything.registry_root = "../registry")
replicateEverything::check_and_bake_study(".", build_artifacts = FALSE)
replicateEverything::sync_study_to_registry(".")
```

See `vignette("folder-replication-checklist", package = "replicateEverything")`.

## Local development (monorepo)

```r
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::run_replication("10.1017/S0003055403000534", "tab_1", format = TRUE)
replicateEverything::run_replication("10.1017/S0003055403000534", "tab_1_stata", format = TRUE)
```
