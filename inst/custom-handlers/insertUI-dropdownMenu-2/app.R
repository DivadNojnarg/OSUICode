library(shiny)
library(bs4Dash)
library(OSUICode)

ui <- dropdownMenuUI()

shinyApp(
  ui = ui,
  server = function(input, output, session) {
    # remove old badge
    observeEvent(input$add, {
      removeUI(selector = ".badge-danger.navbar-badge")
    }, priority = 1)
    # insert new badge
    observeEvent(input$add, {
      insertUI(
        selector = "[data-toggle=\"dropdown\"]",
        where = "beforeEnd",
        ui = tags$span(
          class = "badge badge-danger navbar-badge",
          input$add
        )
      )
    })

    # remove old text counter
    observeEvent(input$add, {
      removeUI(selector = ".dropdown-item.dropdown-header")
    }, priority = 1)

    # insert new text counter
    observeEvent(input$add, {
      insertUI(
        selector = ".dropdown-menu",
        where = "afterBegin",
        ui = tags$span(
          class = "dropdown-item dropdown-header",
          sprintf("%s Items", input$add)
        )
      )
    })

    # Insert message item
    observeEvent(input$add, {
      insertUI(
        selector = ".dropdown-menu >
        .dropdown-item.dropdown-header",
        where = "afterEnd",
        ui = messageItem(
          message = paste("message", input$add),
          image = user,
          from = "Divad Nojnarg",
          time = "today",
          color = "success"
        )
      )
    })

  }
)
