library(shiny)
library(sass)
library(shinybulma)

css <- sass(
  sass_layer(
    defaults = list(
      turquoise = "#03a4ff",
      cyan = "#e705be",
      green = "#f3d6e9",
      yellow = "#fdaf2c",
      red = "#ff483e",
      "scheme-main" = "hsl(0, 0%, 10%)"
    ),
    rules = sass_file(input = system.file(
      "sass/bulma/bulma.sass",
      package = "OSUICode"
    ))
  )
)

shinyApp(
  ui = bulmaPage(
    tags$head(tags$style(css)),
    bulmaSection(
      bulmaTileAncestor(
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 1"),
            p("Put some data here"),
            color = "link"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 2"),
            "Hi Bulma!",
            color = "danger"
          )
        ),
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            p("Put some data here"),
            color = "warning"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            ("Put some data here"),
            color = "info"
          )
        )
      )
    )
  ),
  server = function(input, output) {}
)
