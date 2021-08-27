library(shiny)

ui <- fluidPage(
  tags$button(id = "button", "Go!", class = "btn-success")
) %>% tagList(pokemonDeps())

server <- function(input, output, session) {

  observeEvent(input$pokeData, {
    background <- input$pokeData$sprites$other$`official-artwork`$front_default
    message(background)
    session$sendCustomMessage(
      type = "update_background",
      message = background
    )
  })
}

shinyApp(ui, server)
