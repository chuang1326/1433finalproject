* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process google trends data
import delimited "Raw/google_trends2/gtCalifornia.csv", delimiters(",") clear
drop if _n < 3
rename (v1 v2) (year swear)
replace year = substr(year, 1, length(year)-3)
destring *, replace
bysort year: egen index=mean(swear)
drop swear
duplicates drop
tempfile swear_indices
save `swear_indices', replace

foreach year in 2013 2014 2015 2016 2017 2018 {
	import delimited "Raw/google_trends2/gt`year'.csv", delimiters(",") clear
	drop if _n < 3
	rename (v1 v2) (statestring swear)
	destring swear, replace
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
merge m:1 year using `swear_indices', keep(match) nogen

replace swear = swear/39*52*41.5/47.5 if year == 2013

replace swear = swear/60*52*57.166668/47.5 if year == 2014

replace swear = swear/38*52*48.166668/47.5 if year == 2015

replace swear = swear/65*52*41.833332/47.5 if year == 2017

replace swear = swear/80*52*39.833332/47.5 if year == 2018

drop index

save Processed/swear.dta, replace
