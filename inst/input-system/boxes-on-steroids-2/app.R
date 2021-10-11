library(shiny)
library(shinyWidgets)
library(OSUICode)

ui <- fluidPage(
  # import shinydashboard deps without the need of
  # the dashboard template
  useShinydashboard(),

  tags$style("body { background-color: ghostwhite};"),

  br(),
  box2(
    title = "My box",
    "Box body",
    id = "mybox",
    height = "400px",
    width = 6
  )
)

server <- function(input, output, session) {

  dummy_task <- reactive({
    Sys.sleep(5)
    12
  })

  observeEvent(dummy_task(), {
    updateBox2(
      "mybox",
      action = "update",
      options = list(
        width = dummy_task(),
        title = tagList(
          shinydashboardPlus::dashboardBadge(
            "New",
            color = "red"
          ),
          "New title"
        )
      )
    )
  })

}

shinyApp(ui, server)
