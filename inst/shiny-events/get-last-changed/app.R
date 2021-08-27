library(shiny)

shinyApp(
  ui = fluidPage(
    textInput('txt_a', 'Input Text A'),
    textInput('txt_b', 'Input Text B'),
    uiOutput('txt_c_out'),
    verbatimTextOutput("show_last")
  ),
  server = function(input, output, session) {
    output$txt_c_out <- renderUI({
      textInput('txt_c', 'Input Text C')
    })

    values <- reactiveValues(
      lastUpdated = NULL
    )

    observe({
      lapply(names(input), function(x) {
        observe({
          input[[x]]
          values$lastUpdated <- x
        })
      })
    })

    output$show_last <- renderPrint({
      values$lastUpdated
    })
  }
)
