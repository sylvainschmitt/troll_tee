# mamba env create -f get_cmip6.yml 
# mamba activate get-cmip6
# python get_cmip6.py > log.txt

import os
from xmip.preprocessing import combined_preprocessing
from xmip.utils import google_cmip_col
from xmip.postprocessing import match_metrics
import matplotlib.pyplot as plt

col = google_cmip_col()

def get_var(var):
    # variables
    # tas: tas
    # pr: pr
    # ws: sfcWind
    # vpd: huss (from humidity)
    # snet: rsds-rsus
    cat = col.search(
        variable_id=var,
        activity_id=['CMIP', 'ScenarioMIP'],
        table_id='day',
        experiment_id=['historical', 'ssp126', 'ssp585'],
        grid_label='gn',
        member_id='r1i1p1f1',
        source_id=['ACCESS-CM2', 'CMCC-CM2-SR5', 'CMCC-ESM2', 'MPI-ESM1-2-LR', 'CanESM5', 'IITM-ESM', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR', 'NorESM2-MM']
    )
    # run_counts = cat.df.groupby(['source_id', 'experiment_id'])['zstore'].count()
    # run_counts
    dict = cat.to_dataset_dict(
        preprocess=combined_preprocessing,
        xarray_open_kwargs={'use_cftime':True},
    )
    for name, ds in dict.items():
        file="/home/sschmitt/Documents/troll_tee/data/raw_data/cmip6/" + var + "/" +  name + "_" + var + ".nc"
        if(not os.path.isfile(file)):
            ds2=ds.sel(x=-54.952, y=-2.897, method='nearest').sel(time=slice("1980-01-01 12:00:00", "2100-12-31 12:00:00"))
            ds2.to_netcdf(file)
            print(file + " done.")
        else:
            print(file + " skipped.")

for var in ['pr', 'sfcWind', 'tas', 'huss', 'rsus', "rsds"]:
    get_var(var)
    