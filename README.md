# Wind Risk

----------------------------------------------------------------------------------------------------
## Files in this repository

- **Bash_scripts/** - Scripts for running TempestExtremes.

- **Jupyter_notebook_scripts/** — Notebooks for inspecting datasets.

- **src/windrisk/** - Python package with reusable function.

- **Data_processing/** - Makes hindcast data compatable with the TempestExtremes code

```text
wind_risk
 ├── Bash_scripts
 │   └── ERA5_cyclone_tracking.sh
 ├── Data_processing
 │   └── preprocess_data.py
 ├── Jupyter_notebook_scripts
 │   ├── open_cyclone_tracks.ipynb
 │   ├── open_cyclone_footpath.ipynb
 │   └── open_dataset_files.ipynb
 ├── src
 │   └── windrisk
 │       ├── __init__.py
 │       └── loading_data.py
 ├── LICENSE
 ├── .gitignore
 └── README.md
```
----------------------------------------------------------------------------------------------------
#                                   Downloading climate data
----------------------------------------------------------------------------------------------------
## Using Mamba to download datasets:

```bash

wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

bash Miniforge3-Linux-x86_64.sh

source ~/miniforge3/bin/activate

mamba create -n download_data

mamba activate download_data
```

Then follow instructions on https://cds.climate.copernicus.eu/how-to-api on how to download CDS data.

---------------------------------------------------------------------------------------------------
## Hindcasts from Copernicus are downloaded, from the climate data store

Variables: MSLP (for ERA5) or SLP, horizontal wind components at 10m

Time : Every 6 hours, at 00:00, 06:00, 12:00 and 18:00

Grid spacing: 1 x 1 degree (to match the resolution of hindcast data)

Hindcasts used:

Forecasting System                 | Number of ensemble memberes
-----------------------------------| -----------------------------
ECMWF SEAS5 C3Sv5.1,               | 25
Meteo-France System9               | 31
UKMO GloSea6                       | 28
NCEP CFSv2                         | 30
ECCC CanESM5.1p1bc System 4        | 20
ECCC GEM5.2-NEMO System 5          | 20
BOM ACCESS-S2 System 2             | 27

Area selection: 90N - 0S, -130W - 60E

Hindcasts that are run for 7 months are downloaded that are initalised in September.
Data is therefore present from September - March.

ERA5 is downloaded from 1980 - 2026 present, to match the timescale of the hindcasts.

--------------------------------------------------------------------------------------------------
#                                   Analysing data
--------------------------------------------------------------------------------------------------

## Packages to download

```bash
mamba install xarray dask matplotlib scipy shapely pyproj netcdf4 numba cmcrameri numpy ipykernel cartopy
python -m ipykernel install --user --name=<name_of_environment>
conda install -c conda-forge tempest-extremes

```
---------------------------------------------------------------------------------------------------
## Tracking extratropical cyclones (ETC)

Variables: (mean) sea level pressure

Download the TempestExtremes package (see section above)

### Criteria for tracking ETC:

As in [Ullrich et al 2021](https://gmd.copernicus.org/articles/14/5023/2021/#bib1.bibx90):
* Min pressure encloses a contour of 200hPa within 6.0 degree of cyclone center.
* Min pressures within 6.0 degrees of each other are merged.
* Storms need to persist for min 60 hours.
* Max gap between detections 18h.
* Track needs to overlap 24 - 52 degree N and 234 - 294 E
* Tracks must move at least 12 Great Circle Distances

### Track extratropical cyclones in ERA5 dataset
1. Change the file directories inside ERA5_cyclone_tracking.sh, to where the correct file inputs are / outputs should be.
2. Run:
```bash
./Bash_scripts/ERA5_cyclone_tracking.sh
```

### Track extratropical cyclones in hindcast datasets

1. Change file names, start dates and run Data_processing/preprocess_data.py to change dataset format for compatability
with the TempestExtreme dataset
```bash
python preprocess_data.py > preprocess_data.out
```

2. Change number of ensembles in  ensemble_cyclone_tracking.sh, filenames and start dates
```bash
./Bash_scripts/ensemble_cyclone_tracking.sh
```

_Step 2 takes about ~1.3 hours to run one year of an ensemble hindcast_

### Calculating the footprint of the cyclone

The footprint is found by applying a 5° Great Circle Distance from the center of the cyclone, using NodeFileFilter, from the TempestExtremes package.

---------------------------------------------------------------------------------------------------
## Calculating the SSI index

$$ SSI = \sqrt[3]{\frac{\sum_{i \epsilon \Omega_0 } (v_i - v_0)^3 A_i}{\sum_{i \epsilon \Omega}A_j}} $$

Variables: ERA5 max 10m wind gust (to estimate wind gusts), horizontal winds at 10m

----------------------------------------------------------------------------------------------------
## Useful links and references

Tracking is done through the TempestExtremes package, following the method in:

[Zarzycki CM. Projecting changes in societally impactful northeastern US snowstorms. Geophysical Research Letters. 2018 Nov 16;45(21):12-067.](https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2018GL079820)

TempestExtremes package is explained in:

[Ullrich PA, Zarzycki CM, McClenny EE, Pinheiro MC, Stansfield AM, Reed KA. TempestExtremes v2. 1: A community framework for feature detection, tracking, and analysis in large datasets. Geoscientific Model Development. 2021 Aug 13;14(8):5023-48.](https://gmd.copernicus.org/articles/14/5023/2021/#bib1.bibx90)

Storm severity index is explained in:

[Maddison JW, Catto JL, Hansen S, Justin Ng CH, Siegert S. Using seasonal forecasts to enhance our understanding of extreme wind and precipitation impacts from extratropical cyclones. Natural Hazards and Earth System Sciences. 2026 Feb 19;26(2):827-44.](https://nhess.copernicus.org/articles/26/827/2026/)





