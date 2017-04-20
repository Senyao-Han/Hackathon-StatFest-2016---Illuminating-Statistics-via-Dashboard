library(shiny)
ui <- fluidPage(
  titlePanel("Revenue by publisher"),
  sidebarLayout(
    sidebarPanel(
      selectInput("publisher", "Publisher:",
                  choices = colnames(df)),
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    mainPanel(
      plotOutput("publisherPlot")
    )
  )
)

server <- function(input, output) {
  output$publisherPlot<-renderPlot({
    barplot(df[,input$publisher]*1000, 
            main=input$publisher,
            ylab="Revenue of Publishers",
            xlab="Year")
  })
}

shinyApp(ui = ui, server = server)