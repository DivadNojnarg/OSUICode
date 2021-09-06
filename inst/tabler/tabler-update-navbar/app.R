library(shiny)
library(OSUICode)
# example with input binding: inputId is required for tabler_navbar_menu!!!
ui <- tabler_page(
  tabler_navbar(
    brand_url = "https://preview-dev.tabler.io",
    brand_image = "https://preview-dev.tabler.io/static/logo.svg",
    nav_menu = tabler_navbar_menu(
      id = "current_tab",
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
    ),
    tabler_button("update", "Change tab", icon = icon("exchange-alt"))
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
      right = a(href = "https://www.google.com")
    )
  )
)
server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })

  observeEvent(input$current_tab, {
    showNotification(
      paste("Hello", input$current_tab),
      type = "message",
      duration = 1
    )
  })

  observeEvent(input$update, {
    newTab <- if (input$current_tab == "tab1") "tab2" else "tab1"
    update_tabler_tab_item("current_tab", newTab)
  })
}
shinyApp(ui, server)
