library(shiny)
library(OSUICode)

ui <- f7_page(
  allowPWA = FALSE,
  tags$div(
    class = "list inset",
    tags$ul(
      tags$li(
        tags$a(
          href = "#",
          id = "mybutton",
          class = "list-button color-red",
          "Large Red Button"
        )
      )
    )
  ),
  navbar = f7_navbar("Taphold demo"),
  toolbar = f7_toolbar(),
  title = "shinyMobile"
)

server <- function(input, output, session) {}

shinyApp(ui, server)
