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

caffeine <- read_csv("datasets/demos/caffeine.csv", col_types = cols(
  group = col_factor () ))

### Step 1 ####
ggplot(caffeine) +
  geom_histogram(aes(half_life), binwidth = 3)+
  facet_wrap(~group)

ggplot(caffeine)+
  geom_qq(aes(sample = half_life, color = group))

ggplot(caffeine) +
  geom_boxplot(aes(x = group, y = half_life))

### Step 2 ####

model05 <- lm(half_life~group, data = caffeine)

### Step 3 ####

summ_caffeine <- caffeine %>%
  group_by(group) %>% 
  summarise(mean_half_life = mean(half_life),
            sd_half_life = sd(half_life),
            n_half_life = n())

ratio_caffeine <-(max(summ_caffeine$sd_half_life))/(min(summ_caffeine$sd_half_life))

autoplot(model05)

#step 4

anova(model05)

#Tukey

tukey <- glht(model05, linfct = mcp(group = "Tukey"))

summary(tukey)


### Answers to Question ####

# the null hypotheses is that the mean caffeine metabolism rate is the same between 
# men and women without elevated progesterone and that the mean caffeine metabolism rate is 
# the same between women without elevated progesterone and women with elevated progesterone

# The predictor variable is the treatment group and the response variable is the mean caffeine metabolism rate. The treatment group is a categorical variable, 
# and the half_life is a continuous variable.

# Use a Tukey HSD to test which groups stand apart from the others. 

# The assumptions seem to be met. Random samples and independence depend on experimental design phase, not really 
# changeable after data collection. The assumption of equal variance among groups is met, as Smax/Smin < 3.
# Normality seems to be met by looking at the plots. The QQ plot shows lines that are not great, but not horrible enough
# to rely on Kruskal-Wallis. Boxplots show two outliers, but residual plots reinforce that it isn't too bad. 
# Residuals vs Fitted show no particular pattern. 

# There is not a significant difference between mean caffeine metabolism rate of males and women without eleveted progesterone (Tukey HSD: t = .649, P = .7941)

# There is a signficant difference between mean caffeine metabolism rate of women without eleveted progesterone and women with 
# eleveted progesterone levels. (Tukey HSD: t = 4.034, P = .00113)