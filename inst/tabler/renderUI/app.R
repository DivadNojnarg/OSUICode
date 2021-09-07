library(shiny)

ui <- fluidPage(
  actionButton("go", "Go!", class = "btn-success"),
  uiOutput("slider"),
  plotOutput("distPlot")
)

# Server logic
server <- function(input, output) {

  output$slider <- renderUI({
    req(input$go > 0)
    sliderInput(
      "obs",
      "Number of observations:",
      min = 0,
      max = 1000,
      value = 500
    )
  })

  output$distPlot <- renderPlot({
    req(input$obs)
    hist(rnorm(input$obs))
  })
}

# Complete app with UI and server components
shinyApp(ui, server)
