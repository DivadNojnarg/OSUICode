library(bs4Dash)
library(tibble)

new_message <- tibble(
  message = "New message",
  from = "Paul",
  time = "yesterday",
  color = "success"
)

shinyApp(
  ui = dashboardPage(
    dark = FALSE,
    header = dashboardHeader(
      rightUi = uiOutput("messages", container = tags$li)
    ),
    sidebar = dashboardSidebar(),
    controlbar = dashboardControlbar(),
    footer = dashboardFooter(),
    title = "test",
    body = dashboardBody(actionButton("add", "Add message"))
  ),
  server = function(input, output) {

    messages <- reactiveValues(
      items = tibble(
        message = rep("A message", 10),
        from = LETTERS[1:10],
        time = rep("yesterday", 10),
        color = rep("success", 10)
      )
    )

    observeEvent(input$add, {
      messages$items <- add_row(messages$items, new_message)
    })

    output$messages <- renderUI({
      dropdownMenu(
        badgeStatus = "danger",
        type = "messages",
        lapply(seq_len(nrow(messages$items)), function(r) {
          temp <- messages$items[r, ]
          messageItem(
            message = temp$message,
            from = temp$from,
            time = temp$time,
            color = temp$color
          )
        })
      )
    })
  }
)
