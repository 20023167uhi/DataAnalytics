# #########################################################
# Weather Storms App
# #########################################################
#
# This is an application to allow the user to check wind speed and pressure
# from recorded data of various storms from 2000 on wards.
#
# On running the application will select a random year and 3 random storms as 
# example data, and the user is free to select a year and a number of storms 
# from that year.
# 
# The user is free to view the data as a scatter with lines or as a bar-chart
# or view the raw data as a table.
#
# #########################################################

# load packages
library(shiny)
library(tidyverse)
library(plotly)
library(lubridate)

# Filter for dates of or after the year 2000
storms_2000 <- filter(storms, year >= 2000)

# Creating a date + time column because otherwise it just looks weird to have 
# 3 dots stacked on each other on the same day.
storms_2000$date <- ymd_hms(
    str_c(
      str_c(storms_2000$year, storms_2000$month, storms_2000$day, sep="-"), 
      str_c(storms_2000$hour, "00", "00", sep = ":"),
      sep = " "
    )
  )

# Creating a new column featuring the name of the storm and the year
storms_2000$name_year <- str_c(storms_2000$name, storms_2000$year, sep=" ")

# Creating a vector of unique labels from the new name_year column 
storm_name_year <- unique(storms_2000$name_year)

# Creating a vector of unique years from the year column
storm_years <- unique(storms_2000$year)

# Pull a random year and 3 random storms for initial plots
samp_year <- sample(storm_years, 1)
year_storms <- filter(storms_2000, year == samp_year)
samp_names <- unique(year_storms$name_year)
samp_name <- sample(samp_names, 3)

# Define what the user sees
ui <- fluidPage(
  
  titlePanel("Storms"),
  
  # Sidebar with input for user to control 
  sidebarLayout(
    sidebarPanel(
      # Selection for scatter or barplot
      selectInput(label = "Type of plot", inputId = "plot_type",  
                  choices = c("Scatterplot", "Barplot")), 
      
      # Storm name_year select
      selectInput(label = "Choose a Storm",
                  inputId = "storm_names",
                  choices = storm_name_year,
                  selected = samp_name,
                  multiple = TRUE),
      
      # Storm year select
      selectInput(label = "Choose a Year",
                  inputId = "years",
                  choices = storm_years,
                  selected = samp_year,
                  ),
      
      # Action button to update the plot
      actionButton(inputId = "go", label = "Plot Data")
    ),
    
    # Show the generated plot
    mainPanel(
      # Tabulate the panel
      tabsetPanel(
        # Tabs to be created: for Wind Speed, Pressure, and data as a Table
        tabPanel("Wind Speed", plotlyOutput("wind")),
        tabPanel("Pressure", plotlyOutput("pressure")),
        tabPanel("The Data", dataTableOutput("table"))
        
      )
    )
  )
)

# Define server logic required to sort data and draw plot
server <- function(input, output, session) {
  
  observe({
    # Update the 'name_year selectInput' to be dependent on the year.
    avail_storms <- filter(storms_2000, year == input$years)
    
    # Get a vector of unique name_year from what was filtered by the year 
    avail_storm_names <- unique(avail_storms$name_year)
    
    # Update the selector 
    updateSelectInput(session, "storm_names", 
                      label = "Choose a Storm",
                      choices = avail_storm_names,
                      selected = input$storm_names
                      )
  })
  
  sample_storms <- reactive({
    # gather info from user but only when asked
    input_storms <- isolate(input$storm_names)
    
    # listen to go button
    input$go
    
    # Filter the storms to pass onto the plotting part
    storms_to_plot <- filter(storms_2000, name_year %in% input_storms)
    
    return(storms_to_plot)
  })
  
  
  # Plotting using plotly
  output$wind <- renderPlotly({
    storms_to_plot <- sample_storms()
    if (input$plot_type == "Scatterplot"){
      plot_ly(
        data = storms_to_plot, 
        x = ~date, 
        y = ~wind, 
        color = ~name_year, 
        type = 'scatter', 
        mode = 'lines+markers'
      )
    } else if (input$plot_type == "Barplot"){
      plot_ly(
        data = storms_to_plot, 
        x = ~date, 
        y = ~wind, 
        color = ~name, 
        type = 'bar'
      )
    }
  })
  
  output$pressure <- renderPlotly({
    storms_to_plot <- sample_storms()
    if (input$plot_type == "Scatterplot"){
      plot_ly(
        data = storms_to_plot, 
        x = ~date, 
        y = ~pressure, 
        color = ~name_year, 
        type = 'scatter', 
        mode = 'lines+markers'
      )
    } else if (input$plot_type == "Barplot"){
      plot_ly(
        data = storms_to_plot, 
        x = ~date, 
        y = ~pressure, 
        color = ~name, 
        type = 'bar'
      )
    }
  })
  
  output$table <- renderDataTable({
    storms_to_plot <- sample_storms()
    # Dropping some values from the dataframe. Because of 'date', the other 
    # date columns are superfluous
    storms_to_plot <- select(
      storms_to_plot, 
      date, 
      name, 
      status, 
      wind, 
      pressure, 
      category, 
      lat, 
      long
    )
  })
  # what actually does the work behind the scenes
}

# Run the application 
shinyApp(ui = ui, server = server)

