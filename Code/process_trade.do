* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process google trends data
import delimited "Raw/google_trends3/gtCalifornia.csv", delimiters(",") clear
drop if _n < 3
rename (v1 v2) (year trade)
replace year = substr(year, 1, length(year)-3)
destring *, replace
bysort year: egen index=mean(trade)
drop trade
duplicates drop
tempfile trade_indices
save `trade_indices', replace

foreach year in 2013 2014 2015 2016 2017 2018 {
	import delimited "Raw/google_trends3/gt`year'.csv", delimiters(",") clear
	drop if _n < 3
	rename (v1 v2) (statestring trade)
	destring trade, replace
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
merge m:1 year using `trade_indices', keep(match) nogen

replace trade = trade/75*71*70.916664/69.166664 if year == 2013

replace trade = trade/73*71*73.916664/69.166664 if year == 2014

replace trade = trade/77*71*69/69.166664 if year == 2015

replace trade = trade/69*71*71.75/69.166664 if year == 2017

replace trade = trade/58*71*74.75/69.166664 if year == 2018

drop index

save Processed/trade.dta, replace
