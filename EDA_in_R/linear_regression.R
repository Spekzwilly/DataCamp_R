votes <- readRDS("votes.rds")
head(votes)

library(dplyr)
library(countrycode)

votes_processed <- votes %>%
  filter(vote <= 3) %>%
  mutate(year = session + 1945, country = countrycode(ccode, "cown", "country.name"))

## Linear regression on the United States
by_year_country <- votes_processed %>%
  group_by(year, country) %>%
  summarize(total = n(), percent_yes = mean(vote == 1))

US_by_year <- by_year_country %>%
  filter(country == "United States")
# Print US_by_year
US_by_year

# Perform a linear regression of percent_yes by year: US_fit
US_fit <- lm(percent_yes ~ year, US_by_year)

# Perform summary() on the US_fit object
summary(US_fit)


## Tidying a linear regression model
library(broom)
tidy(US_fit)

## Combining models for multiple countries
# Linear regression of percent_yes by year for US
US_by_year <- by_year_country %>%
  filter(country == "United States")
US_fit <- lm(percent_yes ~ year, US_by_year)

# Fit model for the United Kingdom
UK_by_year <- by_year_country %>%
  filter(country == "United Kingdom")
UK_fit <- lm(percent_yes ~ year, UK_by_year)

# Create US_tidied and UK_tidied
US_tidied <- tidy(US_fit)
UK_tidied <- tidy(UK_fit)

# Combine the two tidied models
library(dplyr)
bind_rows(US_tidied, UK_tidied)


# Nesting a data frame
# Load the tidyr package
library(tidyr)
# Nest all columns besides country
nested <- by_year_country %>%
  nest(-country)

# Select tibble from the nest data
nested$data[[1]]

## Performing linear regression on each nested dataset
# Load tidyr and purrr
library(tidyr)
library(purrr)

# Perform a linear regression on each item in the data column
by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .)))

# Load the broom package
library(broom)

# Add another mutate that applies tidy() to each model
by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .))) %>%
  mutate(tidied = map(model, tidy))

# Add one more step that unnests the tidied column
country_coefficients <- by_year_country %>%
  nest(-country) %>%
  mutate(model = map(data, ~ lm(percent_yes ~ year, data = .)),
         tidied = map(model, tidy)) %>%
  unnest(tidied)

# Print the resulting country_coefficients variable
country_coefficients
