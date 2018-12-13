library(dplyr)
library(miceadds)
load.Rdata("us_regions.RData", "us_regions")
str(us_regions)

states_srs <- us_regions %>%
  sample_n(8)

states_srs %>%
  count(region)


states_stratified_sampling <- us_regions %>%
  group_by(region) %>%
  sample_n(2)

states_stratified_sampling %>%
  count(region)