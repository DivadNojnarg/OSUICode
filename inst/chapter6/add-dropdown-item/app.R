library(shiny)
library(bs4Dash)
library(OSUICode)

shinyApp(
  ui = bs4DashPage(
    navbar = bs4DashNavbar(
      rightUi = dropdownMenu(
        show = FALSE,
        status = "danger",
        src = "https://www.google.fr"
      )
    ),
    sidebar = bs4DashSidebar(),
    controlbar = bs4DashControlbar(),
    footer = bs4DashFooter(),
    title = "test",
    body = bs4DashBody(actionButton("add", "Add dropdown item"))
  ),
  server = function(input, output, session) {

    observeEvent(input$add, {
      insertDropdownItem(
        dropdownMenuItem(
          inputId = paste0("triggerAction_", input$add),
          message = paste("message", input$add),
          from = "Divad Nojnarg",
          src = "https://adminlte.io/themes/v3/dist/img/user3-128x128.jpg",
          time = "today",
          status = "danger",
          type = "message"
        )
      )
    })
  }
)
