* Table 1 — Fearon & Laitin (2003)
* Original replication .do (Table 1 logit models)

use "${datadir}/repdata", clear

* Raw replication data uses lpopl1; analysis scripts expect lpopl
rename lpopl1 lpopl
foreach v in onset ethonset emponset cowonset {
    replace `v' = 1 if `v' >= 1
    replace `v' = 0 if `v' < 1
}

* Model #1
logit onset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab polity2l ethfrac relfrac, nolog

* Model #2
logit ethonset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab polity2l ethfrac relfrac if second > .049999, nolog

* Model #3
logit onset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab anocl deml ethfrac relfrac, nolog

* Model #4
logit emponset empwarl empgdpenl emplpopl emplmtnest empncontig Oil nwstate instab empethfrac, nolog

* Model #5
logit cowonset cowwarl gdpenl lpopl lmtnest ncontig Oil nwstate instab anocl deml ethfrac relfrac, nolog
