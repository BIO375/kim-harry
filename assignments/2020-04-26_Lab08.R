# Clean up the working environment
rm(list = ls())
# Verify working directory, should be ~/Documents/Analyses/lastname_first
getwd()

library("ggfortify")
library("multcomp")
library("nlme")
library("tidyverse")

tidyverse_update()

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

model01 <- lm(bodyTemperature~crabType, data = crab)

summ_bodyTemperature <- crab %>%
  group_by(crabType) %>% 
  summarise(mean_bodyTemperature = mean(bodyTemperature),
            sd_bodyTemperature = sd(bodyTemperature),
            n_bodyTemperature = n())

ratio <-(max(summ_bodyTemperature$sd_bodyTemperature))/(min(summ_bodyTemperature$sd_bodyTemperature))

autoplot(crab)


