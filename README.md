# Wind Risk

----------------------------------------------------------------------------------------------------
# Files

-**Bash_scripts/** - Scripts for running TempestExtremes.

-**Jupyter_notebook_scripts/** — Notebooks for inspecting datasets.

-**src/windrisk/** - Python package with reusable function.

```text
wind_risk
 ├── Bash_scripts
 │   ├── ERA5_cyclone_tracking.sh
 ├── Jupyter_notebook_scripts
 │   ├── open_cyclone_tracks.ipynb
 │   └── open_dataset_files.ipynb
 ├── src
 │   └──  windrisk/
 ├── LICENSE
 ├── .gitignore
 └── README.md
```
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

Forecasting systems: ECMWF SEAS5 C3Sv5.1, Meteo-France System9, UKMO GloSea6, NCEP CFSv2,
ECCC CanESM5.1p1bc System 4, ECCC GEM5.2-NEMO System 5, BOM ACCESS-S2 System 2

Area selection: 90N - 0S, -130W - 60E

Hindcasts that are run for 7 months are downloaded that are initalised in September.
Data is therefore present from September - March.

ERA5 is downloaded from 1980 - 2026 present, to match the timescale of the hindcasts.

--------------------------------------------------------------------------------------------------
## Packages to download

```bash
mamba install xarray dask matplotlib scipy shapely pyproj netcdf4 numba cmcrameri numpy ipykernel cartopy
python -m ipykernel install --user --name=<name_of_environment>
conda install -c conda-forge tempest-extremes

```

---------------------------------------------------------------------------------------------------
## Tracking extratropical cyclones (ETC)

Variables: sea level pressure

Download the TempestExtremes package 

### Criteria for tracking ETC:

As in [Ullrich et al 2021](https://gmd.copernicus.org/articles/14/5023/2021/#bib1.bibx90):
* Min pressure encloses a contour of 200hPa within 6.0 degree of cyclone center.
* Min pressures within 6.0 degrees of each other are merged.
* Storms need to persist for min 60 hours.
* Max gap between detections 18h.
* Track needs to overlap 24 - 52 degree N and 234 - 294 E
* Tracks must move at least 12 Great Circle Distances

### For ERA5 dataset
1. Change the file directories inside ERA5_cyclone_tracking.sh, to where the correct file inputs are / outputs should be.
2. Run:
```bash
./ERA5_cyclone_tracking.sh
```


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





