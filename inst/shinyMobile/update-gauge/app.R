library(shiny)
library(OSUICode)

ui <- f7_page(
  allowPWA = FALSE,
  div(
    class = "block",
    f7_gauge(
      "mygauge",
      value = 0.1,
      options = list(
        type  = "semicircle",
        borderColor = "#2196f3",
        borderWidth = 10,
        valueFontSize = 41,
        valueTextColor = "#2196f3",
        labelText = "amount of something"
      )
    )
  ),
  navbar = f7_navbar("Update gauge instance"),
  toolbar = f7_toolbar(),
  title = "shinyMobile"
)

server <- function(input, output, session) {
  observeEvent(TRUE, once = TRUE, {
    Sys.sleep(2)
    update_f7_instance(
      "mygauge",
      options = list(
        value = 0.75,
        valueText = "75 %",
        labelText = "New label!"
      )
    )
  })
}

shinyApp(ui, server)
