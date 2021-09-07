library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_navbar(
    brand_url = "https://preview-dev.tabler.io",
    brand_image = "https://preview-dev.tabler.io/static/logo.svg",
    nav_menu = tabler_navbar_menu(
      inputId = "tabmenu",
      tabler_navbar_menu_item(
        text = "Tab 1",
        tabName = "tab1",
        selected = TRUE
      ),
      tabler_navbar_menu_item(
        text = "Tab 2",
        tabName = "tab2"
      )
    ),
    tabler_button("insert", "Insert Tab")
  ),
  tabler_body(
    tabler_tab_items(
      tabler_tab_item(
        tabName = "tab1",
        p("Hello World")
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

  observeEvent(input$insert, {
    insert_tabler_tab_2(
      inputId = "tabmenu",
      tab = tabler_tab_item(
        tabName = "tab3",
        sliderInput("obs", "Number of observations:",
                    min = 0, max = 1000, value = 500
        ),
        plotOutput("distPlot")
      ),
      target = "tab2",
      position = "before",
      select = TRUE
    )
  })
}
shinyApp(ui, server)
