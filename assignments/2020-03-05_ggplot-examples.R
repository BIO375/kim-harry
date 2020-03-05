x### Lab 4. Data manipulation and graphing

# Clean up the working environment
rm(list = ls())

### Install and load packages ####

if(!require(Rmisc)){install.packages("Rmisc")}
if(!require(DescTools)){install.packages("DescTools")}
if(!require(boot)){install.packages("boot")}
if(!require(rcompanion)){install.packages("rcompanion")}
if(!require(summarytools)){install.packages("summarytools")}
if(!require(tidyverse)){install.packages("tidyverse")}

# Check for updates
tidyverse_update()

mpg


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
### place response and explanatory variable you want to look at in x = "" and y = "", respectively. The shape functiion graphs each "type" as a different shape####

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, stroke = cyl), shape = 21)
### Stroke is the thickness of the line outlining a shape. The shape function will change the data points from just a dot to a unique shape.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
### nrow and ncol define how many rows of plots and columns of plots will be shown.###

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

### You can use geom_line for a jagged line like a time series, geom_abline
#     for a straight line specified by slope and intercept, geom_path to trace follow from timepoint 1 to 
#     timepoint 2, to 3 etc.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = drv), size = 5)+
  geom_smooth(mapping = aes(group = drv, linetype = drv), se = FALSE, size = 2)
### geom_smooth utlizes lines to see trends within the data. This is helpful because it can be hard to see patterns from just points alone. 

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
### the coord_flip() reverses the axes. 

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill = cut))+
  coord_flip()
### bar graph that has flipped axes. The "fill" function colors the bars in. 

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill = cut))+
  coord_polar()
###Polar coordinates reveal an interesting connection between a bar chart and a Coxcomb chart.

