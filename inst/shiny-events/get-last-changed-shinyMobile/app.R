library(shiny)
library(shinyMobile)

shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Single Layout",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content,
      f7Card(
        f7Text(inputId = "text", label = "Text"),
        f7Slider(
          inputId = "range1",
          label = "Range",
          min = 0, max = 2,
          value = 1,
          step = 0.1
        ),
        verbatimTextOutput("lastChanged")
      )
    )
  ),
  server = function(input, output) {
    output$lastChanged <- renderPrint(input$lastInputChanged)
  }
)
