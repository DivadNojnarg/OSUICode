library(shiny)
library(wavesurfer)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/main.css"),
    tags$script(src = "js/main.js")
  ),
  tags$main(
    div(
      class = "screen",
        wavesurferOutput("my_ws")
    ),
    div(class = "jog paused"),
    div(class = "play action-button", id = "go"),
    div(class = "cue")
  )
)

server <- function(input, output, session) {
  output$my_ws <- renderWavesurfer({
    wavesurfer(audio = "music/track1.mp3", barHeight = 0.5) %>%
      ws_set_wave_color('#129cf5')
  })

  observeEvent(input$go, {
    if (input$go %% 2 != 0) {
      ws_play("my_ws")
    } else {
      ws_pause("my_ws")
    }

  })
}

shinyApp(ui, server)
