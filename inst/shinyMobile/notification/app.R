library(shiny)
library(OSUICode)

ui <- f7_page(
  navbar = f7_navbar("Title"),
  toolbar = f7_toolbar(),
  title = "Notifications"
)

server <- function(input, output, session) {
  observe({
    f7_notif(
      id = "welcome",
      "Helloooooo",
      options = list(closeTimeout = 2000)
    )
  })

  observeEvent(input$welcome, {
    showNotification(sprintf("Notification is %s", input$welcome))
  })
}

shinyApp(ui, server)
