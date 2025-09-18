# snakemake log
log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

# snakemake vars

folderin <- snakemake@input[[1]]
climate_file <- snakemake@input[[2]]
folderout <- snakemake@output[[1]]
s <- as.character(snakemake@params$scenario)
g <- as.character(snakemake@params$gcm)
test <- snakemake@params$test

# test
# climate_file <- "data/derived_data/projections_hh.tsv"
# folderin <- "simulations/results/spinup/R1"
# folderout <- "simulations/results/SSP126/MIP-ESM1-2-LR/R1"
# s <- "SSP126"
# g <- "MPI-ESM1-2-LR"
# test <- TRUE

# libraries
library(tidyverse)
library(rcontroll)

# code
name <- tail(str_split_1(folderout, "/"), 1)

climate <- read_tsv(climate_file) %>% 
  filter(gcm == g, experiment %in% c("historical", tolower(s))) %>% 
  select(-gcm, -experiment) %>% 
  arrange(date) %>% 
  filter(paste0(month(date), "-", day(date)) != "2-29") %>% 
  mutate(snet = ifelse(is.na(snet), 0, snet)) %>% 
  mutate(pr = ifelse(pr < 0, 0, pr)) %>% 
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

spinup <-  load_output(name = name,
                       path = folderin)

parameters <- spinup@inputs$global

n <- as.numeric(nrow(clim))
if(test)
  n <- 10
parameters <- mutate(parameters, value = ifelse(param == "nbiter", n, value))

seed <- sample.int(.Machine$integer.max, 1)
parameters <- mutate(parameters, value = ifelse(param == "Rseed", seed, value))

species <- spinup@inputs$species

pedology <- spinup@inputs$pedology

soil <- get_soil(spinup)

forest <- get_forest(spinup)

sim <- troll(
  name = name,
  path = gsub(name, "", folderout),
  global = parameters,
  species = species,
  climate = clim,
  daily = day,
  pedology = pedology,
  forest = forest,
  soil = soil,
  load = FALSE,
  verbose = TRUE,
  overwrite = TRUE
)
