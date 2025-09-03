# Importing libraries to work with

library(tidyverse)
library(dplyr)
library(readr)

# Initial dataset

file <- read.csv("C:/Users/hamza/Downloads/hour.csv")

# Cleaning data
# Note that weathersit goes from 1 to 4 with is Good to Bad
data <- file %>%
  mutate(season = case_when(
    season == 1 ~ "Spring",
    season == 2 ~ "Summer",
    season == 3 ~ "Fall",
    season == 4 ~ "Winter",
  ),
  workingday = case_when(
    workingday == 0 ~ "No",
    workingday == 1 ~ "Yes"
  ),
  holiday = case_when(
    holiday == 0 ~ "Not Public",
    holiday == 1 ~ "Public"
  ),
  Month = mnth,
  Year = yr + 2011,
  Windspeed = windspeed * 67,
  Temperature = temp * 41) %>%
  rename(Date = dteday,
         Total_rentals = cnt, humidity = hum, Hour = hr) %>%

# Droping useless columns

  select(-yr, -mnth, -atemp, -temp, -windspeed, -holiday, -instant) %>%

# Regrouping columns

  relocate(season, Date, Year,
           Month, weekday, Hour, workingday,
           weathersit, humidity, Windspeed,
           Temperature, .after = 1)

# Exporting clean data

write.csv(data, file = "Dataa.csv", row.names = FALSE)
