setwd("C:/Users/sh355/Desktop/shiny")
library(shiny)
ui <- fluidPage(
  fluidRow(
    splitLayout(cellWidths = c("50%", "50%"),
  checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                     choices = list("PS2","X360",
                                    "PS3",
                                    "Wii",
                                    "DS",
                                    "PS",
                                    "GBA",
                                    "PSP",
                                    "PS4",
                                    "PC"
                     ), 
                     selected = "PC"),
  checkboxGroupInput("checkGroup2", label = h3("Checkbox group2"), 
                     choices = list("Activision","Electronic Arts","Konami Digital Entertainment","Namco Bandai Games","Nintendo","Sega","Sony Computer Entertainment","Take-Two Interactive","THQ","Ubisoft"
                     ), 
                     selected = "Activision"))),
  
  mainPanel("main panel",
            fluidRow(
              splitLayout(cellWidths = c("50%", "50%"), plotOutput("PlatformPlot"), plotOutput("PublisherPlot"))
    )
  )
)


server <- function(input, output) {
  output$PlatformPlot<- renderPlot({
    
    ggplot(data = platform_year[platform_year$Platform == input$checkGroup,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Platform, color=input$checkGroup),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Platform, color=input$checkGroup),na.rm = TRUE)})
  output$PublisherPlot<- renderPlot({
    
    ggplot(data = publisher_year[publisher_year$Publisher == input$checkGroup2,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)})
}

shinyApp(ui = ui, server = server)