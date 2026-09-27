This readme file was generated on 2025-09-30

# GENERAL INFORMATION
* Title of Dataset: U.S. County-Level Drug Poisoning Mortality (1999–2016)
* Contacts: Cornell University MS Student (Primary), NCHS Data Support (Secondary)

## Author/Principal Investigator Information
Name: Cornell University MS Student
Institution: Cornell University
Address: Ithaca, NY, USA

## Author/Alternate Contact Information
Name: NCHS Data Support
Institution: Centers for Disease Control and Prevention (CDC)
Address: 3311 Toledo Rd, Hyattsville, MD 20782, USA
Email: cdcinfo@cdc.gov

* Date of data collection: 1999–2016
* Geographic location of data collection: United States, all counties
* Information about funding sources that supported the collection of the data: National Center for Health Statistics, CDC

# SHARING/ACCESS INFORMATION
* Licenses/restrictions placed on the data: Public use dataset from NCHS
* Links to publications that cite or use the data: https://www.nytimes.com/interactive/2016/01/07/us/drug-overdose-deaths-in-the-us.html
* Links to other publicly accessible locations of the data: https://www.cdc.gov/nchs/
  * Data derived from another source: NCHS Vital Statistics

# DATA & FILE OVERVIEW
## File List:
* NCHS_-_Drug_Poisoning_Mortality_by_County__United_States_20250924.csv – Raw CDC data
* data2.csv – Cleaned dataset with numeric low/high mortality intervals
* overdose_deaths_by_county.png – Multi-panel map visualization (1999–2016)

* Relationship between files: data2.csv is generated from the raw CSV; the PNG uses data2.csv
* Additional related data collected that was not included: None

# METHODOLOGICAL INFORMATION
## Description of methods used for collection/generation of data:
County-level mortality data collected by the CDC/NCHS, based on death certificates and ICD coding for drug poisoning.

## Methods for processing the data:
* Symbols <, +, , removed
* Intervals split into numeric low and high values
* Data saved as data2.csv for visualization

## Instrument- or software-specific information needed to interpret the data:
* R version >= 4.5.1
* Packages: maps
* Scripts generate multi-panel maps with color-coded bins for mortality per 100,000

# DATA-SPECIFIC INFORMATION FOR: data2.csv
* Number of variables: 9
* Number of cases/rows: 56448
* Variable List:
  * FIPS – County FIPS code
  * Year – Observation year
  * low – Lower bound of mortality rate per 100,000
  * high – Upper bound of mortality rate per 100,000
  * colorBuckets – Assigned bin for visualization
* Missing data codes: NA represents missing values
* Specialized formats or other abbreviations used: None
