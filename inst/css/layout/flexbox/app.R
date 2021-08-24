library(shiny)

ui <- fluidPage(
  tags$style(
    ".container {
      display: flex;
      flex-direction: row-reverse;
      border: red dashed 2px;
    }

    p {
      width: 200px;
      height: 200px;
      text-align: center;
      color: white;
      font-size: 50px;
    }

    .container  :nth-child(1) {
      background-color: green;
    }
    .container  :nth-child(2) {
      background-color: orange;
    }
    .container  :nth-child(3) {
      background-color: purple;
    }
    "
  ),
  div(
    class = "container",
    p("A"),
    p("B"),
    p("C")
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
