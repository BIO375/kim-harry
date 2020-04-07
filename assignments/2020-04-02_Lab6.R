### Lab 6. 

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

### 13-20 ####

salmon <- read_csv("datasets/demos/salmon.csv")

summ_salmon <- salmon %>%
  group_by(salmon) %>% 
  summarise(mean_color = mean(color),
            sd_color = sd(color),
            n_color = n())

ratio <-(max(summ_salmon$sd_color))/(min(summ_salmon$sd_color))
# ratio = 4.30. Homoscedasticity not met since ratio > 3

salmon <- mutate(salmon, log1color = log(color +1))

ggplot(salmon) +
  geom_histogram(aes(log1color), binwidth = .1)+
  facet_wrap(~salmon)

ggplot(salmon) +
  geom_boxplot(aes(x = salmon, y = log1color))+
  stat_summary(aes(x = salmon, y = log1color), 
               fun.y=mean, 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3)

ggplot(salmon)+
  geom_qq(aes(sample = log1color, color = salmon))

# Transforming doesn't seem to change much, log data still shows skewed boxplot in Sockeye data. Since variance is not 
# homogenous, Welch's T-test will be used.#

t.test(color ~ salmon, data = salmon, alternative = "greater", conf.level = 0.95)

# We found that the red coloration in Kokanee was significanlty higher than the Sockeye
# in a low carotenoid environment (Welch's T-test:  t = 11.146, df = 20.289, p = 2.099e-10)

### 13-25 ####

clearcut <- read_csv("datasets/abd/chapter13/chap13q25Clearcuts.csv")

y<-clearcut$biomassChange

sample_mean <-mean(y)
sample_sd <- sd(y)
sample_n <- as.numeric(length(y))
df <- sample_n -1

null_mean <- 0

t_sample <- (sample_mean - null_mean)/(sample_sd/sqrt(sample_n))

two_tailed <- 2*(1-pt(abs(t_sample), df))

t.test(clearcut$biomassChange, 
       alternative = "two.sided", mu = 0, conf.level = 0.95)

# We found that there was not a significant difference in tree biomass of rain forest areas following clear-cutting
# (one-sample t-test: t = -0.85279, df = 35, p-value = 0.3996 )


### 13-26####

beaks <- read_csv("datasets/abd/chapter13/chap13q26ZebraFinchBeaks.csv")

y<-beaks$preference

sample_mean <-mean(y)
sample_sd <- sd(y)
sample_n <- as.numeric(length(y))
df <- sample_n -1

null_mean <- 0

t_sample <- (sample_mean - null_mean)/(sample_sd/sqrt(sample_n))

two_tailed <- 2*(1-pt(abs(t_sample), df))

t.test(beaks$preference, 
       alternative = "two.sided", mu = 0, conf.level = 0.95)

# We found that time spent near carotenoid-supplemented males was significantly higher compared to males that are on a low
# carotenoid diet. (one-sample t-test:  t = 5.6198, df = 9, p = .0003259)

### Review Problem 2-16####

aggression <- read_csv("datasets/abd/review2/rev2q16ZebrafishAggression.csv") 

summ_aggression <- aggression %>%
  group_by(genotype) %>% 
  summarise(mean_aggression = mean(timeInAggression),
            sd_aggression = sd(timeInAggression),
            n_aggression = n())

ratio <-(max(summ_aggression$sd_aggression))/(min(summ_aggression$sd_aggression))

ggplot(aggression) +
  geom_histogram(aes(timeInAggression), binwidth = 50)+
  facet_wrap(~genotype)

ggplot(aggression) +
  geom_boxplot(aes(x = genotype, y = timeInAggression))+
  stat_summary(aes(x = genotype, y = timeInAggression), 
               fun.y=mean, 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3)

# Ratio < 3, boxplot show median and mean close to each other. Continue with t-test #

ggplot(aggression)+
  geom_qq(aes(sample = timeInAggression, color = genotype))

t.test(timeInAggression ~ genotype, data = aggression, var.equal = TRUE, alternative = "two.sided", conf.level = 0.95)

# We found that the time spent in aggressive activity was significantly higher in spd mutant zebrafish compared to 
# wildtype zebrafish (t = 3.3802, df = 19, p-value = 0.003142).