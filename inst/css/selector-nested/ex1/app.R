library(shiny)

ui <- navbarPage(
  "App Title",
  tabPanel(
    "Plot",
    tags$style(
      "li a {
        font-size: 20px;
        font-weight: bold;
      }
    "
    ),
    tabsetPanel(
      tabPanel("Plot"),
      tabPanel("Summary"),
      tabPanel("Table")
    )
  ),
  tabPanel("Summary"),
  tabPanel("Table")
)

server <- function(input, output) {}

shinyApp(ui, server)
