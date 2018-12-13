library(dplyr)
library(miceadds)
library(ggplot2)
load.Rdata("evals.RData", "evals")
glimpse(evals)

# Remove non-factor variables from the vector below
cat_vars <- c("rank", "ethnicity", "gender", "language",
              "cls_level", "cls_profs", "cls_credits",
              "pic_outfit", "pic_color")

# Recode cls_students as cls_type
evals_fortified <- evals %>%
  mutate(
    cls_type = case_when(
      cls_students <= 18 ~ "small",
      cls_students >= 19 & cls_students <= 59 ~ "midsize",
      cls_students >= 60 ~ "large"
    )
  )


# Scatterplot of score vs. bty_avg
ggplot(evals_fortified, aes(x = bty_avg, score)) +
  geom_point()

# Scatterplot of score vs. bty_avg colored by cls_type
ggplot(evals_fortified, aes(x = bty_avg, y = score, color = cls_type)) +
  geom_point()