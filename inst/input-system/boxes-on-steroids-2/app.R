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
    width = 12,
    steroids = TRUE
  ),
  numericInput("box_width", "Box width", 6, 1, 12),
  actionButton(
    "update_box",
    "Update box",
    class = "bg-success"
  )
)

server <- function(input, output, session) {

  observeEvent(input$update_box, {
    updateBox2(
      "mybox",
      action = "update",
      options = list(
        width = input$box_width,
        title = tagList(
          shinydashboardPlus::dashboardBadge("New", color = "red"),
          "title"
        )
      )
    )
  })

}

shinyApp(ui, server)
