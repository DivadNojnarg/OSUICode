library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_navbar(
    brand_url = "https://preview-dev.tabler.io",
    brand_image = "https://preview-dev.tabler.io/static/logo.svg",
    nav_menu = NULL,
    tabler_dropdown(
      id = "mydropdown",
      title = "Dropdown",
      subtitle = "click me",
      tabler_dropdown_item(
        id = "item1",
        "Show Notification"
      ),
      tabler_dropdown_item(
        "Do nothing"
      )
    )
  ),
  tabler_body(
    tabler_button("show", "Open dropdown", width = "25%"),
    footer = tabler_footer(
      left = "Rstats, 2020",
      right = a(href = "https://www.google.com")
    )
  )
)
server <- function(input, output, session) {

  observeEvent(input$show, {
    show_tabler_dropdown("mydropdown")
  })

  observeEvent(input$item1, {
    showNotification(
      "Success",
      type = "message",
      duration = 2,

    )
  })
}
shinyApp(ui, server)
