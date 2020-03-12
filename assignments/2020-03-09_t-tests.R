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

### Scenario 1 ####

birthrates <- read_csv("datasets/demos/birthrate.csv")

summary_Birth_1982 <- birthrates %>%
  summarise(mean_Birth_1982 = mean(Birth_1982),
            median_Birth_1982 = median(Birth_1982),
            IQR_Birth_1982 = IQR(Birth_1982),
            sd_Birth_1982 = sd(Birth_1982),
            var_Birth_1982 = var(Birth_1982))

summary_Birth_2000 <- birthrates %>%
  summarise(mean_Birth_2000 = mean(Birth_2000),
            median_Birth_2000 = median(Birth_2000),
            IQR_Birth_2000 = IQR(Birth_2000),
            sd_Birth_2000 = sd(Birth_2000),
            var_Birth_2000 = var(Birth_2000))

### Scenario 2 ####

data01 <- read_csv("datasets/abd/chapter12/chap12e3HornedLizards.csv")

data01 <- data01 %>% slice(-105)

summary_data01<- data01 %>%
  group_by(Survival) %>%
  summarise(n_squamosalHornLength= n(),
            mean_squamosalHornLength = mean(squamosalHornLength),
            median_squamosalHornLength = median(squamosalHornLength),
            sd_squamosalHornLength = sd(squamosalHornLength),
            IQR_squamosalHornLength = IQR(squamosalHornLength),
            var_squamosalHornLength = var(squamosalHornLength),
            se_squamosalHornLength = sd(squamosalHornLength)/sqrt(n()))

### Scenario 3 ####

# sample means (+/-) standard deviation: high CO2 = 1.53 (+/-) 0.42, normal CO2 = 1.66 (+/-) 0.47

### Scenario 4 ####

# mean weight of the Neuse crabs is 261 grams with a standard deviation of 8.39 grams
# mean weight of the Tar Pamlico crabs is 855 grams with a standard deviation of 30.6


