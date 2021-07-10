library(shiny)
library(OSUICode)

ui <- f7_page(
  tags$div(
    class = "list inset",
    tags$ul(
      tags$li(
        tags$a(
          href = "#",
          id = "mybutton",
          class = "list-button",
          "Large Green Button"
        )
      )
    )
  ),
  navbar = f7_navbar("Title"),
  toolbar = f7_toolbar(),
  title = "shinyMobile",
  options = list(
    theme = "ios",
    version = "1.0.0",
    touch = list(
      tapHold = TRUE
    ),
    color = "#42f5a1",
    filled = TRUE,
    dark = TRUE
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
