library(shiny)
library(OSUICode)

ui <- fluidPage(
  tags$style("body { background-color: gainsboro; }"),
  titlePanel("Shiny with a box"),
  my_dashboard_box(title = "My box", status = "danger"),
)
server <- function(input, output) {}
shinyApp(ui, server)
