library(shiny)
library(OSUICode)

bs4_cdn <- "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/"
bs4_css <- paste0(bs4_cdn, "css/bootstrap.min.css")

shinyApp(
  ui = fluidPage(
    # load the css code
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = bs4_css
      )
    ),
    fluidRow(
      column(
        width = 6,
        align = "center",
        br(),
        my_card("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
