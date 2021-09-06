library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_body(
    tabler_button(
      "btn",
      textOutput("val"),
      icon = icon("thumbs-up"),
      width = "25%"
    )
  )
)

server <- function(input, output, session) {
  output$val <- renderText({
    paste("Value:", input$btn)
  })
}

shinyApp(ui, server)
