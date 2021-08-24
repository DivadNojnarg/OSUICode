library(shiny)
library(OSUICode)
library(shinyWidgets)

ui <- fluidPage(
  useShinydashboard(),
  tags$style(
    ".box {
      border-top: none;
      border-radius: 10px;
      border-left: 6px solid #e28810;
      box-shadow: 0 1px 1px rgb(0 0 0 / 10%);
    }
    .box:hover {
      box-shadow: 0px 8px 8px 0px rgb(0, 0, 0, 0.2);
    }
    .box-header {
      color: #fff;
    }
    "
  ),
  br(),
  box2(
    title = "Box with border",
    background = "blue",
    height = "400px"
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
