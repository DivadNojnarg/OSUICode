library(shiny)
library(OSUICode)

ui <- tabler_page(
  update_tabler_progress2("progress_value", "progress1"),
  update_tabler_progress2("progress_value2", "progress2"),
  tabler_body(
    fluidRow(
      noUiSliderInput(
        inputId = "progress_value",
        label = "Progress value 1",
        min = 0,
        max = 100,
        value = 20
      ),
      noUiSliderInput(
        inputId = "progress_value2",
        label = "Progress value 2",
        min = 0,
        max = 100,
        value = 80,
        color = "red"
      )
    ),
    tabler_progress(id = "progress1", 12),
    br(), br(),
    tabler_progress(id = "progress2", 100)
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
