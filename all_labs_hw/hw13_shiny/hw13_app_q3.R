library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- read_csv("data/UC_admit.csv")

ui <- dashboardPage(
        dashboardHeader(title = "Enrollment by Year"),
        dashboardSidebar(disable = T), 
        dashboardBody(
                
                fluidRow(box(title = "Variables", width = 3, #controlling box width
                             
                             selectInput("x", "Select Variable", choices = c("Academic_Yr", "Campus", "Category"), selected = "Academic_Yr"),
                             
                             selectInput("y", "Select Campus", choices = unique(UC_admit$Campus), hr()),
                             
                             radioButtons("z", "Select Category", choices = c("Enrollees", "Admits", "Applicants"), 
                                          selected = "Enrollees")
                             
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
                        mutate(Academic_Yr = as.factor(Academic_Yr)) %>% 
                        filter(Campus == input$y) %>% 
                        filter(Category == input$z) %>% 
                        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x)) +
                        geom_col() +
                        labs(title = "Enrollment by Year",
                             x = "Year",
                             y = "Enrollment Number") +
                        theme(plot.title = element_text(size = rel(1.3), hjust = 0.5), axis.text.x = element_text(angle = 60, hjust = 1))
                
        })
        
}

shinyApp(ui, server)