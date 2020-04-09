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
    
    # Sidebar menu
    sidebarMenu(
      
      # Select for CCAA filter
      menuItem( "Datos acumulados",
                tabName = "cumData",
                icon = icon("chart-line"),
                selectInput("region_filter", 
                            label = "Elige una CA",
                            choices = list_ccaa, selected = "")
        )
      )
    ),
  
  
  # Main content - body
  dashboardBody(
    
      # Info boxes with summary data
      fluidRow(
        # Dynamic infoBoxes
        infoBoxOutput("info.infected"),
        infoBoxOutput("info.recovered"),
        infoBoxOutput("info.dead")
      ),
      
      
      # Plots with cumulative data
      
      tabItem(
        tabName = "cumData",
        
        # 2 rows: infected + recovered; hospital + dead  
        fluidRow(
          
          # Infected
          box(
            title = "Infectados",
            highchartOutput2("plot_infected", height = 250)
            ),
            
          # Recovered
          box(
            title = "Recuperados",
            highchartOutput("plot_recovered", height = 250)
            )
        ),
              
        
        fluidRow(
          
          # Hospital
          tabBox(
            title = "Hospitalizados",
            id = "tab.hospital",
            tabPanel(
              "Total", 
               highchartOutput("plot_hospital", height = 250)
            ),
            tabPanel(
              "UCI", 
              highchartOutput("plot_uci", height = 250)
            )
          ),
          
          # Dead
          box(
            title = "Fallecidos",
            highchartOutput("plot_dead", height = 250)
            )
          )
    
      )
  )
)