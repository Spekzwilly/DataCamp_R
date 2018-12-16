library(gapminder)
library(dplyr)
library(ggplot2)

glimpse(gapminder)
head(gapminder)

gap2007 <- filter(gapminder, year == 2007)
head(gap2007)

gap2007 %>%
  group_by(continent) %>%
  summarise(mean(lifeExp), median(lifeExp))

ggplot(gap2007, aes(x = continent, y = lifeExp)) + 
  geom_boxplot()

## Calculate spread measures

# Compute groupwise measures of spread
gap2007 %>%
  group_by(continent) %>%
  summarize(sd(lifeExp),
            IQR(lifeExp),
            n())

# Generate overlaid density plots
gap2007 %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)


##Like mean and standard deviation, 
##median and IQR measure the central tendency and spread, 
##respectively, but are robust to outliers and non-normal data.

# Compute stats for lifeExp in Americas
gap2007 %>%
  filter(continent == "Americas") %>%
  summarize(mean(lifeExp),
            sd(lifeExp))

# Compute stats for population
gap2007 %>%
  summarize(median(pop),
            IQR(pop))

## Transformations
# Create density plot of old variable
gap2007 %>%
  ggplot(aes(x = pop)) +
  geom_density()

# Transform the skewed pop variable
gap2007 <- gap2007 %>%
  mutate(log_pop = log(pop))

# Create density plot of new variable
gap2007 %>%
  ggplot(aes(x = log_pop)) +
  geom_density()


## Identify outliers
# Filter for Asia, add column indicating outliers
gap_asia <- gap2007 %>%
  filter(continent == "Asia") %>%
  mutate(is_outlier = lifeExp < 50)

# Remove outliers, create box plot of lifeExp
gap_asia %>%
  filter(is_outlier == FALSE) %>%
  ggplot(aes(x = 1, y = lifeExp)) +
  geom_boxplot()