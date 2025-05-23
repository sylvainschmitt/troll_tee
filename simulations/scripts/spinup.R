# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars
climate_file <- snakemake@input[[1]]
species_file <- snakemake@input[[2]]
soil_file <- snakemake@input[[3]]
folderout <- snakemake@output[[1]]
cra <- as.numeric(snakemake@params$cra)
crb <- as.numeric(snakemake@params$crb)
m <- as.numeric(snakemake@params$m)
a0 <- as.numeric(snakemake@params$a0)
b0 <- as.numeric(snakemake@params$b0)
delta <- as.numeric(snakemake@params$delta)
test <- snakemake@params$test

# test
# climate_file <- "data/derived_data/climate_spinup.tsv"
# species_file <- "data/derived_data/species.tsv"
# soil_file <- "data/derived_data/soil.tsv"
# folderout <- "results/spinup/R1"
# cra <- 2.45
# crb <- 0.7565
# m <- 0.040
# a0 <- 0.2
# b0 <- 0.015
# delta <- 0.2
# test <- TRUE

# libraries
library(tidyverse)
library(rcontroll)

# code
name <- tail(str_split_1(folderout, "/"), 1)

climate <- read_tsv(climate_file) %>% 
  arrange(date) %>% 
  filter(paste0(month(date), "-", day(date)) != "2-29") %>% 
  mutate(snet = ifelse(snet <= 1.1, 1.1, snet)) %>% 
  mutate(vpd = ifelse(vpd <= 0.011, 0.011, vpd)) %>% 
  mutate(ws = ifelse(ws <= 0.11, 0.11, ws))

clim <-   climate %>%
  mutate(time = hour(date)) %>%
  mutate(date = date(date)) %>%
  select(date, time, tas, pr) %>%
  mutate(tas = ifelse(time < 6, NA, tas)) %>%
  mutate(tas = ifelse(time >= 18, NA, tas)) %>%
  group_by(date) %>%
  summarise(
    NightTemperature = mean(tas, na.rm = TRUE),
    Rainfall = sum(pr, na.rm = TRUE)
  ) %>%
  select(-date)

ndays <- length(unique(date(climate$date)))
day <- climate %>% 
  rename(Temp = tas, Snet = snet, VPD = vpd, WS = ws) %>%
  mutate(time_hour = hour(date)) %>%
  filter(time_hour >= 6, time_hour < 18) %>%
  select(-time_hour) %>%
  mutate(time_numeric = hour(date) + minute(date) / 60) %>%
  mutate(DayJulian = rep(1:ndays, each = 24)) %>% 
  select(DayJulian, time_numeric, Temp, Snet, VPD, WS)

n <- as.numeric(nrow(clim))
if(test)
  n <- 10

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

species <- read_tsv(species_file) %>% 
  rename(name = scientific, dbhmax = dbhthres, hmax = hlim) %>% 
  rename_all(~ paste0("s_", .)) %>% 
  mutate(s_name = gsub(" ", "_", s_name)) %>% 
  mutate(s_seedmass = 1, s_regionalfreq = 1/n()) %>% 
  select(s_name, s_LMA, s_Nmass, s_Pmass, s_wsg, s_dbhmax, s_hmax, s_ah,
         s_seedmass, s_regionalfreq, s_tlp, s_leafarea)

soil <- read_tsv(soil_file)

sim <- troll(
  name = name,
  path = gsub(name, "", folderout),
  global = parameters,
  species = species,
  climate = clim,
  daily = day,
  pedology = soil,
  load = FALSE,
  verbose = TRUE,
  overwrite = TRUE
)
