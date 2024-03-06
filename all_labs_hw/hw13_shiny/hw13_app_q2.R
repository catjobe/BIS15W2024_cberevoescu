library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- read_csv("data/UC_admit.csv")

ui <- dashboardPage(
        dashboardHeader(title = "Admissions by Ethnicity"),
        dashboardSidebar(disable = T), 
        dashboardBody(
                
                fluidRow(box(title = "Variables", width = 3, #controlling box width
                             selectInput("x", "Select Variable", choices = c("Academic_Yr", "Campus", "Category"), selected = "Academic_Yr"),
                             radioButtons("y", "Select Category", choices = c("Admits", "Applicants", "Enrollees"), selected = "Admits")
                ), #closing the first box
                box(width = 8,
                    plotOutput("plot")
                ) #closes the second box
                ) #closes the row
        ) #closes the dashboard bod
) #close the ui

server <- function(input, output, session) {
        
        session$onSessionEnded(stopApp)
        
        output$plot <- renderPlot ({
                
                UC_admit %>% 
                        filter(Category == input$y) %>% 
                        ggplot(aes_string(x = "Ethnicity", y = "FilteredCountFR", fill = input$x)) +
                        geom_col() +
                        labs(title = "Admissions by Ethnicity",
                             x = "Ethnicity",
                             y = "Number of Admits") +
                        theme(plot.title = element_text(size = rel(1.3), hjust = 0.5), axis.text.x = element_text(angle = 60, hjust = 1))
                
        })
        
}

shinyApp(ui, server)