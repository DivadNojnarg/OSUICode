library(shiny)

ui <- fluidPage(
  tags$style(
    ".block {
      border-color: #00000;
      border-style: solid;
      background-color: lightblue;
      text-align: center;
      margin: 10px;
      min-height: 200px;
      width: 200px;
    }

    span, a {
      background-color: orange;
    }
    "
  ),
  div(
    class = "block",
    "Block 1",
    br(),
    span("Inline text 1"), span("Inline text 2")
  ),
  div(
    class = "block",
    "Block 2",
    br(),
    lapply(1:2, a, href = "https://www.google.com/", "Link")
  ),
  div(
    class = "block",
    "Block 3",
    lapply(1:5, span, "Inline text")
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
