* Table 1 — Fearon & Laitin (Stata)
* Study repo: rep-10.1017-S0003055403000534
*
* Runner for replicateEverything / Shiny. Manual run from study root:
*   do "code/tab_1.do"
*
version 17
set more off, permanently

local root "`c(pwd)'"
local root : subinstr local root "\" "/", all
global maindir "`root'"
if "${REPLICATE_STATA_RESULT}" != "" {
    global result "${REPLICATE_STATA_RESULT}"
}
else {
    global result "${maindir}/outputs/staging"
}
cap mkdir "${maindir}/outputs"
cap mkdir "${result}"
global datadir "${maindir}/data"

capture log close _all
local oldpwd "`c(pwd)'"
cd "${result}"
log using "tab_1_stata", replace text

do "${maindir}/code/mkreptable1.do"

capture log close
cd "`oldpwd'"
