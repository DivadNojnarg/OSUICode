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
      class = "button button-large button-fill",
      "Click"
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
}

shinyApp(ui, server)
