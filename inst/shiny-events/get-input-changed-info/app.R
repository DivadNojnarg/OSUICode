library(shiny)

ui <- fluidPage(
  tags$script(
    HTML("
      $(document).ready(function() {
        $('#test').on(
          'shiny:inputchanged',
          function(event) {
            Shiny.setInputValue(
              'last_changed',
              {
                name: event.name,
                value: event.value,
                type: event
                  .binding
                  .name
                  .split('.')[1]
              }
            );
        });
      });"
    )),
  textInput("test", "Test"),
  verbatimTextOutput("last_changed")
)

server <- function(input, output) {
  output$last_changed <- renderPrint(input$last_changed)
}

shinyApp(ui, server)
