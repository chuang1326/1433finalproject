* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process KFF poor mental health days data
foreach year in 2013 2014 2015 2016 2017 2018 {
	import delimited "Raw/kff_mental_health/kff`year'.csv", delimiters(",") clear
	drop v9
	destring v2-v8, replace force
	rename (v1-v8) (statestring mh_all mh_nonhiswhite mh_nonhisblack mh_hispanic mh_asian mh_amerindian mh_other)
	keep statestring mh_asian
	recast str statestring
	drop if _n < 4 | _n > 52
	gen year = `year'
	tempfile kff`year'
	save `kff`year'', replace
}
use `kff2013', clear
append using `kff2014'
append using `kff2015'
append using `kff2016'
append using `kff2017'
append using `kff2018'
save Processed/kff_mental_health.dta, replace

* load and process KFF race population share data
foreach year in 2013 2014 2015 2016 2017 2018 {
	import delimited "Raw/kff_population_share/popshare`year'.csv", delimiters(",") clear
	drop v9-v10
	destring v2-v8, replace force
	rename (v1-v8) (statestring pop_white pop_black pop_hispanic pop_asian pop_amerindian pop_other pop_mult)
	keep statestring pop_asian
	recast str statestring
	drop if _n < 4 | _n > 56
	gen year = `year'
	tempfile popshare`year'
	save `popshare`year'', replace
}
use `popshare2013', clear
append using `popshare2014'
append using `popshare2015'
append using `popshare2016'
append using `popshare2017'
append using `popshare2018'
save Processed/kff_popshare.dta, replace
