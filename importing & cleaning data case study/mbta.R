library(readxl)
mbta <- read_excel("mbta.xlsx", skip = 1)

## mbta is pre-loaded

# View the structure of mbta
str(mbta)

# View the first 6 rows of mbta
head(mbta)

# View a summary of mbta
summary(mbta)

# Remove rows 1, 7, and 11 of mbta: mbta2
mbta2 <- mbta[c(-1, -7, -11),]

# Remove the first column of mbta2: mbta3
mbta3 <- mbta2[, -1]

head(mbta3)

## mbta3 is pre-loaded

# Load tidyr
library(tidyr)

# Gather columns of mbta3: mbta4
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)

mbta4$thou_riders <- as.numeric(mbta4$thou_riders)

## tidyr is pre-loaded

# Spread the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)

# Split month column into month and year: mbta6
mbta6 <- separate(mbta5, month, c("year", "month"), sep="-")

# View the head of mbta6
head(mbta6)

# View a summary of mbta6
summary(mbta6)

# Generate a histogram of Boat column
hist(mbta6$Boat)

## There are extreme valaue in the dataset.

library(ggplot2)
# Find the row number of the incorrect value: i
i <- which(mbta6$Boat == 40)

# Replace the incorrect value with 4
mbta6$Boat[i] <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)

