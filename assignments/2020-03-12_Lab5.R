### Lab 5. confidence intervals, t-tests and friends

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

### Question 1 ####

obliquity <- read_csv("datasets/demos/obliquity.csv")

y <- obliquity$Obliquity

sample_mean <-mean(y)
sample_sd <- sd(y)
sample_n <- as.numeric(length(y))
df <- sample_n -1

null_mean <- 0

t_sample <- (sample_mean - null_mean)/(sample_sd/sqrt(sample_n))

two_tailed <- 2*(1-pt(abs(t_sample), df))

#or

t.test(obliquity$Obliquity, 
       alternative = "two.sided", mu = 0, conf.level = 0.95)


#the angle of obliquity measured in 1738 was cholesterent from the angles measured in the past.
#the angle of obliquity measured in 1738 was the same as the angles measured in the past.

### Question 2####

heartattack <- read_csv("datasets/demos/HeartAttack_short.csv",col_types = cols(group = col_character()))

#the difference in the level of cholestrol between heart-attack patients and individuals who have not had a heart attack is different
#the difference in the level of cholestrol between heart-attack patients and individuals who have not had a heart attack is the same.
# df = (28+30)-2 = 56

ggplot(heartattack) +
  geom_histogram(aes(cholest), binwidth = 70)+
  facet_wrap(~group)

ggplot(heartattack) +
  geom_boxplot(aes(x = group, y = cholest))+
  stat_summary(aes(x = group, y = cholest), 
               fun.y=mean, 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3,
             )

ggplot(heartattack)+
  geom_qq(aes(sample = cholest, color = group))

# The plots show evidence that the assumption of normality has not been violated. The histograms show relatively
# symmetric distributions. The q-q plots 

summ_cholest <- heartattack %>%
  group_by(group) %>% 
  summarise(mean_cholest = mean(cholest),
            sd_cholest = sd(cholest),
            n_cholest = n(),
            var_cholest = var(cholest))  


ratio <-(max(summ_cholest$sd_cholest))/(min(summ_cholest$sd_cholest))
# ratio = 2.14 # 

# variances are not the same, so Welch's t-test will be used #

t.test(cholest ~ group, data = heartattack, alternative = "two.sided", conf.level = 0.95)
# The mean cholestrol levels in heart-attack patients two days post heart attack was significantly cholesterent than
# inidividuals who have not had a heart attack, (t = 6.1452, df = 37.675, p-value = 3.721e-07)

t.test(cholest ~ group, data = heartattack, var.equal = TRUE, alternative = "two.sided", conf.level = 0.95)

### Question 3 ####

fulmars <- read_csv("datasets/quinn/chpt3/furness.csv")

# If assumptions of normality are not met:
# 1. Try transforming the data to make it less skewed
# 2. You can ignore, IF it is a small departure and n1 + n2 is large. 
# 3. If you can't ignore or transform it, choose a cholesterent type of test, such as a non-parametric test.

# If non-normal distributuions are the same shape, then the median1 - median 1 = 0. However, if the distributions are
# not the same shape, then the null is that groups have the same distribution. In a standard two-sample test, the 
# null hypothesis is that μ1 - μ2 = 0. 

# For non-parametric tests such as the Mann-Whiteny U test, the assumptions are that:
# 1. Random sample of observations
# 2. If it is a two-sample design, there must be homogenous variance
# 3. If two sample design, observations must come from distributions with the same shape. 

#The Mann-Whiteny U test may not be the best for this particular dataset because the distributions aren't the same.

ggplot(fulmars) +
  geom_histogram(aes(METRATE), binwidth = 700)+
  facet_wrap(~SEX)

ggplot(fulmars) +
  geom_boxplot(aes(x = SEX, y = METRATE))+
  stat_summary(aes(x = SEX, y = METRATE), 
               fun="mean",
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3) 
              
ggplot(fulmars) +
  geom_qq(aes(sample = METRATE, color = SEX))

wilcox.test(METRATE ~ SEX, data = fulmars, alternative = "two.sided", conf.level = 0.95)
# We found that body mass of male fulmars was not significantly different than the body mass of femlae fulmars
# (W = 21; P = 0.7546)

### Question 4 ####

untidy_spiders <- read_csv("datasets/quinn/chpt3/elgar.csv")

# An appropriate test for testing a hypothesis about the difference in horizontal diameter of webs spun is the paired t-test
# because the same spider spun her web in a light and a dark frame.

# The null hypothesis is that the vertical diameter and horizontal diameter of the orb webs were the same in dim and light conditions.

# The treatments are randomly assigned to 17 different spiders. 
# The data do not meet the assumptions of a two sample standard t-test. The differences are not normally distributed,
# as shown in the histogram displaying the differences between the vertical diameter data.


untidy_spiders <- untidy_spiders %>%
  mutate(diff = HORIZLIG - HORIZDIM)

tidy_spiders <- untidy_spiders %>%
  gather(HORIZDIM, HORIZLIG, key="illumination", value = "dimensions")

summ_spiders <- tidy_spiders %>%
  group_by(illumination) %>% 
  summarise(mean_spiders = mean(dimensions),
            sd_spiders = sd(dimensions),
            n_spiders= n(),
            var_spiders = var(dimensions))  


ggplot(untidy_spiders) +
  geom_histogram(aes(diff), binwidth = 60)

ggplot(untidy_spiders) +
  geom_boxplot(aes(x = "", y = diff))+
  stat_summary(aes(x = "", y = diff), 
               fun="mean", 
               colour="blue", 
               fill = "blue",
               geom="point", 
               shape=21, 
               size=3)

ggplot(untidy_spiders)+
  geom_qq(aes(sample = diff))

#"In boxplot, the median is centered in the IQR box, there are no outliers, and mean and median are close.

ratio <-(max(summ_spiders$sd_spiders))/(min(summ_spiders$sd_spiders))

# ratio = 1.09

t.test(untidy_spiders$HORIZDIM, untidy_spiders$HORIZLIG, 
       alternative = "two.sided", paired = TRUE, conf.level = 0.95)

### 9/10 ####
# Breaks at line 20, obliquity.csv is not saved in the location specified, 
# Error: 'datasets/demos/obliquity.csv' does not exist in current working directory






