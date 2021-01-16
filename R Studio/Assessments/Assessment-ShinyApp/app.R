# #########################################################
# Weather Station App
# #########################################################
#
# This is an application to allow the user to plot weather data 
# recorded from various stations between 1870 and 2020.
#
# On running the application will select the past 3 years, 3 random stations, 
# and a weather detail to feature as example data, and the user is free to 
# select dates, stations, and weather features to look at. 
# 
# The user is free to view the data as a scatter with lines or the raw data 
# as a table.
#
# #########################################################

# load packages
library(dplyr)
library(lubridate)
library(plotly)
library(shiny)
library(tidyverse)
library(tools)

# Copying functions from tutorial 6.
making_a_date <- function(df) {
  # Just a function for creating a date column
  a_date <- ymd(str_c(df$yyyy, df$mm, "1", sep = "-"))
  return(a_date)
}

clean_data_local <- function(df){
  # Fill '---' with 'NA'
  df[df == "---"] <- "NA"
  # Substitute '*' with a 'blank'
  df[] <- lapply(df, gsub, pattern = '\\*', replacement = '')
  # Source data also stated that Total Sunshine (hours) was appended with a '#'
  # when recorded with a Kipp and Zonen sensor.
  df[] <- lapply(df, gsub, pattern = '\\#', replacement = '')
  # Convert strings that hosted a '*' to numbers
  df[] <- sapply(df[], as.numeric)
  # Return cleaned df
  return (df)
}

# App is set to look at my data directory.
my_data_dir <- "C:/Users/t_kag/OneDrive/Desktop/UHI/Introduction to R and Data Visualization/Intro_to_R_Data_Vis/data"

setwd(my_data_dir)

# Commit the file list to a vector
(weather_files <- list.files(pattern = "*_raw.tsv"))

# Read in the files and make a station column to say what file the data
# is from, in a column named station
weather_df <- weather_files %>%
  set_names() %>%
  map_df(read_tsv, .id = "station") %>%
  select(-X8)

# Remove the "_raw.tsv" component of the filename  
stations <- str_remove(weather_df$station, pattern = "_raw.tsv")

# Create a column of stations to be joined later
stations <- toTitleCase(stations)

# Create a dates column to be joined later
the_dates <- making_a_date(weather_df)

# clean the weather
weather_df <- clean_data_local(weather_df)

# Get a list of station names
station_names <- unique(stations)

# Select only weather features by dropping station and date data
weather_df <- select(weather_df, -station, -yyyy, -mm)

# New column names which will also be the selection list for the input
features <- c("Mean-Max of Temperatures (Degrees C)",
              "Mean-Min of Temperatures (Degrees C)",
              "Days of Air Frost (Days)",
              "Total Rainfall (mm)",
              "Total Sunshine (Hours)"
              )

# Convert the column names to the new column names 
colnames(weather_df) <- features

# Rejoin the station and date data
weather_df$station <- stations
weather_df$Date <- the_dates

# Sample start date
samp_year <- ymd(
  paste(
    year(max(weather_df$Date))-3, 
    month(max(weather_df$Date)), 
    day(max(weather_df$Date)), 
    sep="-"
  )
)

# Select 3 stations to plot
samp_name <- sample(station_names, 3)

# Select a feature to plot
samp_feat <- sample(features, 1)

# Define what the user sees
ui <- fluidPage(
  titlePanel("Station Weather"),
    # Set top panel  to show plotting elements
    wellPanel(
      # # Selection for scatter or barplot
      # selectInput(label = "Type of plot", inputId = "plot_type",  
      #             choices = c("Scatterplot", "Barplot")), 
      
      # Station selector
      selectInput(label = "Stations",
                  inputId = "stations",
                  choices = station_names,
                  selected = samp_name,
                  multiple = TRUE),
      
      # Weather feature selector
      selectInput(label = "Features",
                  inputId = "features",
                  choices = features,
                  selected = samp_feat,
                  multiple = TRUE),
      
      # Date range selector
      dateRangeInput(label = "Select a date",
                     inputId = "inDateRange",
                     start = samp_year,
                     end = max(weather_df$Date),
                     min = min(weather_df$Date),
                     max = max(weather_df$Date),
                     format = "yyyy-mm-dd",
                     startview="year"
                     ),
      
      # Action button to update the plot
      actionButton(inputId = "go", label = "Plot Data")
    ),
  
    # Show the generated plot
      # Tabulate the panel
    tabsetPanel(
        # Tabs to be created: for Wind Speed, Pressure, and data as a Table
      tabPanel("Plots", plotlyOutput("plots")),
      tabPanel("The Data", dataTableOutput("table"))
  )
)

# Define server logic required to sort data and draw plot
server <- function(input, output, session) {
  
  observe({
    # Update the 'name_year selectInput' to be dependent on the year.
    avail_stations <- weather_df %>%
      filter(Date >= input$inDateRange[1] & Date <= input$inDateRange[2])

    # Get a vector of unique name_year from what was filtered by the year
    avail_station_names <- unique(avail_stations$station)
    input_stations <- input$stations

    # Update the selector
    updateSelectInput(session, "stations",
                      choices = avail_station_names,
                      selected = input_stations,
                      )
  })
  
  sample_stations <- reactive({
    # gather info from user but only when asked
    input_stations <- isolate(input$stations)
    # Selecting features to plot
    input_features <- isolate(input$features)
    
    # listen to go button
    input$go
    
    weather_df_fil <- weather_df %>%
      filter(Date >= input$inDateRange[1] & Date <= input$inDateRange[2])
    
    # Filter by station to pass onto the plotting part
    weather_df_fil <- filter(weather_df_fil, station %in% input_stations)
    
    # Pivoting longer the features to plot to prepare them for plotly
    stations_to_plot <- pivot_longer(
                          weather_df_fil, 
                          cols = input_features,
                          names_to = "weather", 
                          values_to = "weather_var"
                        )
    
    return(stations_to_plot)
  })
  
  # Plotting using plotly
  output$plots <- renderPlotly({
    stations_to_plot <- sample_stations()
    plot_ly(
      data = stations_to_plot, 
      # Plots with respect to x-axis
      x = ~Date, 
      # Plotting selected features converted to long format
      y = ~weather_var, 
      # Filtering station by colour
      color = ~station,
      # Filtering weather by linetype
      linetype = ~weather,
      type = 'scatter', 
      mode = 'lines+markers'
    ) %>%
    layout(
      yaxis = list(title = ""),
      legend = list(
        orientation = 'h',
        xanchor = "center",
        x = 0.5,
        y = -0.2
      )
             
    )
  })
  
  # Display dataframe
  output$table <- renderDataTable({
    stations_to_plot <- sample_stations()
    # Pivoting features previously long back to wide for table
    stations_to_plot <- pivot_wider(
                          stations_to_plot, 
                          names_from = weather, 
                          values_from = weather_var
                        )
    # Making sure Date and station appear in first 2 columns
    stations_to_plot <- select(
                          stations_to_plot, 
                          Date, 
                          station, 
                          colnames(
                            select(
                              stations_to_plot, 
                              -Date, 
                              -station
                            )
                          )
                        )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

