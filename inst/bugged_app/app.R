library(shiny)

ui <- fluidPage(
  tags$script(src = "notif.js"),
  actionButton(
    "notif",
    "Show notification",
    onclick = "sendNotif('Oups', 'error', 2000)"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
