#### Lab 7: 1-way ANOVA #### 

# Clean up the working environment
rm(list = ls())
# Verify working directory, should be ~/Documents/Analyses/lastname_first
getwd()



library("ggfortify")
library("multcomp")
library("nlme")
library("tidyverse")

# Check for updates
tidyverse_update()

hcb <- read_csv("datasets/demos/Jaffe.csv", col_types = cols(
    Depth = col_factor() ))

tidy_hcb <- hcb %>%
  gather(Aldrin, HCB, key="treatment", value = "concentration")

head(hcb)
summary(hcb)

ggplot(tidy_hcb, aes(x = treatment, y = concentration))+
  geom_boxplot() +
  theme_bw() +
  coord_flip()

ggplot(tidy_hcb) +
  geom_histogram(aes(concentration), binwidth = 1.5)+
  facet_wrap(~treatment)

ggplot(tidy_hcb)+
  geom_qq(aes(sample = concentration, color = treatment))

summ_Aldrin <- hcb %>%
  group_by(Depth) %>% 
  summarise(mean_Aldrin = mean(Aldrin),
            sd_Aldrin = sd(Aldrin),
            n_Aldrin = n())

ratio <-(max(summ_Aldrin$sd_Aldrin))/(min(summ_Aldrin$sd_Aldrin))

summ_HCB <- hcb %>%
  group_by(Depth) %>% 
  summarise(mean_HCB = mean(HCB),
            sd_HCB = sd(HCB),
            n_HCB = n())

ratio <-(max(summ_HCB$sd_HCB))/(min(summ_HCB$sd_HCB))


### Aldrin ####

model1 <- lm(Aldrin~Depth, data = hcb)

autoplot(model1)

anova(model1)

summary(model1)

### log aldrin ####

log_aldrin1 <- mutate(hcb, log1aldrin = log10(Aldrin))

model2 <- lm(log1aldrin~Depth, data = log_aldrin1)

autoplot(model2)

anova(model2)

summary(model2)

### HCB ####

model3 <- lm(HCB~Depth, data = hcb)

autoplot(model3)

anova(model3)

summary(model3)

### Tukey ####

model01_b <- aov(Aldrin ~ Depth, hcb)

TukeyHSD(model01_b)

model01_c <- aov(HCB ~ Depth, hcb)

TukeyHSD(model01_c)

