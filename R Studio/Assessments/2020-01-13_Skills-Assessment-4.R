# ####################################################################
# Assignment 4 - Reading, writing, and arithmetic of fuel price lists
# ####################################################################
# This is a script to randomly generate diesel and petrol fuel prices similar 
# to assignment 2. In this assignment the data is written to csv files and read
# back into list data. 
# 
# The list data is then summarized using a map function and then plotted
# specifically for a year. 
# ####################################################################

# load package
library(ggplot2)
library(lubridate)
library(patchwork)
library(stringr)
library(tidyverse)

# set seed and sample size
set.seed(32523) # change this
sample_size <- 500 # for the purposes of skills test 4 don't change this.

# Number of fuel datasets to be created
num_results <- 3

# Pick a year from 2010 to 2020
set_year <- 2010

# create randomised tibble/data frame
setup_fuel <- function(){
  # Set in function because called more than once 
  fuel_data <- tibble(
    year = sample(c(2010:2020), min(500, sample_size), replace = TRUE),
    month = sample(c(1:12), min(500, sample_size), replace = TRUE),
    day = sample(c(1:31), min(500, sample_size), replace = TRUE),
    petrol_price = round(rnorm(min(500, sample_size), 110, 1)/100, 2),
    diesel_price = round(rnorm(min(500, sample_size), 120, 1)/100, 2)
  )
  return(fuel_data)
}

# write fuel_data to file
for (ind in c(1:num_results)){
  # generate some fuel data
  fuel_tmp_dat <- setup_fuel()
  # Write it to the data/ file in the current working directory.
  write.csv(fuel_tmp_dat, str_c("data/fuel_set_", ind, ".csv"), row.names=FALSE) 
}

# read file in 
# Get list of filenames that correspond to the pattern the files were written
(file_list <- list.files(path="data/", pattern = "fuel_set_[0-9]{1,}.csv"))

# Read the file data into a list of dataframes
read_fuel_dat <- "data/" %>%
  str_c(file_list) %>%
  map(read_csv)

# summarise data in at least one way 
map(read_fuel_dat, summary)

# plot the data in at least one way
list_plots <- map(read_fuel_dat, function(df){
  # Filter for 2015, both geoms work from same date generated on x-axis
  ggplot(filter(df, year==set_year), aes(x=ymd(str_c(year,month, day, sep="-")))) + 
    # One geom is set to plot y-axis using petrol prices
    geom_line(aes(y=petrol_price, colour="Petrol")) +
    # The other geom is set to plot y-axis using diesel prices
    geom_line(aes(y=diesel_price, colour="Diesel")) +
    # Tidy title, axis, and legend labels 
    ggtitle(str_c("Price of Fuel of the year ", set_year)) +
    labs(x = "Date", y = "Price", colour = "Fuel")
})

# Patchwork stacking plots on top of each other
list_plots[[1]] / list_plots[[2]] / list_plots[[3]]

