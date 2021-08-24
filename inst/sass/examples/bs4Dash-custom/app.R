library(shiny)
library(sass)
library(bs4Dash)

css <- sass(
  sass_layer(
    defaults = list(
      lightblue = "#136377",
      olive = "#d8bc66",
      lime = "#fcec0c",
      orange = "#978d01",
      maroon = "#58482c",
      "gray-x-light" = "#d1c5c0"
    ),
    rules = sass_file(
      input = system.file(
        "sass/adminlte/adminlte.scss",
        package = "OSUICode"
      )
    )
  )
)


ui <- dashboardPage(
  dashboardHeader(title = "Custom colors"),
  dashboardSidebar(),
  dashboardBody(
    tags$head(tags$style(css)),
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        solidHeader = TRUE,
        plotOutput("plot1", height = 250),
        status = "olive"
      ),
      box(
        solidHeader = TRUE,
        status = "lightblue",
        title = "Controls",
        sliderInput(
          "slider",
          "Number of observations:",
          1,
          100,
          50
        )
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
