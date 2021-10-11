library(shiny)
library(bs4Dash)
library(OSUICode)

usr <- "https://adminlte.io/themes/v3/dist/img/user2-160x160.jpg"

shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(
      rightUi = OSUICode::dropdownMenu(
        badgeStatus = "danger",
        type = "messages"
      )
    ),
    sidebar = dashboardSidebar(),
    controlbar = dashboardControlbar(),
    footer = dashboardFooter(),
    title = "test",
    body = dashboardBody(actionButton("add", "Add dropdown item"))
  ),
  server = function(input, output, session) {

    observeEvent(input$add, {
      insertMessageItem(
        messageItem(
          message = paste("message", input$add),
          image = usr,
          from = "Divad Nojnarg",
          time = "today",
          color = "success"
        )
      )
    })
  }
)
