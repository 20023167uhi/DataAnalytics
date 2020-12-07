# Exercise 1
library(ggplot2)
library(dplyr)

# Exercise 2
ggplot(filter(storms, year==2015), aes(x=wind, y=pressure, colour=name))+
  geom_point(aes(size=wind, alpha=pressure))+
  geom_path()

#Exercise 3 + 4

library(dplyr)
library(nycflights13)
library(lubridate)

head(flights)
mutate(flights, dep_time_dt=make_datetime(year, month, day, hour, minute), before = dep_time)

ggplot(filter(flights, month==4 & carrier=="9E"), aes(x=sched_dep_time, y=dep_delay, colour=day)) + 
  geom_line() +
  facet_wrap(vars(day), scales = "free")
  