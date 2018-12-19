library(openintro)
library(ggplot2)
library(dplyr)

data("bdims")
glimpse(bdims)

## make simple line regression plot
ggplot(bdims, aes(x = wgt, y = hgt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)