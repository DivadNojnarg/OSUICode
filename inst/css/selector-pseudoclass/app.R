library(shiny)

ui <- navbarPage(
  "App Title",
  tabPanel(
    "Plot",
    tags$style(
      HTML(
        ".navbar-nav > li:first-child > a {
          font-size: 20px;
          font-weight: bold;
        }
        "
      )
    )
  ),
  navbarMenu(
    "More",
    tabPanel("Summary"),
    "----",
    "Section header",
    tabPanel("Table")
  )
)

server <- function(input, output) {}

shinyApp(ui, server)
