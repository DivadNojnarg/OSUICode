library(shiny)
library(waiter)

ui <- fluidPage(
  use_waiter(), # dependencies
  # shows before anything else
  waiter_preloader(spin_fading_circles()),
  sliderInput("obs", "Number of observations:",
              min = 0, max = 1000, value = 500
  ),
  plotOutput("distPlot")
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    Sys.sleep(3)
    hist(rnorm(input$obs))
  })
}
shinyApp(ui, server)
