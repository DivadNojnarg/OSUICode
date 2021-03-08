#' Shiny app example showing random pokemon image
#'
#' @return A shiny app
#' @export
runPokemonExample <- function() {
  ui <- fluidPage(
    tags$button(id = "button", "Go!", class = "btn-success")
  ) %>% tagList(
    htmlDependency(
      name = "pokemon",
      version = "1.0.0",
      src = system.file("inst/pokemon-1.0.0", package = "OSUICode"),
      script = "pokemons-handlers.js"
    )
  )

  server <- function(input, output, session) {

    observeEvent(input$pokeData, {
      background <- input$pokeData$sprites$other$`official-artwork`$front_default
      message(background)
      session$sendCustomMessage(type = "update_background", message = background)
    })
  }

  shinyApp(ui, server)
}
