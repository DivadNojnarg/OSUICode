library(shiny)

registerInputHandler("myPKG.textDate", function(data, ...) {
  if (is.null(data)) {
    NULL
  } else {
    res <- try(as.Date(unlist(data)), silent = TRUE)
    if ("try-error" %in% class(res)) {
      warning("Failed to parse dates!")
      data
    } else {
      res
    }
  }
}, force = TRUE)

ui <- fluidPage(
  tags$script(HTML(
    "$(function(){
      $(document).on('shiny:connected', function() {
        var currentTime = new Date();
        Shiny.setInputValue('time1', currentTime);
        Shiny.setInputValue(
          'time2:myPKG.textDate',
          currentTime
        );
      });
    });
    "
  )),
  verbatimTextOutput("res1"),
  verbatimTextOutput("res2")
)

server <- function(input, output, session) {
  output$res1 <- renderPrint({
    list(class(input$time1), input$time1)
  })
  output$res2 <- renderPrint({
    list(class(input$time2), input$time2)
  })
}

shinyApp(ui, server)
