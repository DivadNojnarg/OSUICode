library(shiny)
ui <- fluidPage(
  uiOutput("moreControls")
)

server <- function(input, output) {

  sliderValue <- reactive({
    # computationally intensive task
    Sys.sleep(3)
    1
  })

  output$moreControls <- renderUI({
    sliderInput("n", "N", sliderValue(), 1000, 500)
  })
}
shinyApp(ui, server)
