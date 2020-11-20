* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load and process ANES sentiment data
use Raw/anes_timeseries_cdf_dta/anes_timeseries_cdf.dta, clear
drop if VCF0004 < 2013
egen approve_asian = mean(VCF0227), by(VCF0004 VCF0901b)
keep VCF0004 VCF0006a VCF0901b approve_asian
rename (VCF0004 VCF0006a VCF0901b) (year id state)
duplicates drop year state, force
sort state year
drop id
save Processed/anes2016.dta, replace

use Raw/anes_pilot_2018.dta, clear
egen approve_asian = mean(ftasian), by(inputstate)
keep inputstate approve_asian
rename inputstate statenum
gen year = 2018
duplicates drop year statenum, force
save Processed/anes2018.dta, replace

* merge ANES data
use Processed/statematch.dta, clear
merge 1:m state using Processed/anes2016, keep(match) nogen

preserve
use Processed/statematch.dta, clear
merge 1:m statenum using Processed/anes2018, keep(match) nogen
tempfile anes18
save `anes18', replace
restore

append using `anes18'
save Processed/anes.dta, replace
