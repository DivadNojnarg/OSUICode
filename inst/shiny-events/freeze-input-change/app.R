library(shiny)

ui <- fluidPage(
  tags$script(
    HTML("
      $(document).on(
        'shiny:inputchanged',
        function(event) {
          event.preventDefault();
      });"
  )),
  textInput("test", "Test"),
  verbatimTextOutput("val")
)

server <- function(input, output) {
  output$val <- renderPrint(input$test)
}

shinyApp(ui, server)
