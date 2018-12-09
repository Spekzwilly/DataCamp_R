votes <- readRDS("votes.rds")
head(votes)

library(dplyr)
library(countrycode)

votes_processed <- votes %>%
  filter(vote <= 3) %>%
  mutate(year = session + 1945, country = countrycode(ccode, "cown", "country.name"))

# Calculate the total votes and percentage of "Yes" votes.
votes_processed %>%
  summarize(total = n(), percent_yes = mean(vote == 1))

# Calculate total and percent_yes "year to year".
votes_processed %>%
  group_by(year) %>%
  summarize(total = n(), percent_yes = mean(vote == 1))

# Summarizing by country
by_country <- votes_processed %>%
  group_by(country) %>%
  summarize(total = n(), percent_yes = mean(vote == 1))
head(by_country)

# Sorting by percentage of "yes" votes
# Sort in ascending order of percent_yes
by_country %>%
  arrange(percent_yes)

# Now sort in descending order
by_country %>%
  arrange(desc(percent_yes))


# Filter out countries with fewer than 100 votes
by_country %>%
  filter(total >= 100) %>%
  arrange(percent_yes) 
