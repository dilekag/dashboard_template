#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(shinydashboard)
library(readxl)

#Any data files that are in the folder titled "template" can be read here: for example: 
covid_rates <- read_excel("covid_rates.xlsx")
soci_data <- read_excel("soci_data.xlsx")


# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "red", #Customize dashboard color here
                    dashboardHeader(title = "TITLE"), #Customize dashboard title here
                    # Sidebar Content
                    dashboardSidebar(
                        sidebarMenu(
                            tags$img(src = "ut_logo.png", width = "100%"),
                            tags$br(),
                            menuItem(" About", tabName = "intro", icon = icon("info-circle", lib = "font-awesome")),
                            menuItem(" Social Determinants of Health", tabName ="covar", icon = icon("user-friends", lib = "font-awesome")),
                            menuItem(" COVID-19 TITLE", tabName ="covid", icon = icon("viruses", lib = "font-awesome"))
                        )
                    ),
                    # Main Body
                    dashboardBody(
                        tabItems(
                            tabItem(tabName = "intro",
                                    tags$h2("Welcome"),
                                    # in order to put an image in, use the following format: 
                                    fluidRow(tags$img(height = 2, width = 1500, src = 'black_line.png')),
                                    # in the folder called "www", there should be an image saved called 'black_line.png'. 
                                    # Any images desired to be included in the dashboard should be in this folder. 
                                    tags$h4("heading"),
                                    tags$h5("text text text", tags$strong("bold text"), tags$i("italicized text"), "etc.")
                            ),
                            tabItem(tabName = "covar",
                                    tags$h2("Social Determinants of Health"),
                                    fluidRow(tags$img(height = 2, width = 1500, src = 'black_line.png')),
                                    tags$h4("heading"),
                                    tags$h5("description"),
                                    box(width = 12, status = "danger",
                                        selectInput("sociVar", "Please select the desired social characteristic to be analyzed:", 
                                                c("Percent of Population with a Disability"= "Pct_disability",
                                                  "Percent of Population with Less than a High School Education" = "Pct_less_hs",
                                                  "Percent of Population with Limited English" = "Pct_limit_English",
                                                  "Percent of Population with No Insurance" = "Pct_no_ins",
                                                  "UNSURE" = "Per_capital_inc",
                                                  "UNSURE" = "Mean_time_work_min",
                                                  "Percent of Population Below Poverty Line" = "Pct_bl_poverty",
                                                  "UNSURE" = "Pct_crowd_hs",
                                                  "UNSURE" = "Pct_renters",
                                                  "Percent of Population without a Vehicle" = "Pct_no_vehicle",
                                                  "UNSURE" = "Pct_rent_burden",
                                                  "Percent of Population Under 18 Years of Age" = "Pct_under_18",
                                                  "Percent of Population Over 65 Years of Age" = "Pct_over_65",
                                                  "Percent of Population that is a Racial Minority" = "Pct_racial_minority",
                                                  "UNSURE" = "Pct_single_parent"
                                                  ))), #Structure: Website Dropdown Name = Internal Name (for server) 
                                    box(width = 12,
                                        plotOutput("sociResults")
                                    )
                                    
                                
                            ),
                            tabItem(tabName = "covid",
                                    tags$h2("COVID TITLE"),
                                    fluidRow(tags$img(height = 2, width = 1500, src = 'black_line.png'))
                                
                            )
                        )
                    )
    
)

# This is where all the R occurs - should put code for leaflet plots here
server <- function(input, output) {
    output$sociResults <- renderPlot({
        # Create a data frame where first column is the census tract number and second column is the variable the user selects
        socialData <- data.frame(soci_data[,c("tract", input$sociVar)])
        # This updates itself whenever the user selects a different variable 
        
        #I just plotted it as an example, but renderLeaflet can be used to create  leaflet plots
        plot(socialData[,1],socialData[,2], xlab = "Census Tract", ylab = "")
    })


}

# Run the application 
shinyApp(ui = ui, server = server)
