library(shiny)

ui <- fluidPage(
  sliderInput("n", "N", 100, 1000, 500)
)

server <- function(input, output, session) {

  sliderValue <- reactive({
    # computationally intensive task
    Sys.sleep(3)
    150
  })

  observeEvent(sliderValue(), {
    updateSliderInput(
      session,
      "n",
      value = sliderValue()
    )
  })
}
shinyApp(ui, server)
