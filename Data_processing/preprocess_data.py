"""
This python script pre-processes the hindcast member data into the correct format, before it is ran with
ensemble_cyclone_tracking.sh
"""

import xarray as xr
import sys
from pathlib import Path
sys.path.insert(0, str(Path("../src").resolve()))
import windrisk as wr

_ecmwf = True
if _ecmwf:
    filepath = '/uolstore/RIT/RITCore/Env/p0103/eewo/ECMWF_SEAS5C3Sv51/MSLP/'
    filename = 'MSLP_'
    year = 1981
    month = 9
    day = 1
    old_name = 'forecast_period'

ds = xr.open_dataset(filepath+filename+str(year)+'.nc')

#ECMWF files:
if _ecmwf:
    ds2 = wr.change_time_var(ds,old_name,year,month,day)
    ds2 = wr.delete_vars(ds2,'forecast_reference_time')
    ds2 = wr.transpose(ds2)
    ds2.to_netcdf(filepath+filename+str(year)+'_v2.nc')