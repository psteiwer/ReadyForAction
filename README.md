# ReadyForAction
Data is not included with the demo, please see ![Data Sources](#data-sources).

iris.script assumes the CSV files exists when building the image

## Data Sources

### READY2025
CSV file saved in ./src/CSVs/READY2025.csv

Pulled from READY2025 Power BI dashboard, filtered down to the following columns:
FirstName,Company,OrgType,JobTitle,Level,Role,Country,Industry,SubIndustry,RegistrationDate

### MCOFlightDelays
CSV file saved in ./src/CSVs/MCOFlightDelays.csv

Pulled from https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp?pn=1 Filter date range and then click "Download Raw Data"

Passed this data into ChatGPT and asked the following:

i have this data set for a demo, can you use the data in it to generate some realistic seeming data for me? this contains historic delay information for flights into orlando MCO. can you use this data to generate 10,000 rows of flights with the following information: Date, Airline, CauseOfDelay, AmountOfDelay.

please remove the "national" type, since im not really sure what that even means. please alter "amountOfDelay" column. I wanted DelayDuration instead

please regenerate the delay duration. this should be in minutes, so these durations are not realistic

please remove the odd extra Id column, i dont need this. also, please include flights with no delays. i would like the delays distrubuted as expected with normal non-delayed flights also

please regenerate the whole data set. it looks like you added more rows. i would like 20,000 total rows with a peoper distribution of flight delays. please make the dates range from 7/1/2024 to 6/22/2025

can you add some outlier information into this, that will help my demo be a little more interesting? for example, I expect there is more rain in orlando during hurricane season, can you perhaps look at hurricanes in the last year and add extra delays around that time? please regenerate the full 20,000 using this information