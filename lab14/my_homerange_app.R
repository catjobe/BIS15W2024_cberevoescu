#NOT R Markdown, this is raw R script

library(tidyverse)
library(shiny) #need to include the required packages and libraries because this app is standalone

homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv") #need to include the data

ui <- fluidPage(titlePanel("Homerange Locomotion"),
                radioButtons("x", "Select Fill Variable", choices=c("trophic.guild", "thermoregulation"), selected="trophic.guild"),
                plotOutput("plot", width="600px", height="500px")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(homerange, aes_string(x="locomotion", fill=input$x)) +
      geom_bar(position="dodge", alpha=0.8, color="black") +
      theme_light(base_size=18) +
      labs(x=NULL, y=NULL, fill="Fill Variable")
  })
  
}

shinyApp(ui, server)