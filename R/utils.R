shinyInputLabel <- function(inputId, label = NULL) {
  tags$label(label, class = "control-label", class = if (is.null(label)) {
    "shiny-label-null"
  }, `for` = inputId)
}
