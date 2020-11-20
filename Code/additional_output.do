* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load data
use Processed/slur.dta, clear

* calculate change in slur index from 2013 to 2018
reshape wide slur, i(statestring) j(year)
gen change = slur2018 - slur2013
sort change
keep statestring change
egen avgchange = mean(change)

* calculate summary statistics for data
use Processed/merged.dta, clear
sum mh_asian
sum slur
sum swear
sum trade
sum trade_bal
sum pop_asian

use Processed/anes.dta, clear
sum approve_asian

* generate table showing slur index is correlated with ANES approval rating
use Processed/slur.dta, clear
merge 1:1 statestring year using Processed/swear.dta, keep(match) nogen
merge 1:1 statestring year using Processed/anes.dta, keep(match) nogen
label var slur "Slur Index"
label var swear "Swear Index"
reg approve_asian slur
eststo anesslur
reg approve_asian swear
eststo anesswear

esttab anesslur anesswear ///
		using "anes_check.tex", ///
		cells(b(star fmt(3)) se(par fmt(2))) margin delim("&") ///
		style(tex) eqlabels(none) collabels(, none) mlabels(none) ///
		stats(N r2, labels("N" "R-squared") fmt(0 2)) starlevels( * 0.10 ** 0.05 *** 0.010) replace ///
		prehead("\begin{threeparttable} \begin{tabular}{lcc} \hline") ///
		posthead("& Asian Approval Rating & Asian Approval Rating \\ \hline") ///
		postfoot("\hline \end{tabular} \begin{tablenotes} \item Notes: Standard errors in parentheses below each estimate. Significance at the 1, 5, and 10 percent levels indicated by ***, **, and *, respectively. \end{tablenotes} \end{threeparttable}") ///
		legend label nobase
