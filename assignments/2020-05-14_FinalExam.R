# Clean up the working environment
rm(list = ls())
# Verify working directory, should be ~/Documents/Analyses/lastname_first
getwd()

library("ggfortify")
library("multcomp")
library("nlme")
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)
library(forcats)

leanness <- read_csv("datasets/demos/insulation.csv")

model02 <- lm(leanness ~ heat_loss, data = leanness)

autoplot(model02, smooth.colour = NA)

ggplot(data = leanness)+
  geom_point(aes(x = heat_loss, y = resid(model02)))

# the normal Q-Q plot looks good enough; the residuals seem to be normal.

summary(model02)

ggplot(data = leanness, aes(x = leanness, y = heat_loss)) +
  geom_point() +
  geom_smooth(method = "lm", level=0.95) +
  theme_bw()+
  labs( x = "leanness", y = "heat_loss")

# Boys with a higher index of body leanness had significantly higher rates of heat loss 
# (Linear Regression: leanness =  1.7424 + 46.0202(heat_loss); df = 1, 10, F = 68.73, p<0.0001), and index of body
# leanness explained more than 85% of the variability in heat loss (R2 = 0.873).


















