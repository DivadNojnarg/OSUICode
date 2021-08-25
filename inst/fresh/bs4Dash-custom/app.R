library(shiny)
library(bs4Dash)
library(fresh)

custom_colors_theme <- create_theme(
  bs4dash_color(
    lightblue = "#136377",
    olive = "#d8bc66",
    lime = "#fcec0c",
    orange = "#978d01",
    maroon = "#58482c",
    gray_x_light = "#d1c5c0"
  )
)


ui <- dashboardPage(
  freshTheme = custom_colors_theme,
  dashboardHeader(title = "Custom colors"),
  dashboardSidebar(),
  dashboardBody(
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
