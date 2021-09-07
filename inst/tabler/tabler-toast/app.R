library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_toast(
    id = "toast",
    title = "Hello",
    subtitle = "now",
    "Toast body",
    img = "https://preview-dev.tabler.io/static/logo.svg"
  ),
  tabler_button("launch", "Go!", width = "25%")
)

server <- function(input, output, session) {
  observe(print(input$toast))
  observeEvent(input$launch, {
    removeNotification("notif")
    show_tabler_toast(
      "toast",
      options = list(
        animation = FALSE,
        delay = 3000
      )
    )
  })

  observeEvent(input$toast, {
    showNotification(
      id = "notif",
      "Toast was closed",
      type = "warning",
      duration = 1,

    )
  })
}

shinyApp(ui, server)
