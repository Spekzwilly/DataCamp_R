library(readxl)
library(dplyr)
comics <- read.csv("comics.csv")

# Print the first rows of the data
head(comics)
glimpse(comics)


# Check levels of align
levels(comics$align)

# Check the levels of gender
levels(comics$gender)

# Create a 2-way contingency table
tab <- table(comics$align, comics$gender)


# Print tab
tab

# Remove align level
comics_filtered <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()

# See the result
comics_filtered


##Side-by-side barcharts
# Load ggplot2
library(ggplot2)

# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")

# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))


##Counts vs. proportions plot
# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") +
  ylab("proportion")

## Marginal barchart
comics$align <- factor(comics$align, levels = c("Bad", "Neutral", "Good")) %>%
  droplevels()

# Create the bar plot
ggplot(comics, aes(x = align)) +
  geom_bar()

## Conditional barchart
# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) + 
  geom_bar() +
  facet_wrap(~ gender)