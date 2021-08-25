library(shiny)

ui <- fluidPage(
  sliderInput(
    "obs",
    "Number of observations:",
    min = 0,
    max = 1000,
    value = 500
  ),
  plotOutput("distPlot")
)

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}
shinyApp(ui, server)
