# mamba env create -f get_era_ee.yml 
# mamba activate get-era-ee
# python get_era_ee.py > log_ee.txt

import pandas as pd
import ee
import xarray as xr

ee.Initialize(project="ee-sylvainmschmitt", opt_url='https://earthengine-highvolume.googleapis.com')
ic = ee.ImageCollection("ECMWF/ERA5_LAND/HOURLY").filter(ee.Filter.date('1980-01-01', '2025-01-01'))
leg = ee.Geometry.Rectangle(-54.952, -2.897, -54.952, -2.897)
ds = xr.open_mfdataset([ic], engine='ee', projection=ic.first().select(0).projection(), geometry=leg, fast_time_slicing=True)
tab = ds[['dewpoint_temperature_2m', 'temperature_2m', 'surface_net_solar_radiation', 'surface_pressure',
          'u_component_of_wind_10m', 'v_component_of_wind_10m', 'total_precipitation_hourly']].to_dataframe()
tab.to_csv("era5_tapajos.tsv", sep="\t", index=True)
