library(shiny)

ui <- fluidPage(
  tags$style(
    "@media all and (max-device-width: 480px) {
      p {
        font-size: 1.5em;
      }
    }
    "
  ),
  p("Hello World")
)

server <- function(input, output) {}
shinyApp(ui, server)
