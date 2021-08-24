library(shiny)

ui <- fluidPage(
  tags$style(
    ".first-p {
      color: red;
    }
    #element {
      color: red;
    }
    "
  ),
  p(class = "first-p", "Hello World"),
  p("Another text"),
  div(id = "element", "A block")
)

server <- function(input, output) {}

shinyApp(ui, server)
