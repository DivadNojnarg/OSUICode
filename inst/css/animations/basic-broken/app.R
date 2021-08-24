library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      "@keyframes my-animation {
          from {color: auto;}
          to {color: red;}
        }
        h1 {
          color: grey;
        }
      "
    )
  ),
  h1("Hello World")
)

server <- function(input, output) {}

shinyApp(ui, server)
