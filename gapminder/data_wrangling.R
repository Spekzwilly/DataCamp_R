library(gapminder)
library(dplyr)

gapminder

# The filter verb
# Filter the gapminder dataset for the year 1957
gapminder %>%
  filter(year == 1957)

# Filter for China in 2002
gapminder %>%
  filter(country == 'China' & year == 2002)
         

# The arrange verb
# Sorting with arrange
gapminder %>%
  arrange(gdpPercap)

# Soring in descending order
gapminder %>%
  arrange(desc(gdpPercap))

# Filter then arrange
gapminder %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

# The mutate verb
# Using mutate to change a variable

gapminder %>%
  mutate(pop = pop/10000)

# Using mutate to add a new variable

gapminder %>%
  mutate(GDP = gdpPercap * pop)

# Combining verbs

gapminder %>%
  mutate(GDP = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(GDP))
