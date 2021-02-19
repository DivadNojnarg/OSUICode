library(shiny)
library(OSUICode)

ui <- f7_page(
  navbar = f7_navbar("Title"),
  toolbar = f7_toolbar(),
  title = "shinyMobile",
  options = list(
    theme = "ios",
    version = "1.0.0",
    taphold = TRUE,
    color = "#42f5a1",
    filled = TRUE,
    dark = TRUE
  )
)

server <- function(input, output, session) {
  observe({
    f7_notif(id = "welcome", "Helloooooo", options = list(closeTimeout = 2000))
  })

  observeEvent(input$welcome, {
    showNotification(sprintf("Notification is %s", input$welcome))
  })
}

shinyApp(ui, server)
