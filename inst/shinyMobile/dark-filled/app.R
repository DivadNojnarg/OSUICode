library(shiny)
library(OSUICode)

shinyMobile_options$filled <- TRUE

ui <- f7_page(
  allowPWA = FALSE,
  options = shinyMobile_options,
  tags$div(
    class = "block",
    tags$button(
      class = "button button-large button-fill",
      "Click"
    )
  ),
  navbar = f7_navbar("Dark/filled design"),
  toolbar = f7_toolbar(),
  title = "shinyMobile"
)

server <- function(input, output, session) {}

shinyApp(ui, server)
