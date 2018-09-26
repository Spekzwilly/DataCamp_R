"""
Grouping & Summarizing

"""

# The summarize verb
gapminder %>%
  summarize(meanLifeExp = mean(lifeExp))

# Summarizing one year
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# The group_by verb
gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# Summarizing by continent and year
gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(as.numeric(pop)))

# Plot the change in medianGdpPercap in each continent over time
library(ggplot2)
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) + geom_point() + expand_limits(y = 0)


# Making line plot 
# Simply change geom_point() to geom_line()
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) + geom_line() + expand_limits(y = 0)

# Making bar plot
# simply change geom_point() to geom_col()
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) + geom_col()

# Making histogram
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x = pop)) + geom_histogram()

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x = pop)) + geom_histogram() + scale_x_log10()


# Making box plots
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) + geom_boxplot() + scale_y_log10()
