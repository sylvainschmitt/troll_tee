# Raw data
Sylvain Schmitt -
Apr 17, 2025

All raw data for the analyses. They are all retrieved from the Lartge
Scale Biosphere-Atmosphere Experiment (LBA-ECO,
<https://daac.ornl.gov/cgi-bin/dataset_lister.pl?p=11>) available at the
Oak Ridge National Laboratory Distributed Active Archive Center (ORNL
DAAC). See the “Data” section.

``` r
fs::dir_tree()
```

    .
    ├── CD02_Forest_Canopy_Structure_1009
    │   ├── comp
    │   │   └── CD02_Forest_Canopy_Structure.pdf
    │   ├── data
    │   │   ├── CD02_LAI_measurements_TNF.csv
    │   │   └── CD02_SLA_measurements_TNF.csv
    │   └── guide
    │       └── Online_Version_CD02_Forest_Canopy_Structure.html
    ├── CD02_Leaf_Level_Gas_Exchange_1010
    │   ├── comp
    │   │   └── CD02_Leaf_Level_Gas_Exchange.pdf
    │   ├── data
    │   │   └── CD02_Leaf_Level_Gas_Exchange.csv
    │   └── guide
    │       └── Online_Version_CD02_Leaf_Level_Gas_Exchange.html
    ├── CD02_Leaf_Water_Potential_1100
    │   ├── comp
    │   │   └── CD02_Leaf_Water_Potential.pdf
    │   ├── data
    │   │   └── CD02_Leaf_Water_Potential.csv
    │   └── guide
    │       └── Online_Version_CD02_Leaf_Water_Potential.html
    ├── CD05_Micromet_1169
    │   ├── comp
    │   │   └── CD05_Micromet.pdf
    │   ├── data
    │   │   ├── Rainfall_REE_plots_1999_2006.csv
    │   │   ├── Temp_RH_REE_plots_2000_2003.csv
    │   │   └── VWC_REE_plots_1999_2007.csv
    │   └── guide
    │       └── Online_Version_CD05_Micromet.html
    ├── CD10_Biometry_Tapajos_854
    │   ├── comp
    │   │   └── CD10_Biometry_Tapajos.pdf
    │   ├── data
    │   │   └── lba_km67_dend_dbhs_filled_archive.txt
    │   └── guide
    │       └── Online_Version_CD10_Biometry_Tapajos.html
    ├── CD10_DBH_Tapajos_859
    │   ├── comp
    │   │   ├── CD10_DBH_Tapajos.pdf
    │   │   ├── Census_report_Guimaraes_Pyle_1999.pdf
    │   │   ├── DBH_names_common_sort.csv
    │   │   └── DBH_names_species_sort.csv
    │   ├── data
    │   │   └── km_67_tree_surveys_99_05.csv
    │   └── guide
    │       └── Online_Version_CD10_DBH_Tapajos.html
    ├── CD10_EddyFlux_Tapajos_860
    │   ├── comp
    │   │   ├── CD10_EddyFlux_Tapajos.pdf
    │   │   └── hutyra_thesis.pdf
    │   ├── data
    │   │   └── km67_eddyflux_2002_2006.txt
    │   └── guide
    │       └── Online_Version_CD10_EddyFlux_Tapajos.html
    ├── CD10_H2O_Profiles_Tapajos_861
    │   ├── comp
    │   │   ├── CD10_H2O_Profiles_Tapajos.pdf
    │   │   └── hutyra_thesis.pdf
    │   ├── data
    │   │   └── km67_h2o_profile_2002_2006.txt
    │   └── guide
    │       └── Online_Version_CD10_H2O_Profiles_Tapajos.html
    ├── CD10_Litter_Tapajos_862
    │   ├── comp
    │   │   └── CD10_Litter_Tapajos.pdf
    │   ├── data
    │   │   └── lba_km67_litter_archive.txt
    │   └── guide
    │       └── Online_Version_CD10_Litter_Tapajos.html
    ├── CD10_Temperature_Profiles_Tapajos_863
    │   ├── comp
    │   │   ├── CD10_Temperature_Profiles_Tapajos.pdf
    │   │   └── hutyra_thesis.pdf
    │   ├── data
    │   │   └── km67_temp_profile_2002_2006.txt
    │   └── guide
    │       └── Online_Version_CD10_Temperature_Profiles_Tapajos.html
    ├── CD15_Productivity_1167
    │   ├── comp
    │   │   └── CD15_Productivity.pdf
    │   ├── data
    │   │   ├── CD15_Dendrometer_measurements_2003_2004.csv
    │   │   ├── CD15_LAI_2004.csv
    │   │   ├── CD15_Litterfall_km67_2004.csv
    │   │   └── CD15_dendrometry_dates.csv
    │   └── guide
    │       └── Online_Version_CD15_Productivity.html
    ├── CD32_LBA_MIP_Drivers_1177
    │   ├── comp
    │   │   ├── CD32_LBA_MIP_Drivers.pdf
    │   │   ├── CD32_MIPDrivers_Sites.pdf
    │   │   ├── driver_data.pdf
    │   │   └── lba_mip_protocol4.0_20100309.pdf
    │   ├── data
    │   │   ├── Santarem_KM67
    │   │   │   ├── Santarem_KM67_2002.uaz.100217LWnet.leap.nc
    │   │   │   ├── Santarem_KM67_2002uaz.100217LWnet.leap.txt
    │   │   │   ├── Santarem_KM67_2003.uaz.100217LWnet.leap.nc
    │   │   │   ├── Santarem_KM67_2003uaz.100217LWnet.leap.txt
    │   │   │   ├── Santarem_KM67_2004.uaz.100217LWnet.leap.nc
    │   │   │   └── Santarem_KM67_2004uaz.100217LWnet.leap.txt
    │   │   └── Santarem_KM83
    │   │       ├── Santarem_KM83_2001.uaz.100217LWnet.leap.nc
    │   │       ├── Santarem_KM83_2001uaz.100217LWnet.leap.txt
    │   │       ├── Santarem_KM83_2002.uaz.100217LWnet.leap.nc
    │   │       ├── Santarem_KM83_2002uaz.100217LWnet.leap.txt
    │   │       ├── Santarem_KM83_2003.uaz.100217LWnet.leap.nc
    │   │       └── Santarem_KM83_2003uaz.100217LWnet.leap.txt
    │   └── guide
    │       └── Online_Version_CD32_LBA_MIP_Drivers.html
    ├── LC14_Aboveground_Prod_1196
    │   ├── comp
    │   │   └── LC14_Aboveground_Prod.pdf
    │   ├── data
    │   │   ├── Canopy_density_REE_plots_1998_2004.csv
    │   │   ├── Coarse_litter_REE_plots_1998_2006.csv
    │   │   ├── Dendrometer_DBH_REE_Plots_1999_2006.csv
    │   │   ├── Fine_Litter_REE_plots_1998_2006.csv
    │   │   ├── LAI_REE_plots_1999_2006.csv
    │   │   ├── REE_Dendrometer_Midpoint_dates.txt
    │   │   └── Stem_inventory_REE_plots_2000_2004.csv
    │   └── guide
    │       └── Online_Version_LC14_Aboveground_Prod.html
    ├── ND02_REE_Soil_VWC_1061
    │   ├── comp
    │   │   └── ND02_REE_Soil_VWC.pdf
    │   ├── data
    │   │   ├── Seca_Floresta_actual_vs_simulated_VWC_control_plot.csv
    │   │   ├── Seca_Floresta_actual_vs_simulated_VWC_treatment_plot.csv
    │   │   ├── Seca_Floresta_simulated_VWC_control_plot.csv
    │   │   └── Seca_Floresta_simulated_VWC_treatment_plot.csv
    │   └── guide
    │       └── Online_Version_ND02_REE_Soil_VWC.html
    ├── ND30_REE_Water_Chemistry_1131
    │   ├── comp
    │   │   └── ND30_REE_Water_Chemistry.pdf
    │   ├── data
    │   │   ├── Litter_leachate.csv
    │   │   ├── Lysimeter.csv
    │   │   ├── Rainfall.csv
    │   │   └── Throughfall.csv
    │   └── guide
    │       └── Online_Version_ND30_REE_Water_Chemistry.html
    ├── README.md
    ├── README.qmd
    └── README.rmarkdown
