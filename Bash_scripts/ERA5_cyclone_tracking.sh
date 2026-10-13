#!/bin/bash

#MSLP needs to be in Pa, not in hPa for this code
data_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/MSLP/"
node_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/cyclone_detect_nodes/"
track_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/cyclone_tracks/"


for year in {1980..2025}; do
  next_year=$((year+1))
  extended_winter=(
    "${year}_09" 
    "${year}_10"
    "${year}_11"
    "${year}_12"
    "${next_year}_01"
    "${next_year}_02"
    "${next_year}_03"
  )

#-------------------------RUN DETECTNODES------------------------------
  for month in "${extended_winter[@]}"; do
    DetectNodes \
      --in_data "$data_path/MSLP_${month}.nc" \
      --out "$node_path/detect_nodes_${month}.txt" \
      --latname "latitude" \
      --lonname "longitude" \
      --searchbymin "msl" \
      --regional \
      --mergedist 6.0 \
      --closedcontourcmd "msl,200.0,6.0,0" \
      --outputcmd "msl,min,0" || break
#-------------------------RUN DETECTNODES------------------------------
    done
  done

#Find all files that are in a specific extended winter September to March
#-------------------------MERGE FILES------------------------------
for year in {1980..2025}; do
  next_year=$((year+1))
  cat \
    "$node_path/detect_nodes_${year}_09.txt" \
    "$node_path/detect_nodes_${year}_10.txt" \
    "$node_path/detect_nodes_${year}_11.txt" \
    "$node_path/detect_nodes_${year}_12.txt" \
    "$node_path/detect_nodes_${next_year}_01.txt" \
    "$node_path/detect_nodes_${next_year}_02.txt" \
    "$node_path/detect_nodes_${next_year}_03.txt" \
    > "$node_path/all_detect_nodes_${year}.txt" || exit 1

  rm \
    "$node_path/detect_nodes_${year}_09.txt" \
    "$node_path/detect_nodes_${year}_10.txt" \
    "$node_path/detect_nodes_${year}_11.txt" \
    "$node_path/detect_nodes_${year}_12.txt" \
    "$node_path/detect_nodes_${next_year}_01.txt" \
    "$node_path/detect_nodes_${next_year}_02.txt" \
    "$node_path/detect_nodes_${next_year}_03.txt" 
done
#-------------------------MERGE FILES------------------------------


#Find all files that are in a specific extended winter September to March
#-------------------------Stitch Nodes------------------------------
for year in {1980..2025}; do

  StitchNodes \
  --in "$data_path/all_detect_nodes_${year}.txt" \
  --out "$output_path/tracks_${year}.txt" \
  --in_fmt "lon,lat,msl" \
  --range 6.0 \
  --mintime "60h" \
  --maxgap 18h \
  --min_endpoint_dist 12.0 \
  --threshold "lat,>,24,1;lon,>,-126,1;lat,<,52,1;lon,<,-66,1" || exit 1
  done
#-------------------------Stitch Nodes------------------------------
