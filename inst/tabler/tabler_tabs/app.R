ui <- tabler_page(
  tags$head(tags$script(src = "tabler_tabs_init.js")),
  tabler_navbar(
    brand_url = "https://preview-dev.tabler.io",
    brand_image = "https://preview-dev.tabler.io/static/logo.svg",
    nav_menu = tabler_navbar_menu(
      tabler_navbar_menu_item(
        text = "Tab 1",
        icon = NULL,
        tabName = "tab1",
        selected = TRUE
      ),
      tabler_navbar_menu_item(
        text = "Tab 2",
        icon = NULL,
        tabName = "tab2"
      )
    )
  ),
  tabler_body(
    tabler_tab_items(
      tabler_tab_item(
        tabName = "tab1",
        sliderInput(
          "obs",
          "Number of observations:",
          min = 0,
          max = 1000,
          value = 500
        ),
        plotOutput("distPlot")
      ),
      tabler_tab_item(
        tabName = "tab2",
        p("Second Tab")
      )
    ),
    footer = tabler_footer(
      left = "Rstats, 2020",
      right = a(href = "https://www.google.com", "More")
    )
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}
shinyApp(ui, server)
