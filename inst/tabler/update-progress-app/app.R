library(shiny)
library(shinyWidgets)

ui <- tabler_page(
  tabler_body(
    noUiSliderInput(
      inputId = "progress_value",
      label = "Progress value",
      min = 0,
      max = 100,
      value = 20
    ),
    tabler_progress(id = "progress1", 12)
  )
)

server <- function(input, output, session) {
  observeEvent(input$progress_value, {
    update_tabler_progress(
      id = "progress1",
      input$progress_value
    )
  })
}
shinyApp(ui, server)
