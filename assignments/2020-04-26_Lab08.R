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

crab <- read_csv("datasets/abd/chapter15/chap15q30FiddlerCrabFans.csv", col_types = cols(
  crabType = col_factor () ))

crab <- crab %>%
  slice(-85)

crab <- crab %>%
  mutate(crabType = fct_recode(crabType, intact = "intact male",
                               minorRemoved = "male minor removed",
                               majorRemoved = "male major removed"
))

head(crab)

summary(crab)

ggplot(crab, aes(x = crabType, y = bodyTemperature))+
  geom_boxplot() +
  theme_bw() +
  coord_flip()

ggplot(crab) +
  geom_histogram(aes(bodyTemperature), binwidth = 0.1)+
  facet_wrap(~crabType)

ggplot(crab)+
  geom_qq(aes(sample = bodyTemperature, color = crabType))

# histograms show skewed data, especially minorRemoved and intact. Boxplots show outliers in three groups. 
# QQ-plots not really straight lines. 

model01 <- lm(bodyTemperature~crabType, data = crab)

summ_bodyTemperature <- crab %>%
  group_by(crabType) %>% 
  summarise(mean_bodyTemperature = mean(bodyTemperature),
            sd_bodyTemperature = sd(bodyTemperature),
            n_bodyTemperature = n())

ratio <-(max(summ_bodyTemperature$sd_bodyTemperature))/(min(summ_bodyTemperature$sd_bodyTemperature))

autoplot(model01)

anova(model01)

summary(model01)

# Normality assumption not met so Kruskal-Wallis test will be used. 

kruskal.test(bodyTemperature ~ crabType, data = crab)

### There is a significance in mean heat gain among groups (chi-squared = 37.136; df = 3; p-value = 4.306e-08)
