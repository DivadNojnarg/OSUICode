library(shiny)
library(bslib)
library(OSUICode)

ui <- fluidPage(
  theme = bs_theme(version = 4),
  bs_accordion(
    id = "accordion",
    items = tagList(
      bs_accordion_item(
        title = "Item 1",
        "Item 1 content",
        active = TRUE
      ),
      bs_accordion_item(
        title = "Item 2",
        "Item 2 content"
      )
    )
  )
)

server <- function(input, output, session) {}
run_with_themer(shinyApp(ui, server))
