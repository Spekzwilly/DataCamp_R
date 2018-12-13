library(readxl)
cars <- read.csv("cars.csv")

library(ggplot2)
str(cars)

ggplot(cars, aes(x = city_mpg)) +
  geom_histogram() +
  facet_wrap(~ suv)

## Boxplots and density plots
common_cyl <- filter(cars, ncyl %in% c(4, 6, 8))

ggplot(common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) + 
  geom_boxplot()

ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) + 
  geom_density(alpha = 0.3)

## Marginal and conditional histograms
# Create hist of horsepwr
cars %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram() +
  ggtitle("Horse Power")

# Create hist of horsepwr for affordable cars
cars %>% 
  filter(msrp < 25000) %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Horse Power for Affordable Cars")

## Plot selection
# Create plot of city_mpg
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()

# Create plot of width
cars %>% 
  ggplot(aes(x = width)) +
  geom_density()

# 'Cause the city_mpg has more outlier data. It's better to use boxplot for city_mpg.

## Visualization in higher dimensions
## 3 variable plot
# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv) +
  ggtitle("HWY_MPG")
# Across both SUVs and non-SUVs, mileage tends to 
# decrease as the number of cylinders increases.