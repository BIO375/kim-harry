# Clean up the working environment
rm(list = ls())
# Verify working directory, should be ~/Documents/Analyses/lastname_first
getwd()

if(!require(Rmisc)){install.packages("Rmisc")}
if(!require(DescTools)){install.packages("DescTools")}
if(!require(boot)){install.packages("boot")}
if(!require(rcompanion)){install.packages("rcompanion")}
if(!require(summarytools)){install.packages("summarytools")}
if(!require(tidyverse)){install.packages("tidyverse")}

# Check for updates
tidyverse_update()



### Question 17 ####

infection <- read_csv("datasets/demos/baker.csv")

infection <- infection %>%
  mutate(diff = After - Before)

ggplot(infection) +
  geom_histogram(aes(diff), binwidth = 1)

ggplot(infection) +
  geom_boxplot(aes(x = "", y = diff))+
  stat_summary(aes(x = "", y = diff), 
               fun.y=mean, 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3)

ggplot(infection)+
  geom_qq(aes(sample = diff))


SignTest(infection$diff, alternative = "greater", mu = 0, conf.level = 0.95)

### Question 18 ####

install.packages("abd", repos="http://R-Forge.R-project.org")
library("abd")

algae <- AlgaeCO2

summ_algae <- algae %>%
  group_by(treatment) %>% 
  summarise(mean_growthrate = mean(growthrate),
            sd_growthrate = sd(growthrate),
            n_growthrate = n())

ratio <-(max(summ_algae$sd_growthrate))/(min(summ_algae$sd_growthrate))

ggplot(algae) +
  geom_histogram(aes(growthrate), binwidth = .)+
  facet_wrap(~treatment)

ggplot(algae) +
  geom_boxplot(aes(x = treatment, y = growthrate))+
  stat_summary(aes(x = treatment, y = growthrate), 
               fun.y=mean, 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3)

ggplot(algae)+
  geom_qq(aes(sample = growthrate, color = treatment))

t.test(growthrate ~ treatment, data = algae, var.equal = TRUE, alternative = "two.sided", conf.level = 0.95)


### Code broke line 60, missing a number for binwidth 9/10 ####