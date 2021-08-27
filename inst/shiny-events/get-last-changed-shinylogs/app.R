library(shiny)
library(shinylogs)

shinyApp(
  ui = fluidPage(
    numericInput("n", "n", 1),
    sliderInput("s", "s", min = 0, max = 10, value = 5),
    verbatimTextOutput("lastChanged")
  ),
  server = function(input, output, session) {
    # specific to shinylogs
    track_usage(storage_mode = store_null())
    output$lastChanged <- renderPrint({
      input$`.shinylogs_lastInput`
    })
  }
)
