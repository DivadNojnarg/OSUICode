library(shiny)
library(bslib)
library(OSUICode)

ui <- fluidPage(
  theme = bs_theme(),
  theme_toggle(),
  br(),
  super_card("Hello World!")
)

server <- function(input, output, session) {
  observeEvent(input$custom_mode, {
    session$setCurrentTheme(
      if (input$custom_mode) {
        bslib_dark_theme
      } else {
        bs_theme()
      }
    )
  })
}

shinyApp(ui, server)
