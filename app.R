library(tidyverse)
library(shiny)

download.file("https://github.com/skhan8/n-ssats/blob/master/nssatspuf_2017.RData?raw=true", destfile= "nssatspuf_2017.RData", mode = "wb")
load("nssatspuf_2017.RData")
#View(nssatspuf_2017) #13585 observations and 221 variables

# Saving data with dataset name "data"
data<- nssatspuf_2017 

# Subsetting the data to create a new dataset with required variables
data2<-select(data,STATE, B_PCT, A_PCT)
#View(data2)

# Removing missing values form the dataset

data3<- data2[(complete.cases(data2)),]

# Renaming "ZZ" as Other jurisdictions
data3$STATE[data3$STATE=="ZZ"]<- "Other jurisdictions"
# Sorting the dataset by STATE so that dropdown values appear alphabetically
data3<- arrange(data3,STATE)


server <- function(input, output) {
  
  output$plot_treatment<-renderPlot(
    
    ggplot(data=data3 %>% dplyr::filter(STATE==input$State_Name),
           aes(A_PCT, B_PCT)) + 
      geom_point(color='red')+labs(title="Treated for Alcohol and Drug Abuse vs. Treated for only Alcohol Abuse", x="Percent of clients treated for only alcohol abuse", y="Percent of clients treated for both alcohol and drug abuse")
    
      )
}

ui <- shinyUI(
  fluidPage(
    titlePanel("Substance Abuse Treatment Facilities"),
    fluidRow(
      selectInput("State_Name", "Select State", choices = unique(data3$STATE)),
      plotOutput("plot_treatment")
    )
  )
)

shinyApp(ui = ui, server = server)