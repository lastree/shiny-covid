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
   
  # Info boxes
  output$info.infected <- renderInfoBox({
     infoBox(
        "INFECTADOS",
        cum_summary["Infectados"],
        icon = icon("credit-card")
     )
    })
  
  output$info.recovered <- renderInfoBox({
    infoBox(
      "RECUPERADOS",
      cum_summary["Recuperados"],
      icon = icon("credit-card")
    )
  })
  
  output$info.dead <- renderInfoBox({
    infoBox(
      "FALLECIDOS",
      cum_summary["Fallecidos"],
      icon = icon("credit-card")
    )
  })
  
  output$plot.infected <- renderHighchart({
    highchart() %>% 
      hc_xAxis(categories = data$FECHA) %>% 
      hc_add_series(name = "Infectados", data = data$Infectados)
      })
  
  output$plot.recovered <- renderHighchart({
    time_series_hc(data, "Recuperados")  
  })
  #TODO update this
  output$plot.hospital <- renderHighchart({
    time_series_hc(data, "Hospitalizados")  
  })
  
  output$plot.dead <- renderHighchart({
    time_series_hc(data, "Fallecidos")  
  })
  
})