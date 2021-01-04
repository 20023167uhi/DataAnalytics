library(purrr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)

# #############################################################
# Part 1 import a list of weather dataframes
# #############################################################
# Changing working directory to where the data is.

# Note, this **will** have to be changed when run on a different computer.
my_data_dir <- "C:/data/"

setwd(my_data_dir)

# Reading only files that have a "*_raw.tsv" pattern and map them into a list
# of dataframes
weather_list <- map(list.files(pattern = "*_raw.tsv"), read_tsv)

# #############################################################
# Part 2 Use the data cleaning functions from Part 4/6 to clean the data
# #############################################################

# Copy of my function from part 6.
clean_data_local <- function(df){
  # Fill '---' with 'NA'
  df[df == "---"] <- "NA"
  # Substitute '*' with a 'blank'
  df[] <- lapply(df, gsub, pattern = '\\*', replacement = '')
  # Convert strings that hosted a '*' to numbers
  df[] <- sapply(df[], as.numeric)
  # Return cleaned df
  return (df)
}

# Mapping the list through the function of clensing.
weather_list <- map(weather_list, clean_data_local)

# #############################################################
# Part 3 producing plots into list
# #############################################################

making_a_date <- function(df) {
  # Just a function for creating a date column
  df$date <- ymd(str_c(df$yyyy, df$mm, "1", sep = "-"))
  return(df)
}

# First make a function that makes the weather plot and returns the plot data
making_plot_list <- function(df){
  
  # plot the data and store it to variable 'p'
  p <- ggplot(df, aes(x = date, y = `tmax (degC)`, colour = yyyy)) + 
    geom_line()
  # Return 'p'
  return(p)
}

# Make date column for plotting.
weather_list <- making_a_date(weather_list)

# Map the function into the weather list and save it to weather plots
weather_plots <- map(weather_list, making_plot_list)

# #############################################################
# Extension work
# #############################################################

# This is setting up/testing the code for making the params in the knitr  
library(tools)

# Commit the file list to a vector
(weather_files <- list.files(pattern = "*_raw.tsv"))

# Read in the files and make a station column to say what file the data
# is from, in a column named station
weather_df <- weather_files %>%
  set_names() %>%
  map_df(read_tsv, .id = "station")
  
# Remove the "_raw.tsv" component of the filename  
weather_df$station <- str_remove(weather_df$station, pattern = "_raw.tsv")

# Convert the column to title case for station name
weather_df$station <- toTitleCase(weather_df$station)

# clean the weather
clean_weather_df <- clean_data_local(weather_df)
# add back in the station names
clean_weather_df$station <- weather_df$station

# Split the dataframe into a list again based on the station column
weather_list2 <- split(clean_weather_df, f = clean_weather_df$station)

# Make a date column
weather_list2 <- map(weather_list2, making_a_date)

render_report <- function(df){
  # Move the working directory to my tutorials directory
  setwd("../Tutorials/Tutorial 8/")
  
  # create the station variable from the 'station' column
  station <- unique(df$station)[1]
  
  # Render the markdown report
  rmarkdown:: render(
    # Declare what the target file name is
    "Tutorial8.Rmd",
    # Set params variables
    params = list(
      station = station,
      data = df
    ),
    # Set the output filenames to be written.
    output_file = paste0("Report-", station, ".html")
  )
  # Move back to the data directory.
  setwd("../../data/")
}

# Maps the weather list to the report function to create individual reports
map(weather_list2, render_report)

