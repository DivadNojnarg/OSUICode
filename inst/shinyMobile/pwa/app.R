library(shiny)
library(OSUICode)

ui <- f7_page(
  navbar = f7_navbar("PWA App"),
  toolbar = f7_toolbar(),
  title = "shinyMobile"
)

server <- function(input, output, session) {
  session$allowReconnect("force")
}

shinyApp(ui, server)
