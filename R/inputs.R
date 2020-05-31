#' Create a custom  Shiny text input
#'
#' This is to showcase how to develop Shiny custom inputs (see Chapter 5.4)
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value.
#' @param width The width of the input, e.g. '400px', or '100%'; see \link[shiny]{validateCssUnit}.
#' @param placeholder A character string giving the user a
#' hint as to what can be entered into the control.
#' Internet Explorer 8 and 9 do not support this option.
#' @param binding_step This parameter is only for the book purpose. This is to be able
#' to follow each step of the input binding creation of Chapter 5.4. When you develop
#' your own template, you don't need this. Provides the fully working binding instead!
#'
#' @return A text input control that can be added to a UI definition.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- fluidPage(
#'    customTextInput(
#'     inputId = "caption",
#'     label = "Caption",
#'     value = "Data Summary",
#'     binding_step = 1
#'    ),
#'    textOutput("customText")
#'  )
#'  server <- function(input, output) {
#'    output$customText <- renderText(input$caption)
#'  }
#'  shinyApp(ui, server)
#' }
customTextInput <- function (inputId, label, value = "", width = NULL, placeholder = NULL, binding_step) {

  # this external wrapper ensure to control the input width
  div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) {
      paste0("width: ", validateCssUnit(width), ";")
    },
    # input label
    shinyInputLabel(inputId, label),

    # input element
    tagList(
      customTextInputDeps(binding_step),
      tags$input(
        id = inputId,
        type = "text",
        class = "form-control input-text",
        value = value,
        placeholder = placeholder
      )
    )
  )
}



#' Add necessary dependencies for the \link{customTextInput}
#'
#' The step provides a way to follow the Chapter 1 book section.
#' For instance, if step = 1, it means that we consider the 5.4.2.1 Find the input section, and so on,
#' until the fully complete binding.
#'
#' @param step Input binding step. Each step corresponds to a specific method
#' of the full input binding. For instance, step 1 only includes the find method,
#' step 2 contains, find + getValue...
#'
#' @return An html dependency for \link{customTextInput}.
#' @export
customTextInputDeps <- function(step) {
  htmlDependency(
    name = "customTextBindings",
    version = "1.0.0",
    src = c(file = system.file("chapter5/input-bindings", package = "OSUICode")),
    script = paste0("customTextInputBinding_", step, ".js")
  )
}
