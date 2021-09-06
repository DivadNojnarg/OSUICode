library(shiny)
library(OSUICode)

ui <- tabler_page(
  tabler_body(
    fluidRow(
      tabler_button(
        "update",
        "Go!",
        width = "25%",
        class = "mr-2"
      ),
      tabler_switch(
        "toggle",
        "Switch",
        value = TRUE,
        width = "25%"
      )
    )
  )
)

server <- function(input, output, session) {
  observe(print(input$toggle))
  observeEvent(input$update, {
    update_tabler_switch(
      session,
      "toggle",
      value = !input$toggle
    )
  })
}

shinyApp(ui, server)
