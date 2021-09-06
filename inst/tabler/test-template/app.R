library(shiny)
library(OSUICode)

card <- '
  <div class="card">
    <div class="card-status-top bg-danger"></div>
    <div class="card-body">
      <h3 class="card-title">
        <div id="value" class="shiny-text-output"></div>
      </h3>
      <p>This is some text within a card body.</p>
    </div>
  </div>
'

ui <- tabler_page(
  textInput("caption", "Title", "Card title"),
  HTML(card),
title = "Tabler test"
)
server <- function(input, output) {
  output$value <- renderText({ input$caption })
}
shinyApp(ui, server)
