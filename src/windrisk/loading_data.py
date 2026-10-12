def open_track_dataset(track_path: str,year: int) -> list:
    """
    Open track files from StitchNodes TempestExtremes

    Parameters
    ----------------------------------------------------------------------------
    track_path : String of directory of the track. Tracks need to be labeled as
    tracks_<year>.txt in this directory
    
    year : The extended winter year of the tracks

    Returns
    ----------------------------------------------------------------------------
    lines : All the lines of the file, where 'start' marks a new track,
    and afterwards each line describes the associated cyclone track on a specific
    time step, showing the i (lon location), j (latitude location), longitude (degrees),
    latitude (degrees), MSLP, Year, Month, Day, Hour
    """
    with open(track_path+'/tracks_'+str(year)+'.txt','r') as f:
        lines = [line.replace("\n","").replace("\t"," ").split() for line in f]
    return lines
