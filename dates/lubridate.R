library(lubridate)
library(readr)
library(dplyr)
library(ggplot2)

# Import CSV with read_csv()
akl_daily_raw <- read_csv("akl_weather_daily.csv")

# Print akl_daily_raw
akl_daily_raw

# Parse date 
akl_daily <- akl_daily_raw %>%
  mutate(date = as.Date(date))

# Print akl_daily
akl_daily

# Plot to check work
ggplot(akl_daily, aes(x = date, y = max_temp)) +
  geom_line() 


##
releases <- read_csv("rversions.csv")

head(releases)

release_time <- releases$datetime

library(lubridate)

# Examine the head() of release_time
head(release_time)

# Examine the head() of the months of release_time
head(month(release_time))

# Extract the month of releases 
month(release_time) %>% table()

# Extract the year of releases
year(release_time) %>% table()

# How often is the hour before 12 (noon)?
mean(hour(release_time) < 12)

# How often is the release in am?
mean(am(release_time))

library(ggplot2)
library(dplyr)
library(ggridges)

# Add columns for year, yday and month
akl_daily <- akl_daily %>%
  mutate(
    year = year(date),
    yday = yday(date),
    month = month(date, label = TRUE))

# Plot max_temp by yday for all years
ggplot(akl_daily, aes(x = yday, y = max_temp)) +
  geom_line(aes(group = year), alpha = 0.5)

# Examine distribtion of max_temp by month
ggplot(akl_daily, aes(x = max_temp, y = month, height = ..density..)) +
  geom_density_ridges(stat = "density")


## Extracting for filtering and summarizing
# Create new columns hour, month and rainy
akl_hourly_raw <- read_csv("akl_weather_hourly_2016.csv")
head(akl_hourly_raw)

akl_hourly <- akl_hourly_raw %>%
  mutate(date = make_date(year = year, month = month, day = mday))

akl_hourly <- akl_hourly  %>% 
  mutate(
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )

akl_hourly <- akl_hourly %>%
  mutate(
    hour = hour(datetime),
    month = month(month, label = TRUE),
    rainy = weather == "Precipitation"
  )

# Filter for hours between 8am and 10pm (inclusive)
akl_day <- akl_hourly %>% 
  filter(hour >= 8, hour <= 22)

# Summarise for each date if there is any rain
rainy_days <- akl_day %>% 
  group_by(month, date) %>%
  summarise(
    any_rain = any(rainy)
  )

# Summarise for each month, the number of days with rain
rainy_days %>% 
  summarise(
    days_rainy = sum(any_rain)
  )

