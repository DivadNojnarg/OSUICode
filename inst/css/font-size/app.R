library(shiny)

ui <- fluidPage(
  tags$style(
    ".smaller--h1 {
      font-size: 0.75em;
    }
    .smaller--p {
      font-size: 80%;
    }
    "
  ),
  h1("Default <h1>"),
  h1(class = "smaller--h1", "Smaller <h1>"),
  p("Normal <p>"),
  p(class = "smaller--p", "Smaller <p>")
)

server <- function(input, output) {}

shinyApp(ui, server)
