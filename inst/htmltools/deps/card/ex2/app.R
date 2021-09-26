library(shiny)
library(OSUICode)

mdb_cdn <- "https://cdnjs.cloudflare.com/ajax/libs/"
mdb_css <- paste0(mdb_cdn, "mdb-ui-kit/3.6.0/mdb.min.css")

shinyApp(
  ui = fluidPage(
    tags$style("body {background: gainsboro;}"),
    # load the css code
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = mdb_css
      )
    ),
    fluidRow(
      column(
        width = 6,
        br(),
        my_card("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
