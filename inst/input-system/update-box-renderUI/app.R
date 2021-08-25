library(shiny)
library(shinyWidgets)
library(OSUICode)

ui <- fluidPage(
  # import shinydashboard deps without the need of the
  # dashboard template
  useShinydashboard(),

  tags$style("body { background-color: ghostwhite};"),

  br(),
  uiOutput("custom_box"),
  selectInput(
    "background",
    "Background",
    choices = shinydashboard:::validColors
  )
)

server <- function(input, output, session) {

  dummy_task <- reactive({
    Sys.sleep(5)
    "New title"
  })

  output$custom_box <- renderUI({
    dummy_task()
    box2(
      title = dummy_task(),
      "Box body",
      background = input$background
    )
  })
}

shinyApp(ui, server)
