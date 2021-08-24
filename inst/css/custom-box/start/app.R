library(shiny)
library(OSUICode)
library(shinyWidgets)

ui <- fluidPage(
  useShinydashboard(),
  br(),
  box2(
    title = "Box with border",
    background = "blue",
    height = "400px"
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
