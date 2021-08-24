library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      "@keyframes my-animation {
          from {color: grey;}
          to {color: red;}
      }
      h1 {
        color: grey;
        animation: my-animation 3s 2s forwards;
      }
      "
    )
  ),
  h1("Hello World")
)

server <- function(input, output) {}

shinyApp(ui, server)
