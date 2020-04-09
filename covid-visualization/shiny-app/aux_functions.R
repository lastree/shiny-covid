library(data.table)
library(highcharter)

get_data <- function(){
  ccaa <- read.csv("data/comunidades.csv", sep=";")
  data <- read.csv("https://covid19.isciii.es/resources/serie_historica_acumulados.csv")
  
  data <- merge(data, ccaa, all=T)
  data <- subset(data,select = -CCAA)
  
  data$FECHA <- as.Date(data$FECHA, format = "%d/%m/%Y")
  data <- data[order(data$FECHA, data$descripcion),]
  
  data <- data[is.na(data$FECHA) == FALSE, ]
  data[is.na(data)] <- 0
  
  names(data)[names(data)=="CASOS"] <- "Infectados"
  
  return(data)
}


get_summary <- function(data){
  # Keep data from the last day
  data <- data[data$FECHA == max(data$FECHA), ]
  # Sum columns
  data_summary <- colSums(data[, c("Infectados", "Hospitalizados", "UCI", "Fallecidos", "Recuperados")])
  
  return(data_summary)
  }


time_series_hc <- function(df, case){
  hc <- highchart() %>% 
          hc_xAxis(categories = df$FECHA) %>% 
          hc_add_series(name = case, data = df[, names(df)==case], type="line")
  return(hc)  
  }