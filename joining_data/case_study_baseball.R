library(Lahman)
library(dplyr)
library(tibble)
/*
LahmanData
as.tibble(Salaries)

str(LahmanData)
*/
  
players <- Master %>%
  distinct(playerID, nameFirst, nameLast)

# Find all the players that do not appear in Salaries and then count them.
players %>%
  anti_join(Salaries, by = "playerID") %>%
  count()

# Find all the players that do not appear in Salaries yet do play at least one game.
players %>%
  anti_join(Salaries, by = "playerID") %>%
  semi_join(Appearances, by = "playerID") %>%
  count()

# Determine how many games each of these unsalaried players played
players %>%
  anti_join(Salaries, by = "playerID") %>%
  left_join(Appearances, by = "playerID") %>%
  group_by(playerID) %>%
  summarise(total_games = sum(G_all, na.rm = TRUE)) %>%
  arrange(desc(total_games))

# Do they even play in the games that they appeared in?
players %>%
  # Find unsalaried players
  anti_join(Salaries, by = "playerID") %>% 
  # Join Batting to the unsalaried players
  left_join(Batting, by = "playerID") %>% 
  # Group by player
  group_by(playerID) %>% 
  # Sum at-bats for each player
  summarise(total_at_bat = sum(AB, na.rm=TRUE)) %>% 
  # Arrange in descending order
  arrange(desc(total_at_bat))

# Let's see how many players have been nominated to the HoF
# Find the distinct players that appear in HallOfFame
nominated <- HallOfFame %>% 
  distinct(playerID)

nominated %>% 
  # Count the number of players in nominated
  count()

nominated_full <- nominated %>% 
  # Join to Master
  left_join(Master, by = "playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)

# Let's see how many players were admitted to the hall of fame

inducted <- HallOfFame %>%
  filter(inducted == "Y") %>%
  distinct(playerID)

inducted %>%
  count()

inducted_full <- inducted %>%
  left_join(Master, by = "playerID") %>%
  select(playerID, nameFirst, nameLast)

#Did nominees who were 
#inducted earn more awards than nominees who were not inducted?

nAwards <- AwardsPlayers %>%
  group_by(playerID) %>%
  tally()

# Filter nAwards to include the players in inducted 
#and calculate the mean number of awards per player
nAwards %>%
  semi_join(inducted, by = "playerID") %>%
  summarise(avg_n = mean(n))

# Filter nAwards to include the players in nominated 
# who are not present in inducted 
# and calculate the mean number of awards per player

nAwards %>%
  semi_join(nominated, by = "playerID") %>%
  anti_join(inducted, by = "playerID") %>%
  summarise(avg_n = mean(n))


# Does the maximum salary earned by inductees 
# tend to be greater than the maximum salary earned 
# by nominees who were not inducted?

# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% 
  setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>% 
  # Calculate the max salary by player
  group_by(playerID) %>%
  summarise(max_salary = max(salary, na.rm = TRUE)) %>%
  
  # Calculate the average of the max salaries
  summarise(avg_salary = mean(max_salary, na.rm = TRUE))

# Repeat for players who were inducted
Salaries %>% 
  semi_join(inducted, by = "playerID") %>% 
  group_by(playerID) %>%
  summarise(max_salary = max(salary, na.rm = TRUE)) %>%
  summarise(avg_salary = mean(max_salary, na.rm = TRUE))
