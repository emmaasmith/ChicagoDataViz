# ChicagoDataViz
Investigation into Chicago mayoral election results.

This is all still VERY MUCH a work in progress.
I'm not claiming any of my conclusions to be definitively true, and I hope my language reflects that.
I am aware that some factual errors exist; for instance certain schools' locations are listed incorrectly.
There are also some key approximations, such as that the 2011 precincts were different from the other data sets (I took data modeling that change from the sources listed below).
However, I hope this is interesting and might spark some conversations around more rigorous studies.

Thank you!







Data sources:

Data (save all in Data folder):
Merged demographics with votes (Census_Data_by_Ward-Precinct_2015_and_2011-2.xlsx: Census_by_Precinct.csv, Census_by_Precinct_Edited.csv, 2011_by_Precinct) : http://illinoiselectiondata.com/?p=536
School closings (schools.csv) from https://github.com/amtamayo/schoolcuts
Precincts shp and csv from https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Precincts-current-/uvpq-qeeq
School utilization (201314enrollmentspace.csv) from http://cps.edu/qualityschools/pages/data.aspx
50 closed (50closed.csv) from http://www.wbez.org/news/chicago-proposes-closing-53-elementary-schools-firing-staff-another-6-106202


Instructions:

// Save Data/V2_Fall_2013_20th_Day_for_Publication-12-20-2013.xls as RoughData/201314enrollmentspace.csv
// Save Data/school closings.xls as RoughData/50closed.csv
// Save Census_Data_by_Ward-Precinct_2015_and_2011-2.xlsx, last sheet as Census_by_Precinct.csv, fourth as 2011_by_Precinct, and second as Census_by_Precinct_Edited.csv
// Use my Kimono web scrapers for 6 data sets
// Run CleanKimono.R
// Run ParsePrecincts.R
// Run ParseSchools.R
// Run SchoolScatterLinks.R
// cd Desktop/Independent\ Study/TestCartogram/Process


// This creates the shapefile
rm -f RoughData/delete.json
rm -f RoughData/delete.dbf
rm -f RoughData/delete.prj
rm -f RoughData/delete.shp
rm -f RoughData/delete.shx
ogr2ogr -select WARD,PRECINCT,FULL_TEXT -f 'ESRI Shapefile' -t_srs EPSG:4326 RoughData/delete.shp Data/Precincts__current_/PRECINCTS_2012.shp


// This adds the count for schools
In QGIS:
// Layer -> Add Layer -> Add Vector Layer -> delete.shp
// Add .csv -> SchoolsFinal.csv
// Vector -> Analysis -> Points in Polygon
// Output as PrecinctPtCnt.shp
// Vector -> Data Management Tools -> Join Attributes By Location
SchoolsFinal, Delete, Take summary of first located feature, Keep all records
Output as SchoolsFinal2 shapefile
Output as SchoolsFinal2.csv


// This adds the data to the shapes
// Run AddSchoolToPrecinct.R
topojson -o RoughData/PrecinctFinal.json -e  RoughData/PrecinctFinal.csv --id-property=+FULL_TEXT -p -- RoughData/PrecinctPtCnt.shp
sed -E 's/\"([0123456789])/\1/g' < RoughData/PrecinctFinal.json > RoughData/delete.json
sed -E 's/([0123456789])\"/\1/g' < RoughData/delete.json > RoughData/PrecinctFinal.json


// This hosts the site locally
python -m SimpleHTTPServer 8888 & 
// http://localhost:8888/


//NOTE: http://media.apps.chicagotribune.com/ward-redistricting-2012/index.html shows how precinct mapping is close but not exact
