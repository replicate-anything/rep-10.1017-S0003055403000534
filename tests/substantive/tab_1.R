# Substantive (published-value) checks for Table 1 — Fearon & Laitin (2003)
#
# Benchmarks: APSR Table 1, "Prior war" row (coefficient, SE) and column Ns.
# R replicates Stata 7.0 logit estimates to three decimal places.

tab_1_prior_war_benchmark <- function() {
  list(
    terms = c("warl", "warl", "warl", "empwarl", "cowwarl"),
    coef = c(-0.954, -0.849, -0.916, -0.688, -0.551),
    se = c(0.314, 0.388, 0.312, 0.264, 0.374),
    nobs = c(6327L, 5186L, 6327L, 6360L, 5378L)
  )
}

#' @param object List of five glm objects from `make_tab_1()`.
#' @param tolerance Numeric tolerance for coef/se (default 0.001).
substantive_check_tab_1 <- function(object, tolerance = 0.001) {
  replicateEverything::check_glm_table_benchmark(
    object,
    tab_1_prior_war_benchmark(),
    tolerance = tolerance
  )
}
