#!/bin/bash
mslp_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/MSLP/"
uwind10_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/cyclone_tracks/"
vwind10_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/cyclone_tracks/"
track_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/cyclone_tracks/"
footprint_path="/uolstore/RIT/RITCore/Env/p0103/eewo/ERA5/footprint/"

#Use NodeFileFilter at 5 degree seperation
for year in {1983..2025}; do
    next_year=$((year + 1))

    months=(
        "${year}_09"
        "${year}_10"
        "${year}_11"
        "${year}_12"
        "${next_year}_01"
        "${next_year}_02"
        "${next_year}_03"
    )
    
    #This code extracts the u and v footprints of the cyclones
    # for month in "${months[@]}"; do
    #     NodeFileFilter \
    #     --in_nodefile "$data_path/tracks_${year}.nc"\
    #     --in_fmt "lon,lat,msl" \
    #     --in_data "$uwind10_path/u10m_${year}_${month}.nc;$vwind10_path/v10m_${year}_${month}.nc" \
    #     --out_data "$footprint_path/wind_footprint_${year}_${month}.nc" \
    #     --latname "latitude" \
    #     --lonname "longitude" \
    #     --regional \
    #     --var "u10,v10" \
    #     --bydist 5.0 \
    #     --maskvar "cyclone_mask"


    #This calculates the footprints of the cyclones
    for month in "${months[@]}"; do
        NodeFileFilter \
        --in_nodefile "$track_path/tracks_${year}.txt"\
        --in_fmt "lon,lat,msl" \
        --in_data "$mslp_path/MSLP_${month}.nc" \
        --out_data "$footprint_path/wind_footprint_${year}_${month}.nc" \
        --latname "latitude" \
        --lonname "longitude" \
        --regional \
        --var "msl" \
        --bydist 5.0 \
        --maskvar "cyclone_mask" || break
    done
done