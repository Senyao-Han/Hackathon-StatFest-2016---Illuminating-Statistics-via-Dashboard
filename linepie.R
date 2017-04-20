setwd("C:/Users/sh355/Desktop/shiny")
library(shiny)
ui <- fluidPage(
  fluidRow(
    splitLayout(cellWidths = c("33%", "33%","33%"),
                checkboxGroupInput("checkGroup", label = h3("Platform vs Revenue"), 
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
                                   selected = "PC" ),
                radioButtons("checkGroup2", label = h3("Publisher vs Revenue"), 
                                   choices = list("Activision","Electronic Arts","Konami Digital Entertainment","Namco Bandai Games","Nintendo","Sega","Sony Computer Entertainment","Take-Two Interactive","THQ","Ubisoft"
                                   ), 
                                   selected = "Activision"),
                radioButtons("checkGroup3", label = h3("Piechart of Platform"), 
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
                     selected = "PC"))),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot1",
        fluidRow(
          splitLayout(cellWidths = c("50%", "50%"), plotOutput("PlatformPlot"), plotOutput("PublisherPlot"))
        )
      ),
     tabPanel("Plot2", plotOutput("PieChart")) 
    )
            
  )
)


server <- function(input, output) {
  output$PlatformPlot<- renderPlot({
    ``
    ggplot(data = platform_year[platform_year$Platform == input$checkGroup,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Platform, color=Platform),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Platform, color=Platform),na.rm = TRUE)})
  output$PublisherPlot<- renderPlot({
    
    ggplot(data = publisher_year[publisher_year$Publisher == input$checkGroup2,]) +
      geom_point(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)+
      geom_line(mapping = aes(x=Year, y=Revenue, group = Publisher, color=input$checkGroup2),na.rm = TRUE)})
  
  output$PieChart<-renderPlot({
    bp<-ggplot(data=subset(publisher_platform3, Platform==input$checkGroup3), mapping=aes(x="", y=Revenue,fill=Publisher))+geom_bar(width=1, stat = "identity")
    bp+coord_polar("y", start=0)
  })
}

shinyApp(ui = ui, server = server)