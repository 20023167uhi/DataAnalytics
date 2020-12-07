library(tidyverse)

ggplot(diamonds, aes(x = carat, y = price)) + 
 geom_point()