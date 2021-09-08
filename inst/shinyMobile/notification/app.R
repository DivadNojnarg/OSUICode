library(shiny)
library(OSUICode)

ui <- f7_page(
  allowPWA = FALSE,
  navbar = f7_navbar("Notifications"),
  toolbar = f7_toolbar(),
  title = "Notifications"
)

server <- function(input, output, session) {
  observeEvent(TRUE, once = TRUE, {
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
