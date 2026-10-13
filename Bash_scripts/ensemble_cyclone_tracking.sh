#!/bin/bash

#MSLP needs to be in Pa, not in hPa for this code
data_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ECMWF_SEAS5C3Sv51/MSLP"
node_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ECMWF_SEAS5C3Sv51/cyclone_detect_nodes"
track_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ECMWF_SEAS5C3Sv51/cyclone_tracks"
no_of_members=24 #from 0 - 24

for year in 1981; do
  for member in {0..24}; do
#-------------------------RUN DETECTNODES------------------------------
    DetectNodes \
      --in_data "$data_path/MSLP_${year}_v2.nc" \
      --out "$node_path/detect_nodes_${year}_${member}.txt" \
      --latname "latitude" \
      --lonname "longitude" \
      --searchbymin "msl(${member})" \
      --regional \
      --mergedist 6.0 \
      --closedcontourcmd "msl(${member}),200.0,6.0,0" \
      --outputcmd "msl(${member}),min,0" || exit 1
#-------------------------RUN DETECTNODES------------------------------
  done
done

