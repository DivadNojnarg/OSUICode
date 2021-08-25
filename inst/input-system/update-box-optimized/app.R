library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

ui <- dashboardPage(
  title = "Optimized update box",
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    box(
      id = "mybox",
      status = "primary",
      title = "Hello",
      "Box body"
    ),
    selectInput(
      "background",
      "Background",
      choices = shinydashboard:::validColors
    )
  )
)

server <- function(input, output, session) {

  dummy_task <- reactive({
    Sys.sleep(5)
    "New title"
  })

  observeEvent(input$background, {
    updateBox(
      id = "mybox",
      action = "update",
      options = list(
        background = input$background,
        title = dummy_task()
      )
    )
  })
}

shinyApp(ui, server)
