use "_data/ex_mydf.dta", clear

recode pgallbet (5 = 0)			// selbstst. keine Angest. als Referenz
reg hwageb i.frau##c.cpgbilzeit c.cpgbilzeit##c.cerf ost i.pgallbet ///
if asample==1 & syear==2015 [pw=phrf]

* OR
cap drop d_allbet
tab pgallbet, gen(d_allbet_)
reg hwageb i.frau##c.cpgbilzeit c.cpgbilzeit##c.cerf ost d_allbet_2 - d_allbet_5 ///
if asample==1 & syear==2015 [pw=phrf]
