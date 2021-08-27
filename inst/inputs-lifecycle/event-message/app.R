library(shiny)

ui <- fluidPage(
  tags$script(
    HTML("$(document).on('shiny:message', function(event) {
      console.log(event.message);
    });")
  ),
  actionButton("go", "update"),
  textInput("test", "Test1"),
  textInput("test2", "Test2")
)

server <- function(input, output, session) {
  observeEvent(input$go, ignoreInit = TRUE, {
    updateTextInput(session, "test", value = "111")
    updateTextInput(session, "test2", value = "222")
  })
}

shinyApp(ui, server)
