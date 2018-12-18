library(openintro)
library(dplyr)
library(ggplot2)
data(ncbirths)
glimpse(ncbirths)


##Boxplots as discretized/conditioned scatterplots
## Using cut() function to discretize the data.
ggplot(ncbirths, aes(x = cut(weeks, breaks = 5), y = weight)) +
  geom_boxplot()


## Transformations
## The relationship between two variables may not be linear. 
## In these cases we can sometimes see strange and even inscrutable patterns in a scatterplot of the data.

data("mammals")

## use coord_trans() function to transfer the data
ggplot(mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")

## use scale_x_log10() & scale_y_log10() to transfer the data.
ggplot(mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() + scale_y_log10()


data("mlbBat10")
## Identifying outliers

# Scatterplot of SLG vs. OBP
mlbBat10 %>%
  filter(AB >= 200) %>%
  ggplot(aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
mlbBat10 %>%
  filter(AB >= 200, OBP < 0.2)
