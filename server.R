
function(input, output, session) {
        
        filteredData <- reactive({
                if (input$geo_filter == "All"){
                        df
                }else{
                        df <-  df[df$State == input$geo_filter, ]  
                }
                df
        })
        
        output$map <- renderLeaflet({
                leaflet() %>% addTiles() %>%
                        setView(lng = -93.85, lat = 37.45, zoom = 4)
        })
        
        output$hist_Centile <- renderPlot({
                df2 <- data.frame(filteredData()[,input$var_to_viz])
                p <- ggplot(df2, aes(x = df2[,1], fill = "red")) +
                        geom_density()+xlab("")+ylab("")+ theme(legend.position="none")
                p
        })
        
        
        output$dygraph <- renderDygraph({
                df3 <- df_20[,c('Year', input$Crime)] 
                values <- input$Crime
                graph_plot <- dygraph(df3, main = "20 Year Crime Rate") %>% 
                        dyAxis("y", label = "Crime Rate (Per 100,000)") %>%  
                        dyLegend(labelsSeparateLines = TRUE) %>%
                        dyAxis('x', label = 'Year') %>%
                        dyOptions(colors = brewer.pal(length(values), "Dark2")) %>% 
                        dyRangeSelector() %>%
                        dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))})
        
        output$table <- renderDataTable(select_df())

        output$scatterplot <- renderPairsD3({
                new_df <- df[df$State == input$pairs_state,]
                pairsD3(new_df[,3:10],leftmar = 100)
        })
        
         observe({
                 df <- df[, c(input$var_to_viz, "State","City","longitude","latitude")]
                 radius_p <- df[,1]
                 # larceny, propertycrime
                 if(input$var_to_viz%in%c("Larceny_theft","Property_crime")){
                         print("HOLA")
                         leafletProxy("map", data = filteredData()) %>%
                                 clearShapes() %>%
                                 addCircles(data = filteredData(), radius = ~radius_p*10, weight = 1, color = "red"
                                            , fillOpacity = 0.5
                                 )
                 }else{
                leafletProxy("map", data = filteredData()) %>%
                        clearShapes() %>%
                        addCircles(data = filteredData(), radius = ~radius_p*100, weight = 1, color = "red"
                                   , fillOpacity = 0.5
                        )
                 }
        })
         
         output$cityControls<- renderUI({
                 cities <- as.character(df_v[df_v$State == input$state, 2 ]) 
                 selectInput("city", "Select City", c('All', cities), selected = 'All')
         })
         
         select_df <- reactive({
                 if (input$state == 'All'){
                         df_v= df_v
                 }else{
                         if (input$city == 'All'){
                                 df_v = df_v[df_v$State == input$state, ]
                         }else{
                                 df_v = df_v[df_v$State == input$state & df_v$City == input$city, ]
                         }
                 }
         })
         
         
         output$summary <- renderPlot({
                 if (input$state != 'All' & input$city != 'All'){
                         df_4 <- df_v[df_v$State == input$state, c('Population', 'State', 'City', input$crime2)]
                         df_4 <- subset(df_4, select = -c(Population))
                         df_4 <- subset(df_4, select = c('City', 'State',input$crime2))
                         p <- tidyr::gather(df_4, Crime, Count, -State, -City)
                         plot1<-ggplot(p, aes(x=Crime, y=Count, color=Crime)) + geom_boxplot()
                         plot1 <- plot1 + scale_y_continuous(limits = c(0, 275))
                         plot1
                         
                 }else{
                         df_v <- select_df()
                         df_v <- subset(df_v, select = -c(Population))
                         df_v <- subset(df_v, select = c('City', 'State',input$crime2))
                         values <- input$crime2
                         if (input$state == 'All'){
                                 max2 <- max(df_v[c(input$crime2)])
                                 max2 <- as.integer(max2*.002)
                         }else{
                                 max2 <- 275
                         }
                         p <- tidyr::gather(df_v, Crime, Count, -State, -City)
                         plot1<-ggplot(p, aes(x=Crime, y=Count, color=Crime)) + geom_boxplot()
                         plot1 <- plot1 + scale_y_continuous(limits = c(0, max2))
                         plot1
                 }})
         
         output$table <- renderDataTable(select_df())
         
        
}

