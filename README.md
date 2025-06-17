# ReadyForAction
Data is not included with the demo, please see ![Data Sources](#data-sources).

iris.script assumes the CSV files exists when building the image

## Development Notes

### Running the demo
Simply run the ```run_demo.py``` script, which will handle refreshing the dependent dockerfile + making some demo specific changes to it. It will then build the image and start the container.

UI will then be available at: http://localhost:61773/csp/user/DemoUI.html

### UI Files

Use the following to move UI files while developing
```
docker exec -it -u root readyforaction-iris-1 cp -r /irisdev/app/src/UI/. /usr/irissys/csp/broker/
```

## Data Sources

### READY2025
CSV file saved in ./src/CSVs/READY2025.csv

ChatGPT Prompt:
Can you generate some sample conference Participant data for me? I need the following information:
FirstName, OrgType, JobTitle, Level, Role, Country, Industry, SubIndustry, RegistrationDate, PreviousSummits

I would like ~750 records to be generated. 

Here are some more specifics about these fields:
FirstName - Please give me ~250 names, please make these names common names for people in their 30s-60s. Please split the names about 65/35 male/female. Realistically make more common names more popular. Give some amount of international consideration to these names, based on the specifications in the "country" field.

OrgType - Customer (75%), Prospect (13%), Partner (5%), Indirect Customer (3%), Vendor (2%), Analyst (2%)

Level - C-Level (22%), Director (20%), Manager (18%), Non-Manager (30%), VP-Level (10%), and a couple blank values. 

Role - This should contain items like Executive (25%), Developer (15%), Technical (30%), Sales (5%), Product Management (5%), Operations (5%), Business Administration, Clinical, Operations, and some others to make 17 in total, with a couple empty values

JobTitle - Please give reasonable JobTitles based on the Level + Role combinations.

Country - United States (65%), Brazil (7%), UK (4%), Australia (4%), Italy, Germany, South africal, belgium, switzerland, finland, singapore, kenya, israel all (2%) and a handful of other countries with a couple people.

Industry - Business Partner (25%), Healthcare Applications (20%), Healthcare Delivery (20%), software (5%), HIE (5%), Government (5%), Business Services (5%), Health Insurance (3%), Finance (2%), please have a total of about 30 industries.

SubIndustry - Please populate this with reasonable values based on previous information.

RegistrationDate - Mostly business days starting mid march until June 22. March (12%), June (18%), April (27%), May (43%)

PreviousSummits - 0 (20%), 10-15 (30%), the rest between 1 and 9

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