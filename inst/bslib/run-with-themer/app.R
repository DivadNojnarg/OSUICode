library(shiny)
library(bslib)
library(OSUICode)

ui <- fluidPage(
  theme = bslib_neon_theme,
  tabsetPanel(
    tabPanel(
      "First tab",
      "The contents of the first tab",
      actionButton("test", "Test")
    ),
    tabPanel(
      "Second tab",
      "The contents of the second tab"
    )
  )
)
server <- function(input, output, session) {}
run_with_themer(shinyApp(ui, server))
