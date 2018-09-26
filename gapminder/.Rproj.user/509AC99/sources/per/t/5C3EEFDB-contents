# Import packages
library(gapminder)
library(dplyr)
library(ggplot2)

# Variable assignment
gapminder_2007 <- gapminder %>%
  filter(year == 2007)

# Visualizing with ggplot2
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Log scale
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10()


# Additional Aesthetics
# The color aesthetics
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point() + scale_x_log10()

# The size aesthetics
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color=continent, size=pop)) +
  geom_point() + scale_x_log10()


# Faceting
# Just like making subplots in Python
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color=continent, size=pop)) +
  geom_point() + scale_x_log10() + facet_wrap(~ continent)

# Wrap up
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) + geom_point() + scale_x_log10() +facet_wrap(~ year)
