* Analysis dataset — Fearon & Laitin (2003)
version 17
set more off, permanently

local root "`c(pwd)'"
local root : subinstr local root "\" "/", all
global maindir "`root'"
global datadir "${maindir}/data"
global processed "${maindir}/outputs"
cap mkdir "${maindir}/outputs"

use "${datadir}/repdata", clear

rename lpopl1 lpopl
foreach v in onset ethonset emponset cowonset {
    replace `v' = 1 if `v' >= 1
    replace `v' = 0 if `v' < 1
}

save "${processed}/analysis_data.dta", replace
