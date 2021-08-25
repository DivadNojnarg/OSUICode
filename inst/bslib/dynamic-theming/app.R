library(shiny)
library(bslib)
library(thematic)

default <- bs_theme()

ui <- fluidPage(
  theme = default,
  theme_toggle(),
  sliderInput("obs", "N:", min = 0, max = 10, value = 5),
  plotOutput("distPlot")
)

server <- function(input, output, session) {
  observeEvent(input$custom_mode, {
    session$setCurrentTheme(
      if (input$custom_mode) bslib_neon_theme else default
    )
  })

  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

thematic_shiny()
shinyApp(ui, server)
