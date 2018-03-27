#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

library(leaflet)
library(plotly)

shinyUI(fluidPage(
        titlePanel("Villages under Antyodatya Mission"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderElec", "Pick Minimum and Maximum Values of score on hours of available electricity",
                                    min(df$durationelec), max(df$durationelec), value = c(1, 2), step = 1),
                        sliderInput("sliderBank", "Pick Minimum and Maximum Values of score on distance of bank",
                                    min(df$disbank), max(df$disbank), value = c(0, 1), step = 1),
                        sliderInput("sliderPubTrans", "Pick Minimum and Maximum Values of score on distance of public transport",
                                    min(df$distrans), max(df$distrans),value = c(0, 1), step = 1),

                        textOutput("slider_var"),br(),
                        textOutput("map_var"),br(),
                        textOutput("plot_var")
                ),
                mainPanel(
        leafletOutput("map", height="500px"),
        h4(" Map of villages under Antyodatya Mission as per the selected criteria"),
        plotlyOutput("plot"),
        h4("Plot of villages under Antyodatya Mission as per the selected criteria")

)
)
))
