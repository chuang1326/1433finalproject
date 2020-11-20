* 14.33 paper 1 code
* Catherine Huang
* 11/9/2020

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* load data
use Processed/merged.dta, clear

* generate graph showing first stage regression

reg swear unemp income i.statenum i.year
predict swear_resid, residuals

reg slur unemp income i.statenum i.year
predict slur_resid, residuals

reg trade_bal unemp income i.statenum i.year
predict trade_bal_resid, residuals

reg trade unemp income i.statenum i.year
predict trade_resid, residuals

label var trade_bal_resid "Trade Balance"

label var trade_resid "Trade Interest Index"

set scheme s1mono

twoway (scatter slur_resid trade_resid) (lfit slur_resid trade_resid), legend(off) xtitle("Trade Interest Index") ytitle("Slur Index") note("Note: unemployment, income, state fixed effects, and year fixed effects have been partialed out both variables.")
graph export firststage.png, replace

* generate table showing that trade is an effective instrument for slur
reg slur trade unemp income i.statenum i.year
eststo firststage
estadd local Controls "Yes"

reg swear trade unemp income i.statenum i.year
eststo firststage2
estadd local Controls "Yes"

reg slur trade_bal unemp income i.statenum i.year
eststo firststage_alt
estadd local Controls "Yes"

reg swear trade_bal unemp income i.statenum i.year
eststo firststage_alt2
estadd local Controls "Yes"

reg unemp trade
eststo unemptrade

reg income trade
eststo inctrade

reg pop_asian trade
eststo poptrade

esttab firststage firststage2 firststage_alt firststage_alt2 unemptrade inctrade poptrade ///
		using "instrument.tex", ///
		keep (trade trade_bal) cells(b(star fmt(3)) se(par fmt(2))) margin delim("&") ///
		style(tex) eqlabels(none) collabels(, none) mlabels(none) ///
		stats(N r2, labels("N" "R-squared") fmt(0 2)) starlevels( * 0.10 ** 0.05 *** 0.010) replace ///
		prehead("\begin{threeparttable} \begin{tabular}{lcccc|ccc} \hline") ///
		posthead("& Slur Index & Swear Index & Slur Index & Swear Index & Unemp. & Med. Income & Pop. Share \\ \hline") ///
		postfoot("\hline \end{tabular} \begin{tablenotes} \item Notes: Standard errors in parentheses below each estimate. Significance at the 1, 5, and 10 percent levels indicated by ***, **, and *, respectively. In the first four columns, unemployment, median income, state fixed effects, and year fixed effects have been partialed out. \end{tablenotes} \end{threeparttable}") ///
		legend label nobase

* generate main results table
ivregress 2sls mh_asian unemp income i.statenum i.year (slur = trade)
eststo mainregression

ivregress 2sls mh_asian unemp income i.statenum i.year (swear = trade)
eststo mainregression2

ivregress 2sls mh_asian unemp income i.statenum i.year (slur = trade_bal)
eststo mainregression_alt

ivregress 2sls mh_asian unemp income i.statenum i.year (swear = trade_bal)
eststo mainregression_alt2

esttab mainregression mainregression2 mainregression_alt mainregression_alt2  ///
		using "main_reg.tex", ///
		order (slur swear unemp income) keep(slur swear unemp income) z(3) ///
		cells(b(star fmt(3)) se(par fmt(2))) margin delim("&") ///
		style(tex) eqlabels(none) collabels(, none) mlabels(none) ///
		stats(N r2, labels("N" "R-squared") fmt(0 2)) starlevels( * 0.10 ** 0.05 *** 0.010) replace ///
		prehead("\begin{threeparttable} \begin{tabular}{lcc|cc} \hline Instrument: & \multicolumn{2}{c}{Trade Interest Index} & \multicolumn{2}{c}{Trade Balance} \\ \hline") ///
		posthead(" & Days & Days & Days & Days \\ \hline") ///
		postfoot("\hline \end{tabular} \begin{tablenotes} \item Notes: Standard errors in parentheses below each estimate. Significance at the 1, 5, and 10 percent levels indicated by ***, **, and *, respectively. \end{tablenotes} \end{threeparttable}") ///
		legend label nobase
		
* generate table for robustness check
ivregress 2sls mh_asian unemp income pop_asian i.statenum i.year (slur = trade)
eststo robustness

ivregress 2sls mh_asian unemp income pop_asian i.statenum i.year (swear = trade)
eststo robustness2

ivregress 2sls mh_asian unemp income pop_asian i.statenum i.year (slur = trade_bal)
eststo robustness_alt

ivregress 2sls mh_asian unemp income pop_asian i.statenum i.year (swear = trade_bal)
eststo robustness_alt2

esttab robustness robustness2 robustness_alt robustness_alt2  ///
		using "robustness.tex", ///
		order (slur swear unemp income pop_asian) keep(slur swear unemp income pop_asian) z(3) ///
		cells(b(star fmt(3)) se(par fmt(2))) margin delim("&") ///
		style(tex) eqlabels(none) collabels(, none) mlabels(none) ///
		stats(N r2, labels("N" "R-squared") fmt(0 2)) starlevels( * 0.10 ** 0.05 *** 0.010) replace ///
		prehead("\begin{threeparttable} \begin{tabular}{lcc|cc} \hline Instrument: & \multicolumn{2}{c}{Trade Interest Index} & \multicolumn{2}{c}{Trade Balance} \\ \hline") ///
		posthead(" & Days & Days & Days & Days \\ \hline") ///
		postfoot("\hline \end{tabular} \begin{tablenotes} \item Notes: Standard errors in parentheses below each estimate. Significance at the 1, 5, and 10 percent levels indicated by ***, **, and *, respectively. \end{tablenotes} \end{threeparttable}") ///
		legend label nobase
