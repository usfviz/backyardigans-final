require(leaflet)
library(dygraphs)

navbarPage("Crime Explorer", id="nav",
           tabPanel("Interactive map",
                    div(class="outer",
                        
                        tags$head(
                                # Include our custom CSS
                                includeCSS("styles.css"),
                                includeScript("gomap.js")
                        ),
                    leafletOutput("map", width = "100%", height = "100%"),
                    
                    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                              draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                              width = 330, height = "auto",

                              h2("Details"),
                              tags$h4("All data is shown as crime per capita"),
                              selectInput("var_to_viz", "Type of Crime", colnames(df)[4:14], selected = "Population"),
                              
                              selectInput("geo_filter", "State", c(levels(df$State),"All"), selected = "All"),
                              hr(),
                              print("Distribution of Crime (per capita) Across Cities in Selected Geography"),
                              plotOutput("hist_Centile", height = 250)
                              )
                    )
           ),
           tabPanel("Data explorer",
                    fluidRow(column(3, selectInput('state', 'State', states))),
                    fluidRow(plotOutput('summary')),
                    hr(),
                    fluidRow(column(3, uiOutput('cityControls'))),
                    fluidRow(dataTableOutput('table'))),

           tabPanel("Numeric Relationships",
                    tags$h4("Scatter plots are in absolute terms"),
                    selectInput("pairs_state", "State", c(levels(df$State))),
                    pairsD3Output("scatterplot",
                                  width="100%",height="800px")),
           tabPanel("Historical Data", 
                    fluidRow(selectInput("Crime", 
                                         label = "Select Crimes",
                                         choices = list("Violent Crime" = "Violent_crime", "Murder-Manslaughter" = "Murder_manslaughter", "Rape" = "Rape", "Robbery"="Robbery", "Aggravated Assault"="Aggravated_assault", "Property Crime" = "Property_crime", "Burglary" = "Burglary", "Larceny Theft" = "Larceny_theft", "Motor Vehicle Theft" = "Motor_vehicle_theft"),
                                         selected = "Violent_crime")),
                    dygraphOutput("dygraph")) #changed
           
)
           
