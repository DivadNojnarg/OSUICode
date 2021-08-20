library(shiny)
library(OSUICode)

shinyApp(
  ui = fluidPage(
    fluidRow(
      column(
        width = 6,
        align = "center",
        br(),
        my_card("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
