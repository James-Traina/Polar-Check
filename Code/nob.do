cd "~/GitHub/Polar-Check"

// Neil O'Brian
// @NeilOBrian4
// Any idea of gender gap diff between survey mode? Also 18-29 makes a fairly small sample size...

use year age sex wtsscomp polviews mode ///
    using "Data/nob.dta" if /// https://gss.norc.org/get-the-data/stata
    year >= 2004 & !mi(age, sex), clear // mode starts in 2004
// save, replace

keep if inrange(age, 18, 39)
replace age = 1 if inrange(age, 18, 29)
replace age = 2 if inrange(age, 30, 39)

generate lib_con = 100 * (inrange(polviews, 1, 3) - inrange(polviews, 5, 7))

generate men = (sex == 1)
replace mode = . if mode == 3 // hybrid, tiny share
eststo: regress men ibn.mode [aweight = wtsscomp], noconstant
eststo: regress men ibn.mode if year == 2022 [aweight = wtsscomp], noconstant
esttab, label se nostar
eststo clear

collapse (count) lib_con [aweight = wtsscomp], by(age sex year)
egen group = group(age sex)
xtset group year

label define group ///
    1 "18-29 Men" ///
    2 "18-29 Women" ///
    3 "30-39 Men" ///
    4 "30-39 Women"
label values group group

xtline lib_con, overlay ///
    title("Stated Political Ideology") ///
    xtitle("") xlabel(2000(5)2025) ///
    ytitle("Sample Size") ylabel(100(50)500)
graph export "Results/nob.png", replace
