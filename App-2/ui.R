library(shiny)
shinyUI(fluidPage(
  titlePanel("PlayStation"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("select", label = ("Platform"), 
                  choices = list("PS", "PS2",
                                 "PS3", "PS4","PSP"), selected = "PS"),
      
      checkboxGroupInput("checkGroup", label = h3("Platform vs Revenue"), 
                         choices = list("PS","PS2",
                                        "PS3",
                                        "PS4",
                                        "PSP",
                                        "GB",
                                        "GBA"
                         ), 
                         selected = "PS")),
      
    mainPanel(
      tabsetPanel(
        tabPanel("Video Game vs Revenue", 
                 plotOutput("Total")),
        tabPanel("bar plot", plotOutput("PlatformPlot")),
        tabPanel("multiline plot",
                 fluidRow(
                   splitLayout(cellWidths = c("50%", "50%"), plotOutput("PlatformPlot2"), plotOutput("PlatformPlot3"))
                 )
      ),
      tabPanel("Video vs playstation",
               fluidRow(
                 splitLayout(cellWidths = c("50%", "50%"), plotOutput("Total2"), plotOutput("PlatformPlot4"))
               )
      ),
      tabPanel("ratio plot", img(src="ratio.jpg"))
      
    )
  )
)
)
)