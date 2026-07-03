# Table 1 — Ethnicity, Insurgency, and Civil War
# Study repo: https://github.com/replicate-anything/rep-10.1017-S0003055403000534
# Run from the study repo code/ folder: Rscript tab_1.R

library(haven)
library(modelsummary)
library(kableExtra)

make_tab_1 <- function(data) {
  df <- data

  # Stata variable lpopl is stored as lpopl1 in the replication data set.
  df$lpopl <- df$lpopl1

  for (v in c("onset", "ethonset", "emponset", "cowonset")) {
    df[[v]] <- ifelse(df[[v]] == 1, 1, 0)
  }

  list(
    
    glm(
    onset ~ warl + gdpenl + lpopl + lmtnest + ncontig + Oil + nwstate +
      instab + polity2l + ethfrac + relfrac,
    data = df, family = binomial()
  ),
  
  glm(
    ethonset ~ warl + gdpenl + lpopl + lmtnest + ncontig + Oil + nwstate +
      instab + polity2l + ethfrac + relfrac,
    data = subset(df, second > 0.049999),
    family = binomial()
  ),
  
  glm(
    onset ~ warl + gdpenl + lpopl + lmtnest + ncontig + Oil + nwstate +
      instab + anocl + deml + ethfrac + relfrac,
    data = df, family = binomial()
  ),
  
  glm(
    emponset ~ empwarl + empgdpenl + emplpopl + emplmtnest + empncontig +
      Oil + nwstate + instab + empethfrac,
    data = df, family = binomial()
  ),

  glm(
    cowonset ~ cowwarl + gdpenl + lpopl + lmtnest + ncontig + Oil + nwstate +
      instab + anocl + deml + ethfrac + relfrac,
    data = df, family = binomial()
  )
  )

}

format_tab_1 <- function(object) {
  coef_map <- c(
    "warl"        = "Prior war<sup>a</sup>",
    "gdpenl"      = "Per capita income<sup>a,b</sup>",
    "lpopl"       = "Population<sup>a</sup>",
    "lmtnest"     = "% mountainous<sup>a</sup>",
    "ncontig"     = "Noncontiguous state",
    "Oil"         = "Oil exporter<sup>d</sup>",
    "nwstate"     = "New state<sup>d</sup>",
    "instab"      = "Instability<sup>a</sup>",
    "polity2l"    = "Polity<sup>c</sup>",
    "ethfrac"     = "Ethnic fractionalization",
    "relfrac"     = "Religious fractionalization",
    "anocl"       = "Anocracy<sup>d</sup>",
    "deml"        = "Democracy<sup>d</sup>",
    "empwarl"     = "Prior war<sup>a</sup>",
    "empgdpenl"   = "Per capita income<sup>a,b</sup>",
    "emplpopl"    = "Population<sup>a</sup>",
    "emplmtnest"  = "% mountainous<sup>a</sup>",
    "empncontig"  = "Noncontiguous state",
    "empethfrac"  = "Ethnic fractionalization",
    "cowwarl"     = "Prior war<sup>a</sup>",
    "(Intercept)" = "Constant"
  )

  tab <- modelsummary::modelsummary(
    object,
    output = "kableExtra",
    coef_map = coef_map,
    escape = FALSE,
    stars = c("*" = 0.05, "**" = 0.01, "***" = 0.001),
    statistic = "({std.error})",
    gof_map = c("nobs", "aic"),
    title = "TABLE 1. Logit Analyses of Determinants of Civil War Onset, 1945–99"
  ) |>
    kableExtra::add_header_above(
      c(
        " " = 1,
        "Civil War" = 1,
        "\"Ethnic\" War" = 1,
        "Civil War" = 1,
        "Civil War (Plus Empires)" = 1,
        "Civil War (COW)" = 1
      ),
      bold = TRUE
    ) |>
    kableExtra::footnote(
      general = paste(
        "Note: The dependent variable is coded \"1\" for country-years in which a civil",
        "war began and \"0\" in all others. Standard errors are in parentheses.",
        "Estimations performed using Stata 7.0. * p < .05; ** p < .01; *** p < .001."
      ),
      alphabet = c(
        "Lagged one year.",
        "In 1000's.",
        "Polity IV; varies from -10 to 10.",
        "Dichotomous."
      ),
      threeparttable = TRUE
    ) |>
    kableExtra::kable_styling(
      bootstrap_options = c("condensed", "hover"),
      full_width = FALSE,
      position = "left"
    )

  html <- as.character(tab)
  html <- gsub("&amp;nbsp;", " ", html, fixed = TRUE)
  html <- gsub("&nbsp;", " ", html, fixed = TRUE)
  html
}

make_tab_1(haven::read_dta("../data/repdata.dta")) |> format_tab_1()

make_tab_1(repdata) |> format_tab_1()
