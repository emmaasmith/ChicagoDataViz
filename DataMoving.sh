#!/bin/bash

cd Data
ogr2ogr -f 'ESRI Shapefile' -t_srs EPSG:4326 out2.shp CommAreas.shp
topojson -o output2.json -- out2.shp



