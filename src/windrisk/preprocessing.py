import xarray as xr
import datetime
import numpy as np


def change_time_var(ds : xr.Dataset ,old_name : str ,
                    start_year : int, start_month : int, start_day : int) -> xr.Dataset :
    """
    Changes the time variable to key 'time', as this is needed in order to run
    NodesDetect.
    Also changes from units [ns] or [hrs] to dates.

    Parameters
    ----------------------------------------------------------------------------
    ds : The climate dataset
    
    old_name : Variable name for the forecasting time

    start_year : Hindcast start year

    start_month : The month the hindcast is initialised in

    start_day: The day the hindcast is initalised
    

    Returns
    ----------------------------------------------------------------------------
    ds_new : New dataset, with the 'time' variable name, describing the year
    month and day of each value, instead of the hours since hindcast start

    """
    start_date = datetime.datetime(start_year, start_month, start_day, 0, 0, 0)      
    valid_times = np.datetime64(start_date) + ds[old_name].values
    ds_2= ds.rename({old_name : 'time'})
    ds_new = ds_2.assign({"time": valid_times})
    return ds_new



def delete_vars(ds : xr.Dataset ,*args : str) -> xr.Dataset :
    """
    Delete extra variables in the dataset. DetectNode assumes ensemble member, 
    time, latitude, longitude dimensions

    Parameters
    ----------------------------------------------------------------------------
    ds : The climate dataset
    
    args : Variables that should be removed

    Returns
    ----------------------------------------------------------------------------
    ds_new : New dataset with the correct dimensions.

    """
    for ar in args:
        ds = ds.isel({ar: 0}, drop=True)
    return ds


def transpose(ds):
    """
    Transpose to correct order: time, ensemble_number, latitude, longitude

    Parameters
    ----------------------------------------------------------------------------
    ds : The climate dataset
    
    Returns
    ----------------------------------------------------------------------------
    ds_new : New dataset with the correct order.

    """
    ds = ds.transpose("time", "number", "latitude", "longitude")
    return ds