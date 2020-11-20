* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process trade balance data
foreach x in "Exports" "Imports" {
	import delimited "Raw/trade_balance/State `x' by HS Commodities.csv", delimiters(",") clear
	drop if _n < 4
	drop v2 v3 v6
	rename (v1 v4 v5) (statestring year `x')
	destring year, replace
	destring `x', replace ignore(",")
	tempfile `x'temp
	save ``x'temp', replace
}
use `Exportstemp', clear
merge 1:1 statestring year using `Importstemp', keep(match) nogen
gen trade_bal = (Exports - Imports)/1000000000
drop Exports Imports
save Processed/trade_balance.dta, replace
