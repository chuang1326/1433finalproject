* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* merge data
use Processed/statematch.dta, clear
merge 1:m statestring using Processed/kff_mental_health.dta, keep(match) nogen
merge 1:1 statestring year using Processed/swear.dta, keep(match) nogen
merge 1:1 statestring year using Processed/slur.dta, keep(match) nogen
merge 1:1 statestring year using Processed/trade_balance.dta, keep(match) nogen
merge 1:1 statestring year using Processed/trade.dta, keep(match) nogen
merge 1:1 statestring year using Processed/unemp.dta, keep(match) nogen
merge 1:1 statestring year using Processed/income.dta, keep(match) nogen
merge 1:1 statestring year using Processed/kff_popshare, keep(match) nogen

* normalize google trends variables
replace slur = slur/114.752*100
replace swear = swear/138.7527*100
replace trade = trade/107.1593*100

* label variables
label var trade "Trade Interest Index"
label var trade_bal "Trade Balance"
label var slur "Slur Index"
label var swear "Swear Index"
label var mh_asian "Asian Mental Health"
label var unemp "Unemployment"
label var income "Med. Income"
label var pop_asian "Pop. Share"

save Processed/merged.dta, replace
