# Wind Risk

----------------------------------------------------------------------------------------------------
## Using Mamba to download datasets:

$wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

Then 

$bash Miniforge3-Linux-x86_64.sh

$source ~/miniforge3/bin/activate

$mamba create -n download_data

$conda activate download_data

Follow instructions on: https://cds.climate.copernicus.eu/how-to-api

---------------------------------------------------------------------------------------------------
## Hindcasts from Copernicus are downloaded, from the climate data store

Variables: MSLP (for ERA5) or SLP, horizontal wind components at 10m

Time : Every 6 hours, at 00:00, 06:00, 12:00 and 18:00

Grid spacing: 1 x 1 degree (to match the resolution of hindcast data)

Forecasting systems: ECMWF SEAS5 C3Sv5.1, Meteo-France System9, UKMO GloSea6, NCEP CFSv2,
ECCC CanESM5.1p1bc System 4, ECCC GEM5.2-NEMO System 5, BOM ACCESS-S2 System 2

Area selection: 90N - 0S, -110W - 60E

Hindcasts that are run for 7 months are downloaded that are initalised in September.
Data is therefore present from September - March.

ERA5 is downloaded from 1980 - 2026 present, to match the timescale of the hindcasts.

---------------------------------------------------------------------------------------------------
##Tracking extratropical cyclones

Data needed: sea level pressure



----------------------------------------------------------------------------------------------------
## Useful links and references

Tracking is done through the TempestExtremes package, following the method in:

[Zarzycki CM. Projecting changes in societally impactful northeastern US snowstorms. 
Geophysical Research Letters. 2018 Nov 16;45(21):12-067.](https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2018GL079820)

TempestExtremes package is explained in:

[Ullrich PA, Zarzycki CM, McClenny EE, Pinheiro MC, Stansfield AM, Reed KA. TempestExtremes v2. 1: A community framework for feature detection, tracking, and analysis in large datasets. Geoscientific Model Development. 2021 Aug 13;14(8):5023-48.](https://gmd.copernicus.org/articles/14/5023/2021/#bib1.bibx90)

Storm severity index is explained in:

[Maddison JW, Catto JL, Hansen S, Justin Ng CH, Siegert S. Using seasonal forecasts to enhance our understanding of extreme wind and precipitation impacts from extratropical cyclones. Natural Hazards and Earth System Sciences. 2026 Feb 19;26(2):827-44.](https://nhess.copernicus.org/articles/26/827/2026/)





