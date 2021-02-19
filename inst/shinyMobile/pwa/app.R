library(shiny)
library(OSUICode)

ui <- f7_page(
  f7_gauge(
    "mygauge",
    value = 0.1,
    options = list(
      type = "semicircle",
      borderColor = "#2196f3",
      borderWidth = 10,
      valueFontSize = 41,
      valueTextColor = "#2196f3",
      labelText = "amount of something"
    )
  ),
  navbar = f7_navbar("Title"),
  toolbar = f7_toolbar(),
  title = "shinyMobile",
  options = list(
    theme = "ios",
    version = "1.0.0",
    taphold = TRUE,
    color = "#42f5a1",
    filled = TRUE,
    dark = TRUE
  )
)

server <- function(input, output, session) {
  session$allowReconnect("force")
  observe({
    Sys.sleep(2)
    update_f7_instance("mygauge", options = list(value = 0.75, valueText = "75 %", labelText = "New label!"))
  })
}

shinyApp(ui, server)