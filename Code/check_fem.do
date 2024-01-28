cd "~/GitHub/Polar-Check"

use year age sex wtsscomp fefam fepol abany pillok ///
    using "Data/gss7222_r2.dta" if /// https://gss.norc.org/get-the-data/stata
    year >= 1988 & !mi(age, sex), clear

generate fem_pol = 100 * (fepol == 2) if !mi(fepol)
generate fem_fam = 100 * inlist(fefam, 3, 4) if !mi(fefam)
generate fem_pil = 100 * inlist(pillok, 1, 2) if !mi(pillok)
generate fem_abo = 100 * (abany == 1) if !mi(abany)

keep if inrange(age, 18, 29)
collapse fem_* [pweight = wtsscomp], by(sex year)
xtset sex year

discard
xtline fem_pol, overlay ///
    title("Women Politicians") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("Approval") ylabel(40(5)100) name(g1)

xtline fem_fam, overlay ///
    title("Both Work") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("Approval") ylabel(40(5)100) name(g2)

xtline fem_pil, overlay ///
    title("Teen Birth Control") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("Approval") ylabel(40(5)100) name(g3)

xtline fem_abo, overlay ///
    title("Abortion") ///
    xtitle("") xlabel(1985(5)2025) ///
    ytitle("Approval") ylabel(20(5)80) name(g4)

grc1leg g1 g2 g3 g4
graph export "Results/fem.png", replace
