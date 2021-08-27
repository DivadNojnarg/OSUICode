library(shiny)
library(OSUICode)
library(shinyWidgets)

ui <- fluidPage(
  useShinydashboard(),
  tags$head(
    tags$script(
      HTML("$(function() {
        $(document).on('shiny:connected', function(event) {
          Shiny.setInputValue(
            'isMac',
            (navigator.appVersion.indexOf('Mac') != -1)
          );
        });
      });"
    ))
  ),
  verbatimTextOutput("info"),
  box2(
    id = "mybox",
    title = "A box",
  )
)

server <- function(input, output) {
  output$info <- renderPrint(input$isMac)
  observeEvent({
    req(isTRUE(input$isMac))
  }, {
    updateBox2(
      "mybox",
      action = "update",
      options = list(
        title = "Only visible for Mac users"
      )
    )
  })
}

shinyApp(ui, server)
