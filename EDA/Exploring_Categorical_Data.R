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