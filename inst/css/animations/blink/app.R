library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      "@keyframes blink {
          50% {
            background-color: #16a520;
            box-shadow: 0 0 10px 2px #16a520;
            color: white;
          }
        }
        .blink-green {
          animation: blink 1s 1s 3 linear;
        }
      "
    )
  ),
  numericInput("number_1", "Number 1", 1),
  numericInput("number_2", "Number 2", 1),
  actionButton("calculate", "Click", class = "blink-green"),
  textOutput("sum")
)

server <- function(input, output) {
  output$sum <- renderText({
    input$calculate
    isolate({
      input$number_1 + input$number_2
    })
  })
}

shinyApp(ui, server)
