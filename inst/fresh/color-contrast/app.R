library(shiny)
library(fresh)
library(bs4Dash)

statuses <- c(
  "primary" = "#0073b7",
  "secondary" = "#6c757d",
  "success" = "#28a745",
  "info" = "#17a2b8",
  "warning" = "#ffc107",
  "danger" = "#dc3545"
)

ui <- dashboardPage(
  dashboardHeader(title = "Card with custom contrast"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    uiOutput("sass"),
    fluidRow(
      sliderInput(
        "threshold",
        "Threshold",
        min = 0,
        max = 255,
        value = 150
      ),
      shinyWidgets::colorSelectorInput(
        inputId = "status",
        label = "Card Status color",
        choices = statuses
      )
    ),
    fluidRow(
      box(
        id = "mybox",
        solidHeader = TRUE,
        title = "You can see me!",
        status = "primary"
      )
    )
  )
)

server <- function(input, output, session) {

  observeEvent(input$status, {
    status_name <- names(which(statuses == input$status))
    updateBox(
      id = "mybox",
      action = "update",
      options = list(status = status_name)
    )
  })

  output$sass <- renderUI({
    use_theme(css())
  })
  css <- reactive({
    # Recover the hex code since bs4dash_yiq
    # does not accept names

    create_theme(
      bs4dash_yiq(
        contrasted_threshold = input$threshold,
        text_dark = "#111",
        text_light ="#fff"
      )
    )
  })
}
shinyApp(ui, server)
