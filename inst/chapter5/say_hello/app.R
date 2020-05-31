library(shiny)
ui <- fluidPage(tags$script(src = "say_hello_handler.js"))
server <- function(input, output, session) {
  observe({
    invalidateLater(5000)
    say_hello_to_js("hello")
  })
}
shinyApp(ui, server, options = list(shiny.trace = TRUE))
