use "_data/ex_mydf.dta", clear

cap drop genderrev
gen genderrev =.
cap drop upper lower
gen upper=.
gen lower=.

foreach year of numlist 1991/2015 {
      qui: reg lnwage pgbilzeit c.erf##c.erf pgexpue ost frau i.pgallbet if asample==1 & syear==`year' [pw=phrf], eform(b) cluster(hid)
      qui: replace genderrev = exp(_b[frau]) if syear==`year'
      qui: replace upper = exp(_b[frau]+ 1.96*_se[frau]) if syear==`year'
      qui: replace lower = exp(_b[frau]- 1.96*_se[frau]) if syear==`year'
}


preserve
collapse genderrev upper lower, by(syear) 
twoway (connected genderrev syear, sort) ///
(line upper lower syear, sort lpattern(dash dash) lcolor(bluishgray8 bluishgray8)) ///
, legend(off) subtitle(Gesamt)
graph save Graph "out/genderrev_gesamt.gph", replace
restore

** repeat for only west germany
cap drop genderrev_west
gen genderrev_west=.
cap drop upper lower
gen upper=.
gen lower=.
foreach year of numlist 1984/2015 {
qui: reg lnwage frau c.erf##c.erf pgexpue ost frau i.pgallbet   if asample==1 & syear==`year' & ost==0 [pw=phrf], eform(b) cluster(hid)
qui: replace genderrev_west = exp(_b[frau]) if syear==`year'
qui: replace upper = exp(_b[frau]+ 1.96*_se[frau]) if syear==`year'
qui: replace lower = exp(_b[frau]- 1.96*_se[frau]) if syear==`year'
}
*twoway (connected genderrev_west syear, sort) (line upper lower syear, sort) 
preserve
collapse genderrev_west upper lower, by(syear) 
twoway (connected genderrev_west syear, sort) ///
(line upper lower syear, sort lpattern(dash dash) lcolor(bluishgray8 bluishgray8)) ///
, legend(off) subtitle(Ostdeutschland)
graph save Graph "out/genderrev_west.gph", replace
restore


** repeat for only east germany

cap drop genderrev_ost
gen genderrev_ost=.
cap drop upper lower
gen upper=.
gen lower=.
foreach year of numlist 1991/2015 {
qui: reg lnwage frau c.erf##c.erf pgexpue ost frau i.pgallbet   if asample==1 & syear==`year' & ost==1 [pw=phrf], eform(b) cluster(hid)
qui: replace genderrev_ost = exp(_b[frau]) if syear==`year'
qui: replace upper = exp(_b[frau]+ 1.96*_se[frau]) if syear==`year'
qui: replace lower = exp(_b[frau]- 1.96*_se[frau]) if syear==`year'
}
*twoway (connected genderrev_ost syear, sort) (line upper lower syear, sort)
preserve
collapse genderrev_ost upper lower, by(syear) 
twoway (connected genderrev_ost syear, sort) ///
(line upper lower syear, sort lpattern(dash dash) lcolor(bluishgray8 bluishgray8)) ///
, legend(off) subtitle(Westdeutschland)
graph save Graph "out/genderrev_ost.gph", replace
restore

***
graph combine  ///
"out/genderrev_ost.gph"  ///
"out/genderrev_west.gph"  ///
"out/genderrev_gesamt.gph" ///
, ycommon xcommon note(GSOEP 32, size(vsmall) position(5)) title(Development of Gender Returns)

graph save Graph "out/genderrev_all.gph", replace

