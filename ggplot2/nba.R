library(ballr)
season18 <- NBAPerGameAdvStatistics(season = 2018)
head(season18)
str(season18)

kyrie_irving18 <- season18[which(season18$player == "Kyrie Irving"),] 
bos18 <- seaon18[which(season18$tm == "BOS"),]
library(ggplot2)


