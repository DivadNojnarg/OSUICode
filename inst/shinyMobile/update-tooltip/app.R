library(shiny)
library(OSUICode)

shinyMobile_options$dark <- FALSE

ui <- f7_page(
  allowPWA = FALSE,
  options = shinyMobile_options,
  tags$div(
    class = "block",
    tags$button(
      id = "mybutton",
      class = "button button-large button-fill action-button",
      "Click"
    ),
    tags$label(
      class = "toggle",
      tags$input(type = "checkbox", id = "enable"),
      tags$span(class = "toggle-icon")
    )
  ),
  navbar = f7_navbar("Add tooltip"),
  toolbar = f7_toolbar(),
  title = "Notifications"
)

server <- function(input, output, session) {
  observeEvent(TRUE, once = TRUE, {
    add_f7_tooltip(
      id = "mybutton",
      options = list(text = "This is a button")
    )
  })

  observeEvent(input$enable, {
    update_f7_tooltip(
      id = "mybutton",
      action = "toggle"
    )
  })

  observeEvent(input$mybutton, {
    update_f7_tooltip(
      id = "mybutton",
      action = "update",
      text = "New tooltip text"
    )
  })
}

shinyApp(ui, server)
