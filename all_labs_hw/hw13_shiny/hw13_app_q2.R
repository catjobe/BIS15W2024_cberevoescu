library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- read_csv("data/UC_admit.csv")

ui <- dashboardPage(
        dashboardHeader(title = "Admissions by Ethnicity"),
        dashboardSidebar(disable=T),
        dashboardBody(
                
                fluidRow(
                        box(title = "Plot Options", width = 3,
                            radioButtons("x", "Select Year", choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019"), selected = "2010"),
                            selectInput("y", "Select Campus", choices = c("Davis", "Irvine", "Berkeley", "Irvine", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"), selected = "Davis"),
                            selectInput("z", "Select Category", choices = c("Applicants", "Admits", "Enrollees"), selected = "Applicants")
                        ), #closes the first box
                        box(title = "UC Admissions", width = 8,
                            plotOutput("plot", width = "500px", height = "400px")
                            
                        ) #closes the second box
                ) #closes the row
        ) #closes the dashboard body
) #closes the ui

server <- function(input, output, session) {
        
        session$onSessionEnded(stopApp)
        
        output$plot <- renderPlot ({
                
                UC_admit %>% 
                        group_by(Ethnicity) %>% 
                        filter(Academic_Yr == input$x) %>% 
                        filter(Campus == input$y) %>% 
                        filter(Category == input$z) %>% 
                        ggplot(aes(x = Ethnicity, y = FilteredCountFR, fill = Ethnicity)) +
                        geom_col(na.rm = T) +
                        labs(title = "Admissions by Ethnicity",
                             x = "Ethnicity",
                             y = "Number") +
                        theme(plot.title = element_text(size = rel(1.3), hjust = 0.5), axis.text.x = element_text(angle = 60, hjust = 1))
                
        })
        
}

shinyApp(ui, server)