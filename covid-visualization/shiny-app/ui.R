#
# User-interface 

library(shinydashboard)


dashboardPage(
  # Heading
  dashboardHeader(
    title = "COVID-19"
    ),
  
  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem( "Datos acumulados",
                tabName = "cumData",
                icon = icon("chart-line"),
                selectInput("region_filter", label = "Elige una CA",
                            # TODO update to dynamic content
                            choices = list_ccaa, selected = "")
        )
      )
    ),
  
  # Main content
  dashboardBody(
      # Infobox with summary data
      fluidRow(
        
        # Dynamic infoBoxes
        infoBoxOutput("info.infected"),
        infoBoxOutput("info.recovered"),
        infoBoxOutput("info.dead")
      ),
      
      # Cumulative data content
      tabItem(tabName = "cumData",
              fluidRow(
                box(title = "Infectados",
                    highchartOutput("plot.infected", height = 250)),
                box(title = "Recuperados",
                    highchartOutput("plot.recovered", height = 250))
              ),
              fluidRow(
                tabBox(title = "Hospitalizados",
                       id = "tab.hospital",
                       tabPanel("Total", 
                                highchartOutput("plot.hospital", height = 250)),
                       tabPanel("UCI", 
                                highchartOutput("plot.uci", height = 250))),
                box(title = "Fallecidos",
                    highchartOutput("plot.dead", height = 250))
              )
    )
  )
)