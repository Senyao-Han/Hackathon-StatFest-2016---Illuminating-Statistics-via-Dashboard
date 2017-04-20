setwd("C:/Users/sh355/Desktop/shiny")
library(shiny)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("publisher", "Publisher:",
                  choices = list("Activision","Electronic Arts","Konami Digital Entertainment","Namco Bandai Games","Nintendo","Sega","Sony Computer Entertainment","Take-Two Interactive","THQ","Ubisoft"
                  )),
      hr(),
      helpText("Data Group by publisher.")
      ),
    sidebarPanel(
      selectInput("platform", "Platform:",
                  choices = list("PS2","X360",
                                 "PS3",
                                 "Wii",
                                 "DS",
                                 "PS",
                                 "GBA",
                                 "PSP",
                                 "PS4",
                                 "PC" )),
      hr(),
      helpText("Data Group by platform.")
    ),
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("PlatformPlot")),
      tabPanel("Plot", plotOutput("PlatformPlot2"))
    )
  )
)
)


server <- function(input, output) {
  output$PlatformPlot<- renderPlot({
    
    ggplot(data = platform_year[platform_year$Platform == input$checkGroup,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Platform, color=input$checkGroup),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Platform, color=input$checkGroup),na.rm = TRUE)})
  output$PlatformPlot2<- renderPlot({
    
    ggplot(data = publisher_year[publisher_year$Publisher == input$checkGroup2,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)})
}

shinyApp(ui = ui, server = server)