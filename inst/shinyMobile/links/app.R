library(shiny)
library(OSUICode)

my_broken_link <- a(
  href = "https://www.google.com/",
  "Broken link"
)
my_external_link <- my_broken_link
my_external_link$attribs$class <- "external"
my_external_link$children[[1]] <- "External link"

# shinyMobile
ui <- f7_page(
  allowPWA = FALSE,
  navbar = f7_navbar("Links"),
  toolbar = f7_toolbar(
    my_broken_link,
    my_external_link
  ),
  title = "shinyMobile"
)

server <- function(input, output, session) {}

shinyApp(ui, server)
