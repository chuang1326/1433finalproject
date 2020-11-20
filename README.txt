Catherine Huang
Updated 11/20/2020

To process all data and generate all tables as tex files, navigate to the directory containing the folders Code, Processed, and Raw. Then run the command “do Code/run_all.do” in Stata.

RAW 

Note: I couldn’t upload the aggregate ANES file I used to get the 2016 data because the file was too large for GitHub. I will work to get a smaller version of this file for my revision.

Raw data come from the following sources:
ANES https://electionstudies.org/data-center/
Google Trends https://trends.google.com/trends/?geo=US
KFF Mental Health https://www.kff.org/other/state-indicator/poor-mental-health-days-by-re/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D#
KFF Population Share https://www.kff.org/other/state-indicator/distribution-by-raceethnicity/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D
Trade Balance https://usatrade.census.gov
Unemployment (click on “Show table” at the bottom and copy the table) https://www.bls.gov/charts/state-employment-and-unemployment/state-unemployment-rates-animated.htm
Median Income https://www2.census.gov/programs-surveys/cps/tables/time-series/historical-income-households/h08.xls

I generated “statematch.xlsx” by matching the ANES state numbering system to state names and state abbreviations.

CODE

Each file generally does as described. The process files run first, then merge_all, then generate_output and additional_output.

PROCESSED

Contains processed versions of the raw data.
