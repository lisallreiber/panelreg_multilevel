use "_data/ex_mydf.dta", clear

reg hwageb i.frau##c.pgbilzeit c.pgbilzeit##c.erf c.erf##c.erf ost ///
if asample==1 & syear==2015 [pw=phrf] 

margins, at(erf=(0(10)50) pgbilzeit=(7 (1) 18) frau=(1 0))
marginsplot, name(margins_3.4)

graph display margins_3.4
graph export "out/margins_3.4.png"
