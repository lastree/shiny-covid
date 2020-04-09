#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

source("aux_functions.R")

data <- get_data()
last_date <- max(data$FECHA)
list_ccaa <- levels(factor(data$descripcion))


cum_summary <- get_summary(data)

shinyServer(function(input, output) {
   
  # Data filter based on input
  new_data <- reactive({
    data[data$descripcion == input$region_filter, ]
  })
  
  # Data filter based on input
  cum_summary <- reactive({
    get_summary(new_data())
  })
  
  # Info boxes
  output$info.infected <- renderInfoBox({
     infoBox(
        "INFECTADOS",
        cum_summary()["Infectados"],
        icon = icon("credit-card")
     )
    })
  
  output$info.recovered <- renderInfoBox({
    infoBox(
      "RECUPERADOS",
      cum_summary()["Recuperados"],
      icon = icon("credit-card")
    )
  })
  
  output$info.dead <- renderInfoBox({
    infoBox(
      "FALLECIDOS",
      cum_summary()["Fallecidos"],
      icon = icon("credit-card")
    )
  })
  
  output$plot_infected <- renderHighchart2({
   time_series_hc(new_data(), "Infectados")
      })
  
  output$plot_recovered <- renderHighchart({
    time_series_hc(new_data(), "Recuperados")  
  })

  output$plot_hospital <- renderHighchart({
    time_series_hc(new_data(), "Hospitalizados")  
  })

  output$plot_uci <- renderHighchart({
    time_series_hc(new_data(), "UCI")  
  })
  
    
  output$plot_dead <- renderHighchart({
    time_series_hc(new_data(), "Fallecidos")  
  })
  
})