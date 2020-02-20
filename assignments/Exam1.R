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


polyploid <- read_csv("datasets/demos/polyploid.csv")

polyploid_summary <- polyploid %>%
  group_by(ploidy) %>%
  summarise(n_length = n(),
            mean_length = mean(length),
            median_length = median(length),
            sd_length = sd(length),
            IQR_length = IQR(length),
            var_length = var(length),
            se_length = sd(length)/sqrt(n()))

ggplot(data = polyploid)+
  geom_boxplot(aes(x = ploidy, y = length), notch = FALSE)+
  stat_summary(aes(x = ploidy, y = length), 
               fun.y=mean, 
               colour="darkred", 
               geom="point", 
               shape=18, 
               size=3)

lizards <- read_csv("datasets/abd/chapter12/chap12e3HornedLizards.csv")

lizards <- lizards %>% slice (-105)

# Extra Credit 

cricket <- read_csv('datasets/abd/chapter13/chap13e5SagebrushCrickets.csv')

ggplot(cricket) +
  geom_histogram(aes(timeToMating), binwidth = 15)+
  facet_wrap(~feedingStatus)

cricket <- cricket %>%
  mutate(log1cricket = log(timeToMating + 1))

ggplot(cricket) +
  geom_histogram(aes(log1cricket), binwidth = .5)+
  facet_wrap(~feedingStatus)

