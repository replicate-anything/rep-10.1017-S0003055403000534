# Fearon & Laitin (2003) — Ethnicity, Insurgency, and Civil War

Folder-backed replication materials for [10.1017/S0003055403000534](https://doi.org/10.1017/S0003055403000534).

## Layout

```
replication.yml
data/
code/
artifacts/
```

The [registry](https://github.com/replicate-anything/registry) holds a lightweight stub under `papers/10.1017S0003055403000534/` that points here.

## Rebuild display artifacts

From this repository root:

```bash
Rscript -e "replicateEverything::replicate_paper('10.1017/S0003055403000534', install_deps = TRUE)"
```

Or run individual scripts from `code/` and commit updated files under `artifacts/`.

## Tests

From this repository root (with `replicateEverything` installed and the registry as a sibling folder):

```r
testthat::test_dir("tests/testthat")
```

Tests call `replicateEverything::run_replication()` for each table/figure and check that formatted output matches the committed artifact.

## Local development (monorepo)

When this folder sits next to `registry/` and `replicateEverything/`:

```r
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::render_replication("10.1017/S0003055403000534", "tab_1")
```
