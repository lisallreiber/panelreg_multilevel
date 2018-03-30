use "../data/ess50.dta", clear

xtmixed stfdem || cntry: polintr nwsptot gndr, cov(unstructured)
