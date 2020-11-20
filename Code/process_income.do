* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load median income data
import excel using "Raw/h08.xls", first clear
drop if _n < 62 | _n > 112
drop C-E G I K M O-BW
rename (Tablewithrowheadersincolumn B F H J L N) (statestring income2018 income2017 income2016 income2015 income2014 income2013)
destring income*, replace
reshape long income, i(statestring) j(year)
save Processed/income.dta, replace
