* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process google trends data
import delimited "Raw/google_trends/gtCalifornia.csv", delimiters(",") clear
drop if _n < 3
rename (v1 v2) (year slur)
replace year = substr(year, 1, length(year)-3)
destring *, replace
bysort year: egen index=mean(slur)
drop slur
duplicates drop
tempfile slur_indices
save `slur_indices', replace

foreach year in 2013 2014 2015 2016 2017 2018 {
	import delimited "Raw/google_trends/gt`year'.csv", delimiters(",") clear
	drop if _n < 3
	rename (v1 v2) (statestring slur)
	destring slur, replace
	gen year = `year'
	tempfile gt`year'
	save `gt`year'', replace
}
use `gt2013', clear
append using `gt2014'
append using `gt2015'
append using `gt2016'
append using `gt2017'
append using `gt2018'
merge m:1 year using `slur_indices', keep(match) nogen

replace slur = slur/44*52*31.666666/45.25 if year == 2013

replace slur = slur/44*52*35/45.25 if year == 2014

replace slur = slur/58*52*57.916668/45.25 if year == 2015

replace slur = slur/51*52*46.083332/45.25 if year == 2017

replace slur = slur/69*52*49.166668/45.25 if year == 2018

drop index

save Processed/slur.dta, replace
