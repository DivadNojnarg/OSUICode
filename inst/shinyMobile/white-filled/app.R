library(shiny)
library(OSUICode)

shinyMobile_options$filled <- TRUE
shinyMobile_options$dark <- FALSE

ui <- f7_page(
  options = shinyMobile_options,
  tags$div(
    class = "block",
    tags$button(
      class = "button button-large button-fill",
      "Click"
    )
  ),
  navbar = f7_navbar("White/filled design"),
  toolbar = f7_toolbar(),
  title = "shinyMobile"
)

server <- function(input, output, session) {}

shinyApp(ui, server)
