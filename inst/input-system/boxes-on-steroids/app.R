library(shiny)
library(shinyWidgets)
library(OSUICode)

ui <- fluidPage(
  # import shinydashboard deps without the need of
  # the dashboard template
  useShinydashboard(),

  tags$style("body { background-color: ghostwhite};"),

  br(),
  box(
    title = textOutput("box_state"),
    "Box body",
    id = "mybox",
    collapsible = TRUE,
    plotOutput("plot")
  ),
  actionButton(
    "toggle_box",
    "Toggle Box",
    class = "bg-success"
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    req(!input$mybox$collapsed)
    plot(rnorm(200))
  })

  output$box_state <- renderText({
    state <- if (input$mybox$collapsed) {
      "collapsed"
    } else {
      "uncollapsed"
    }
    paste("My box is", state)
  })

  observeEvent(input$toggle_box, {
    updateBox("mybox")
  })

}

shinyApp(ui, server)
