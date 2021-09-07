library(shiny)
library(OSUICode)

my_card <- tabler_card(title = "Ribbon", status = "info")
my_card$children[[1]] <-  tagAppendChild(
  my_card$children[[1]],
  tabler_ribbon(
    icon("info-circle", class = "fa-lg"),
    bookmark = TRUE,
    color = "red"
  )
)

ui <- tabler_page(
  tabler_body(
    my_card
  )
)
server <- function(input, output) {}
shinyApp(ui, server)
