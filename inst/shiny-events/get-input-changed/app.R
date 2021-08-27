library(shiny)

ui <- fluidPage(
  tags$script(
    HTML("$(document).on(
      'shiny:inputchanged',
      function(event) {
       console.log(event);
    });"
  )),
  textInput("test", "Test")
)

server <- function(input, output) {}

shinyApp(ui, server)
