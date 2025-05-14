# mamba env create -f get_cmip6.yml 
# mamba activate get-cmip6
# python get_cmip6.py > log.txt

import os
import pandas as pd
import gcsfs
import xarray as xr
import xesmf as xe
import numpy as np
from datetime import datetime as dt

gcs = gcsfs.GCSFileSystem(token='anon')
df = pd.read_csv('https://storage.googleapis.com/cmip6/cmip6-zarr-consolidated-stores.csv')
df_ta = df.query("activity_id == 'ScenarioMIP' & table_id == '3hr' & experiment_id == ['ssp126','ssp585'] & variable_id == ['tas']")
# variables
# tas: tas
# pr: pr
# ws: uas+vas
# vpd: huss (from humidity)
# snet: rsds-rsus+rlds-rlus
# https://github.com/DownClim/DownClim_msc/blob/main/scripts/get_cmip6.py
zstore = df_ta.zstore.values[-1]
mapper = gcs.get_mapper(zstore)
ds = xr.open_zarr(mapper, consolidated=True)
ds = ds.sel(lon=-54.952, lat=-2.897, method='nearest')
ds2 = ds.sel(time=slice("2015-01-01 03:00:00", "2015-01-10 03:00:00"))
ds2.to_netcdf("test.nc")
tab = ds[["tas"]].to_dataframe()

