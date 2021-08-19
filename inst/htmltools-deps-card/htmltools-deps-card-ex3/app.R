library(shiny)
library(OSUICode)

ui <- fluidPage(
  title = "Hello Shiny!",
  fluidRow(
    column(
      width = 6,
      align = "center",
      br(),
      my_card_with_deps("Card Content")
    )
  )
)

shinyApp(ui, server = function(input, output) { })
