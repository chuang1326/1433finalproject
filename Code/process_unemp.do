* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load unemployment data
import delimited "Raw/unemployment.csv", delimiters(",") clear
rename *state statestring
drop *10 *11 *12
foreach year in 13 14 15 16 17 18 {
	egen unemp`year' = rowmean(*`year')
}
keep statestring unemp*
rename unemp* unemp20*
reshape long unemp, i(statestring) j(year)
save Processed/unemp.dta, replace
