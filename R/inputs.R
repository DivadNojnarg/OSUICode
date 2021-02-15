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
#' library(shiny)
#'
#'  # This example corresponds to section 5.4.2.1 (Find the input)
#'  customTextInputExample(1)
#'
#'  # This example corresponds to section 5.4.2.3 (Get the value)
#'  customTextInputExample(2)
#'
#'  # This example corresponds to section 5.4.2.6 (Setting rate policies). At that
#'  # stage, the binding is fully working
#'  customTextInputExample(6)
#' }
customTextInput <- function (inputId, label, value = "", width = NULL, placeholder = NULL, binding_step) {

  type <- if (inherits(value, "Date")) {
    "date"
  } else if (inherits(value, "numeric")) {
    "number"
  } else {
    NULL
  }

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
        placeholder = placeholder,
        `data-data-type` = type
      )
    )
  )
}



#' Wrapper for Shiny App example
#'
#' @param binding_step Input binding step. See \link{customTextInput}.
#'
#' @return A Shiny App example
#' @export
customTextInputExample <- function(binding_step, value = "Data Summary") {
  ui <- fluidPage(
    customTextInput(
      inputId = "caption",
      label = "Caption",
      value = value,
      binding_step = binding_step
    ),
    textOutput("custom_text")
  )
  server <- function(input, output) {
    output$custom_text <- renderPrint(input$caption)
  }
  shinyApp(ui, server)
}




#' Wrapper for Shiny App example with input handler
#'
#' @param binding_step Input binding step. See \link{customTextInput}.
#' @param value Default value. Dates are handled with a custom input handler.
#'
#' @return A Shiny App example
#' @export
customTextInputHandlerExample <- function(binding_step, value = "Data Summary") {
  ui <- fluidPage(
    customTextInput(
      inputId = "caption",
      label = "Caption",
      value = value,
      binding_step = binding_step
    ),
    textOutput("custom_text")
  )
  server <- function(input, output) {
    output$custom_text <- renderPrint({
      list(
        value = input$caption,
        class = class(input$caption)
      )
    })
  }
  shinyApp(ui, server)
}





#' Wrapper for Shiny App example
#'
#' @return A Shiny App example
#' @export
customTextInputExampleBis <- function() {
  ui <- fluidPage(
    customTextInput(
      inputId = "mytextInput",
      label = "Caption",
      value = "Data Summary",
      binding_step = "1_bis"
    ),
    customTextInput(
      inputId = "myothertextInput",
      label = "Caption",
      value = "Data Summary",
      binding_step = "1_bis"
    ),
    textOutput("custom_text")
  )
  server <- function(input, output) {
    output$custom_text <- renderText(input$caption)
  }
  shinyApp(ui, server)
}


#' Add necessary dependencies for the \link{customTextInput}
#'
#' The step provides a way to follow the Chapter 1 book section.
#' For instance, if step = 1, it means that we consider the 5.4.2.1 Find the input section, and so on,
#' until the fully complete binding.
#'
#' @param binding_step Input binding step. Each step corresponds to a specific method
#' of the full input binding. For instance, step 1 only includes the find method,
#' step 2 contains, find + getValue...
#'
#' @return An html dependency for \link{customTextInput}.
#' @export
customTextInputDeps <- function(binding_step) {
  htmlDependency(
    name = "customTextBindings",
    version = "1.0.0",
    src = c(file = system.file("chapter5/input-bindings", package = "OSUICode")),
    script = paste0("customTextInputBinding_", binding_step, ".js")
  )
}



#' Update \link{customTextInput} on the client side
#'
#' @param inputId The id of the input object.
#' @param value The value to set for the input object.
#' @param placeholder The placeholder to set for the input object.
#' @param session The session object passed to function given to shiny server.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  # This example corresponds to section 5.4.2.4 (Set and update)
#'  updateCustomTextInputExample(3)
#'  # This example corresponds to section 5.4.2.5 (Subscribe) with
#'  # a missing event listener. The value in the input change but not the one
#'  # displayed by Shiny.
#'  updateCustomTextInputExample(4)
#'
#'  # This example corresponds to section 5.4.2.5 (Subscribe) with an
#'  # extra event listener allowing to properly update the value
#'  updateCustomTextInputExample(5)
#' }
updateCustomTextInput <- function(
  inputId,
  value = NULL,
  placeholder = NULL,
  session = getDefaultReactiveDomain())
{
  message <- dropNulls(
    list(
      value = value,
      placeholder = placeholder
    )
  )
  session$sendInputMessage(inputId, message)
}



#' Wrapper for Shiny App example
#'
#' @param binding_step Input binding step. See \link{customTextInput}.
#'
#' @return A Shiny App example
#' @export
updateCustomTextInputExample <- function(binding_step) {
  ui <- fluidPage(
    customTextInput(
      "caption",
      "Caption",
      "Data Summary",
      binding_step = binding_step
    ),
    actionButton("update", "Update text!", class = "btn-success"),
    textOutput("custom_text")
  )

  server <- function(input, output, session) {
    output$custom_text <- renderText(input$caption)
    observeEvent(input$update, {
      updateCustomTextInput("caption", value = "new text")
    })
  }
  shinyApp(ui, server)
}
