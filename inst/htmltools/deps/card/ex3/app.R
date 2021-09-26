library(shiny)
library(OSUICode)

ui <- fluidPage(
  title = "Hello Shiny!",
  tags$style("body {background: gainsboro;}"),
  fluidRow(
    column(
      width = 6,
      br(),
      my_card_with_deps("Card Content")
    )
  )
)

shinyApp(ui, server = function(input, output) { })
