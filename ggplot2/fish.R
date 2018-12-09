str(fish.species)

library(tidyr)
fish.tidy <- gather(fish.species, Species, Capture, -Year)
head(fish.tidy)

library(ggplot2)
ggplot(fish.tidy, aes(x = Year, y = Capture, col = Species)) +
  geom_line()