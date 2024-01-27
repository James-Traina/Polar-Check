cd "~/GitHub/Polar-Check"

use year age sex wtsscomp polviews partyid ///
    fechld fefam fepol fepresch ///
    abany pillok ///
    attend bible ///
    cappun gunlaw ///
    helpblk natrace ///
    helppoor natfare ///
    natarms natcrime natenvir natheal ///
    using "Data/gss7222_r2.dta" if /// https://gss.norc.org/get-the-data/stata
    year >= 1988 & !mi(age, sex), clear

keep if inrange(age, 18, 39)
replace age = 1 if inrange(age, 18, 29)
replace age = 2 if inrange(age, 30, 39)

// .dta has only relevant variables to stay in GitHub limits
// .zip has the full dataset per above link

generate lib_con = 100 * (inrange(polviews, 1, 3) - inrange(polviews, 5, 7))
generate dem_rep = 100 * (inlist(partyid, 0, 1) - inlist(partyid, 5, 6))

collapse lib_con dem_rep [pweight = wtsscomp], by(age sex year)
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
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("% Liberal - % Conservative") ylabel(-25(5)35)
graph export "Results/check_lib_con.png", replace

twoway ///
    lowess lib_con year if age == 1 & sex == 1 || ///
    lowess lib_con year if age == 1 & sex == 1 & year != 2022, ///
    title("Stated Political Ideology of 18-29 Men, LOWESS") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("% Liberal - % Conservative") ylabel(-25(5)35) ///
    legend(order(1 "Full" 2 "Drop 2022"))
graph export "Results/outlier.png", replace

xtline dem_rep, overlay ///
    title("Stated Party Affiliation") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("% Democrat - % Republican") ylabel(-30(5)30)
graph export "Results/check_dem_rep.png", replace
