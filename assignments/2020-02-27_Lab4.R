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

library("tidyverse")
library("nycflights13")
library("gapminder")
library("Lahman")


mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# ggplot template
# ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

### 3.2.4 Exercises ####

ggplot(data=mpg)

# 1. The code makes a plot that completely empty. 
# 2. There are 234 rows and 11 columns
# 3. drv categorizes cars into  front-wheel drive, rear wheel drive, or 4-wheel drive. 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
# This plot isn't very useful because both the x and y are categotical values#

### ####

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

### 3.3.1 Exercises ####
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# 2. The reason why the points aren't blue is because the "blue" is part of aes. To fix this, we place parantheses around only the x and y variables.#
# 3. Categorical variables include the model, trans, drv, fl, and class. Continous variables include the displ, year, cyl, cty, and hwy.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = displ, color = "display", size = displ))
# 4. If you map the same variable to multiple aesthetics, R still produces a plot, but the information is repeated.
# 5. Stroke seemse to affect how thick each points are on the plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ< 5))
# 6. displ < 5 makes it so that values less than five are "True", while values above are "False".

### ####

#ggplot(data = mpg) #
# + geom_point(mapping = aes(x = displ, y = hwy))#

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)


### 3.5.1 Exercies ####

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(~ cty)
# 1. The continous variable will turn into a categorical variable

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cty)) +
  facet_grid(drv ~ cyl)

# 2. The empty plots means that there are no obervations of the combinations

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) 
# 3. "(drv ~ .)" places the values of drv on the y-axis. "(. ~ cyl)" will place the values of cyl on the x-axis.
 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = fl))

# 4. Using facet makes it easier to seperate each category and allows for better understanding of each individual category. However, since the plots are seperate, it may be difficult to compare the differences between plots. One advantage that of the color aesthetic is that you can compare points on one single plot, making comparisons easier. However, the more categories and points you have on a single plot, the more difficult it will be to interpret, so facet will probably be more useful.

# 5. nrow displays the number of rows in the data set. ncol displays the number of columns. facet_grid does not require nrow or ncol because it looks at all of the combinations of the variables within the data.

# 6. You have more space to work with when the variable is faceted on the y-axis. 

### ####

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy))
  

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

### 3.6.1 Exercises ####

# 1. geom_line(), geom_boxplot(), geom_histogram(), geom_area()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
geom_point() + 
  geom_smooth(se = FALSE) 

# 2. The code will be a scatterplot with the lines representing drv. The x-axis will be displ and y-axis will be hwy. Each drv category will be colored. Lines will go through drv categories.
# 3. show.legend = FALSE will remove the legend from the plot.
# 4. The se function adds the standard error to the lines


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy)) 

#5. The two does not look different because the ggplot will provide the information needed to geom_point and geom_smooth in the first graph.

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(group = drv), se = FALSE) +
  geom_point()

ggplot(data = mpg, aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))

### ####
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
  
### 3.7.1 Exercises ####

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary"
  )

# 1. the default geom is geom_pointrange() for stat_summary(). 
# 2. geom_col() uses stat_identity, while geom__bar() uses stat_count(). 
# 3. Many of the pairs have the same names.
# 4. stat_smooth() calculates the predicated value, lower and upper part of confidence interval, and the standard error

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..)) 

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# 5. When 'group = 1' is missing, all the bars have the same height. 

### ####

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

### 3.8.1 Exercises ####

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() 

# 1. The plots are stacked on top of each other; the plot doesn't show the where concentrations of observations are to occur.You could improve by using "jitter"

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")

# 2. geom_jitter() looks at width and height to control the amount of jittering.
# 3. geom_jitter() adds a small amount of random variation to the location of each point.geom_count() counts the number of observations at each location, then maps the count. geom_count() does not add random variation to the points.
# 4. The default for geom_boxplot() is "dodge2". 

ggplot(data = mpg, aes(x = drv, y = cty, colour = class)) +
  geom_boxplot()

### ####
  
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
    geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
    geom_boxplot() +
    coord_flip()

install.packages("maps")

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

### 3.9.1 Exercises ####
# 1.
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_polar()

# 2. labs() modifies axis, legend, and plot labels
# 3. coord_map projects a portion of the earth, which is approximately spherical, onto a flat 2D plane. coord_quickmap is a quick approximation that works best for smaller areas closer to the equator.
# 4. the plot tells us that cars  have higher mpg on the highway compared to in cities. forces a specified ratio between the physical representation of data units on the axes. The ratio represents the number of units on the y-axis equivalent to one unit on the x-axis. geom_abline() adds reference lines to a plot
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed() 

