# Clean up the working environment
rm(list = ls())
# Verify working directory, should be ~/Documents/Analyses/lastname_first
getwd()

### Install and load packages ####
# The following commands will install these packages if they are not already installed, 
# and then load them!

if(!require(Rmisc)){install.packages("Rmisc")}
if(!require(DescTools)){install.packages("DescTools")}
if(!require(boot)){install.packages("boot")}
if(!require(rcompanion)){install.packages("rcompanion")}
if(!require(summarytools)){install.packages("summarytools")}
if(!require(tidyverse)){install.packages("tidyverse")}

# I give the general form below in comments.  A < > indicates you will type in
# your own value.  The main thing to watch for this command is the punctuation: ! ""

# if(!require(<package_name>)){install.packages("<package_name>")}

# Check for updates
tidyverse_update()

lovett <- read_csv("datasets/quinn/chpt2/lovett.csv")
lovett %>%
  descr()

summ_SO4 <- lovett %>%
  summarise(var_SO4 = var(SO4))

summ_SO4MOD <- lovett %>%
  summarise(var_SO4MOD = var(SO4MOD))

ggplot(lovett) +
  geom_histogram(aes(SO4),binwidth = 1)
  
ggplot(lovett) +
  geom_histogram(aes(SO4MOD),bindidth = 50)

ggplot(lovett) +
  geom_boxplot(aes(x = "", y = SO4), notch = TRUE, varwidth = TRUE)

ggplot(lovett) +
  geom_boxplot(aes(x = "", y = SO4MOD), notch = TRUE, varwidth = TRUE)


# Plot boxplots of SO4 and Modified SO4 using the code below.  
# You do not need to write any new code for this part!

# The code below modifies the dataset so it only contains SO4 and Modified SO4
# using select{dplyr}, and is oriented in long form using gather{tidyr}
lovett_tidy<-lovett %>%
  select(contains("SO4"))%>%
  gather(key = "type", value = "measurement", SO4, SO4MOD)

# The code below plots the two variables as boxplots, zooming in on the
# 40-75 range where most of the values are found (coord_cartesian).  The red 
# dots indicate the means (stat_summary).
ggplot(data = lovett_tidy) +
  geom_boxplot(aes(x = type, y = measurement))+
  coord_cartesian(ylim = c(40, 75))+
  stat_summary(aes(x = type, y = measurement), fun.y=mean, colour="darkred", geom="point", 
               shape=18, size=3)










# STANDARD ERROR ISN't FOR LOVETT! #
SE_S04 <- lovett %>%
  summarise(SE_SO4 = (sd(SO4)/sqrt(n())))

SE_S04MOD <- lovett %>%
  summarise(SE_SO4MOD = (sd(SO4MOD)/sqrt(n())))
                  