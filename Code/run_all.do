* 14.33 paper 1 code
* Catherine Huang
* 11/20/2020

* set up logfile
capture log close
log using 1433final.log, replace

* set up directory
cd "/Users/chuang/Desktop/CurrentPsets/1433finalproject/"  

* process data
do Code/process_statematch.do
do Code/process_anes.do
do Code/process_kff.do
do Code/process_slur.do
do Code/process_swear.do
do Code/process_trade.do
do Code/process_trade_balance.do
do Code/process_unemp.do
do Code/process_income.do

* merge data
do Code/merge_all.do

* create graphs and output
do Code/generate_output.do
do Code/additional_output.do

log close
