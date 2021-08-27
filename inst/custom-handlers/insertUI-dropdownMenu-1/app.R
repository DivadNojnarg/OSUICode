library(shiny)
library(bs4Dash)
library(OSUICode)

ui <- dropdownMenuUI()

shinyApp(
  ui = ui,
  server = function(input, output, session) {

    observeEvent(input$add, {
      insertUI(
        selector = ".dropdown-menu >
        .dropdown-item.dropdown-header",
        where = "afterEnd",
        ui = messageItem(
          message = paste("message", input$add),
          image = dashboardUserImage,
          from = "Divad Nojnarg",
          time = "today",
          color = "success"
        )
      )
    })
  }
)
