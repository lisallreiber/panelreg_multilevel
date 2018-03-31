use "_data/ex_mydf.dta", clear

reg hwageb pgbilzeit c.erf##c.erf frau ost if asample==1 & syear==2015 [pw=phrf]

qui: margins, at(erf=(0(10)65))
marginsplot, name(margins, replace)
graph export "out/margins_3_7.png", replace

reg hwageb pgbilzeit c.erf##c.erf frau ost if asample==1 & syear==2015 [pw=phrf]

qui: margins, at(erf=(0(10)50) pgbilzeit=(7, 10.5, 14, 18) frau=(1 0))
marginsplot, name("margins_3_7_2", replace)
graph export "/Users/LR/Git/multilevel_models_statar/out/margins_3_7_2.png"

