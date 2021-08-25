library(shiny)
library(OSUICode)

ui <- tagList(
  fluidPage(
    actionButton("button1", icon("plus")),
    actionButton("button2", uiOutput("val")),
    actionButton("reset", icon("undo")),
    plotOutput("plot")
  ),
  editBindingDeps()
)

server <- function(input, output) {
  output$val <- renderUI({
    paste("Value: ", input$button2)
  })

  output$plot <- renderPlot({
    validate(
      need(
        input$button2 >= 10,
        message = "Only visible after 10 clicks on
        the second button"
      )
    )
    hist(rnorm(100))
  })

  observeEvent(input$button2, {
    if (input$button2 == 0) {
      showNotification(
        "Button successfuly reset",
        type = "warning"
      )
    }
  })
}

shinyApp(ui, server)
