# import needed library
library(openintro)
library(broom)
library(ggplot2)

data(bdims)
head(bdims)

mod <- lm(wgt ~ hgt, data = bdims)

# View summary of model
summary(mod)

# Compute the mean of the residuals
mean(residuals(mod))

# Compute RMSE
sqrt(sum(residuals(mod)^2) / (df.residual(mod)))


bdims_tidy <- augment(mod)

# View model summary
summary(mod)

# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(wgt), var_e = var(.resid)) %>%
  mutate(R_squared = 1 - var_e / var_y)


mlb_mod <- lm(SLG ~ OBP, data = mlbBat10)
mlb_mod %>%
  augment() %>%
  arrange(desc(.hat)) %>%
  head(6)

mlb_mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head(6)


## Removing outliers
nontrivial_players <- filter(mlbBat10, AB >= 10 & OBP < 0.500)
# Fit model to new data
mod_cleaner <- lm(SLG ~ OBP, data = nontrivial_players)

# View model summary
summary(mod_cleaner)

# Visualize new model
ggplot(nontrivial_players, aes(x = OBP, y = SLG)) +
  geom_point() +
  geom_smooth(method = 'lm')

# Rank high leverage points
mlb_mod %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head(6)