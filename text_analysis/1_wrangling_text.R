# Load the tidyverse packages
library(tidyverse)

#read data
twitter_data = read_rds("twitter_data.rds")

# Print twitter_data
print(twitter_data)

# Print just the complaints in twitter_data
twitter_data %>% 
  filter(complaint_label == "Complaint")

##Grouped summaries

# Start with the data frame
twitter_data %>% 
  # Group the data by whether or not the tweet is a complaint
  group_by(complaint_label) %>% 
  # Compute the mean, min, and max follower counts
  summarize(
    avg_followers = mean(usr_followers_count),
    min_followers = min(usr_followers_count),
    max_followers = max(usr_followers_count)
  )

## Counting user types
twitter_data %>% 
  # Filter for just the complaints
  filter(complaint_label == "Complaint") %>% 
  # Count the number of verified and non-verified users
  count(usr_verified)

## Summarizing user types
twitter_data %>% 
  # Group by whether or not a user is verified
  group_by(usr_verified) %>% 
  summarize(
    # Compute the average number of followers
    avg_followers = mean(usr_followers_count),
    # Count the number of users in each category
    n = n()
  )

##Tokenizing and counting
# Load the tidyverse and tidytext packages
library(tidyverse)
library(tidytext)

tidy_twitter <- twitter_data %>% 
  # Tokenize the twitter data
  unnest_tokens(word, tweet_text) 

tidy_twitter %>% 
  # Compute word counts
  count(word) %>% 
  # Arrange the counts in descending order
  arrange(desc(n))


##Cleaning and counting
tidy_twitter <- twitter_data %>% 
  # Tokenize the twitter data
  unnest_tokens(word, tweet_text) %>% 
  # Remove stop words
  anti_join(stop_words)

tidy_twitter %>% 
  # Filter to keep complaints only
  filter(complaint_label == "Complaint") %>% 
  # Compute word counts and arrange in descending order
  count(word) %>% 
  arrange(desc(n))

