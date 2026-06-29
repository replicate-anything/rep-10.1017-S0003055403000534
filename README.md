# Fearon & Laitin (2003) — Ethnicity, Insurgency, and Civil War

Folder-backed replication materials for [10.1017/S0003055403000534](https://doi.org/10.1017/S0003055403000534).

## Layout

```
replication.yml
data/
code/
artifacts/
tests/testthat/
```

The [registry](https://github.com/replicate-anything/registry) holds a lightweight stub under `papers/10.1017S0003055403000534/` that points here.

## Build display artifacts

From this repository root:

```r
library(replicateEverything)
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::build_study_artifacts(".", install_deps = TRUE)
```

## Tests

```r
testthat::test_dir("tests/testthat")
```

## Validate before merge

```r
replicateEverything::check_folder_replication(
  ".",
  registry_root = "../registry"
)
```

## Register with the registry

```r
options(replicateEverything.registry_root = "../registry")
replicateEverything::add_folder_paper(".")
```

## Local development (monorepo)

When this folder sits next to `registry/` and `replicateEverything/`:

```r
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::run_replication("10.1017/S0003055403000534", "tab_1", format = TRUE)
```

See `vignette("folder-replication-checklist", package = "replicateEverything")`.
