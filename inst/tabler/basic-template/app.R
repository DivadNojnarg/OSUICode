library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_body(
    p("Hello World"),
    footer = tabler_footer(
      left = "Rstats, 2020",
      right = a(href = "https://www.google.com", "More")
    )
  )
)
server <- function(input, output) {}
shinyApp(ui, server)
