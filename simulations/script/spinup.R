# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
filein <- snakemake@input[[1]]
folderin <- snakemake@input[[2]]
folderout <- snakemake@output[[1]]
site <- as.character(snakemake@params$site)
rep <- as.numeric(snakemake@params$rep)
a0 <- as.numeric(snakemake@params$a0)
b0 <- as.numeric(snakemake@params$b0)
delta <- as.numeric(snakemake@params$delta)
cra <- as.numeric(snakemake@params$cra)
crberr <- as.numeric(snakemake@params$crberr)
m <- as.numeric(snakemake@params$m)
dstart <- as.numeric(snakemake@params$dstart)
dend <- as.numeric(snakemake@params$dend)
verbose <- snakemake@params$verbose
test <- snakemake@params$test
test_years <- snakemake@params$test_years

# test
# filein <- "results/run/GF-Guy_2004-2014_climate.tsv"
# folderout <- "results/spinup//GF-Guy_2004-2014"
# folderout <- "results/run/GF-Guy_2004-2014"
# site <- "GF-Guy_2004-2014"
# verbose <- TRUE
# test <- TRUE
# test_years <- 0.1

# libraries
library(tidyverse)
library(rcontroll)
library(vroom)

# code
name <- paste0(site, "_R", rep)

climate <- vroom(filein) %>% 
  arrange(time) %>% 
  filter(paste0(month(time), "-", day(time)) != "2-29") %>% 
  mutate(snet = ifelse(snet <= 1.1, 1.1, snet)) %>% 
  mutate(vpd = ifelse(vpd <= 0.011, 0.011, vpd)) %>% 
  mutate(ws = ifelse(ws <= 0.11, 0.11, ws))
clim <- generate_climate(climate, 
                         daytime_start = dstart, 
                         daytime_end = dend)
day <- generate_dailyvar(climate, 
                         daytime_start = dstart, 
                         daytime_end = dend)

spinup <-  load_output(name = paste0(site, "_", a0, "_", b0, "_", delta),
                       path = folderin)

n <- as.numeric(nrow(clim))
if(test)
  n <- round(test_years*365)

crb = -0.39 + 0.57*cra + crberr
parameters <- generate_parameters(nbiter = n,
                                  klight = 0.5,
                                  phi = 0.10625,
                                  absorptance_leaves = 0.83,
                                  sigma_height = 0.19,
                                  sigma_CR = 0.29,
                                  sigma_CD = 0.0,
                                  sigma_P = 0.24,
                                  sigma_N = 0.12,
                                  sigma_LMA = 0.24,
                                  sigma_wsg = 0.06,
                                  sigma_dbhmax = 0.05,
                                  corr_CR_height = 0.0,
                                  corr_N_P = 0.65,
                                  corr_N_LMA = -0.43,
                                  corr_P_LMA = -0.39,
                                  Cair = 375,
                                  LL_parameterization = 0,
                                  pheno_a0 = a0,
                                  pheno_b0 = b0,
                                  pheno_delta = delta,
                                  CR_a = cra,                                    
                                  CR_b = crb,
                                  m = m,
                                  m1 = m)
seed <- sample.int(.Machine$integer.max, 1)
parameters <- mutate(parameters, value = ifelse(param == "Rseed", seed, value))
  
sim <- troll(
  name = name,
  path = gsub(name, "", folderout),
  global = parameters,
  species = spinup@inputs$species, 
  climate = clim,
  daily = day,
  pedology = spinup@inputs$pedology, 
  forest = get_forest(spinup),
  soil = get_soil(spinup), 
  load = FALSE,
  verbose = verbose,
  overwrite = TRUE
)
