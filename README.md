# Replication of New York Times Figure of Drug Overdose Deaths

R code for AEM 6850 (Empirical Methods, Cornell, Fall 2025) that replicates the New York Times county maps of drug overdose deaths in the US, 1999-2016, using NCHS county-level drug poisoning mortality data.

Script_files:
- overdose_maps.R : cleans the raw data (removes <, + and commas and splits each rate interval into numeric low and high values), saves data2.csv, then draws one county map per year (1999-2016, 3 x 6 layout) with six color bins for deaths per 100,000 and a legend
- overdose_maps.Rproj : RStudio project, open this first so the script finds the data folders

Data:
- NCHS_-_Drug_Poisoning_Mortality_by_County__United_States_20250924.csv : raw CDC/NCHS drug poisoning mortality by county

Cleaned_data:
- data2.csv : cleaned data with numeric low and high mortality rates

Output_figure:
- overdose_deaths_by_county.png : the multi-panel map, 1999-2016

Other files:
- readme.txt : full readme with sources, contacts, methods and the variable list

Requires R 4.5.1 or later and the maps package.
