library(shiny)

shinyApp(
  ui = fluidPage(
    actionButton("show", "Show modal dialog")
  ),
  server = function(input, output) {
    observeEvent(input$show, {
      showModal(
        modalDialog(
          title = "Important message",
          "This is an important message!"
        )
      )
    })
  }
)
