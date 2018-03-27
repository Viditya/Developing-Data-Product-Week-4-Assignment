#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(leaflet)
library(plotly)
library(plyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        
        # Leaflet map with all markers
       output$map <- renderLeaflet({
        
              dfX <-  subset(df, durationelec>=input$sliderElec[1] & durationelec<=input$sliderElec[2])
              dfY <-  subset(df, disbank>=input$sliderBank[1] & disbank<=input$sliderBank[2])
             dfZ <-  subset(df, distrans>=input$sliderPubTrans[1] & distrans<=input$sliderPubTrans[2])
              
                
             df<- join_all(list(dfX,dfY,dfZ), by='ID', type='inner')
             df <- df[,c("ID","lat","lng","popup","durationelec","disbank","distrans","population")]
             
             df %>%
              leaflet() %>%
                      #setView(lng=28.644800 , lat =77.216721, zoom=5) %>%
              addTiles (options = providerTileOptions(noWrap = TRUE)) %>%
              #               addRectangles(lat1 = 8.0666667, lng1 = 68.1166666,
                #                    lat2 = 37.1, lng2 = 97.4166666) %>%
                      addMarkers(clusterOptions = markerClusterOptions(),popup=df$popup)
               })

        # Make a barplot or scatterplot depending of the selected point
        output$plot=renderPlotly({
        
                dfA <-  subset(df, durationelec>=input$sliderElec[1] & durationelec<=input$sliderElec[2])
                dfB <-  subset(df, disbank>=input$sliderBank[1] & disbank<=input$sliderBank[2])
                dfC <-  subset(df, distrans>=input$sliderPubTrans[1] & distrans<=input$sliderPubTrans[2])
                
                dfplot<- join_all(list(dfA,dfB,dfC), by='ID', type='inner')
                dfplot <<- dfplot[,c("ID","lat","lng","popup","durationelec","disbank","distrans","population","state")]
                
                
                dfplotelec <- ddply(dfplot,~state,summarise,mean= mean(durationelec),count=length(durationelec))
               
                plot_ly(data= dfplotelec, x = ~state, y = ~count, type = 'bar', xaxis="State", yaxis="Average hours of electricity by states") 
                       # layout(title = 'Average electricity in states by States',
                        #       yaxis = 'States',
                         #      xaxis = 'Average hours of electricity',margin=m)
               
        })
      #  output$plotB=renderPlotly({
       #         dfplotbank <- ddply(dfplot,~state,summarise,mean=mean(disbank))
        #        plot_ly(data= dfplotbank,x = ~state, y = ~mean,type="bar") %>%
         #               layout(margin=m)
        #})
        #output$plotC=renderPlotly({
         #       dfplottrans <- ddply(dfplot,~state,summarise,mean=mean(distrans))
          #      plot_ly(data= dfplottrans,x = ~state, y = ~mean,type="bar") %>%
           #     layout(margin=m)
        #})
        
        output$slider_var <- reactive({"Use the above sliders to change the three parameters, namely duration of electricity in 
                village, distance of bank from village and distance of nearest place where public transport is available."})
                
        output$map_var <- reactive({"The Main panel plots the location coordinates of the villages that lie under the specific criteria."})
                
        output$plot_var <- reactive({"The plot below gives the average hours of electricity in villages that lie under the specific criteria by States."})       

})
