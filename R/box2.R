box2Deps <- function() {
  htmlDependency(
    name = "boxBinding",
    version = "1.0.0",
    src = c(file = system.file("chapter5/input-bindings", package = "OSUICode")),
    script = "boxBinding.js"
  )
}


#' Create a custom shinydashboard box with interactive capabilities
#'
#' @param inputId Box unique id. \link{updateBox2} target.
#' @inheritParams shinydashboard::box
#' @export
box2 <- function(..., inputId = NULL, title = NULL, footer = NULL,
                 background = NULL, width = 6, height = NULL,
                 collapsible = FALSE, collapsed = FALSE) {
  boxClass <- "box"
  if (collapsible && collapsed) {
    boxClass <- paste(boxClass, "collapsed-box")
  }

  if (!is.null(background)) {
    boxClass <- paste0(boxClass, " bg-", background)
  }

  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", validateCssUnit(height))
  }

  titleTag <- NULL
  if (!is.null(title)) {
    titleTag <- h3(class = "box-title", title)
  }

  collapseTag <- NULL
  if (collapsible) {
    buttonStatus <- "default"
    collapseIcon <- if (collapsed) {
      "plus"
    } else {
      "minus"
    }
    collapseTag <- div(class = "box-tools pull-right", tags$button(
      class = paste0("btn btn-box-tool"),
      `data-widget` = "collapse", shiny::icon(collapseIcon)
    ))
  }

  headerTag <- NULL
  if (!is.null(titleTag) || !is.null(collapseTag)) {
    headerTag <- div(class = "box-header", titleTag, collapseTag)
  }

  tagList(
    box2Deps(),
    div(
      class = if (!is.null(width)) paste0("col-sm-", width),
      div(
        id = inputId,
        class = boxClass,
        style = if (!is.null(style)) {
          style
        },
        headerTag,
        div(class = "box-body", ...),
        if (!is.null(footer)) div(class = "box-footer", footer)
      )
    )
  )
}


#' Collapse a \link{box2} tag.
#'
#' @param inputId Box to toggle.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyWidgets)
#'
#'  ui <- fluidPage(
#'   # import shinydashboard deps without the need of the dashboard
#'   # template
#'   useShinydashboard(),
#'
#'   tags$style("body { background-color: ghostwhite};"),
#'
#'   br(),
#'   box2(
#'    title = textOutput("box_state"),
#'    "Box body",
#'    inputId = "mybox",
#'    collapsible = TRUE,
#'    plotOutput("plot")
#'   ),
#'   actionButton("toggle_box", "Toggle Box", class = "bg-success")
#'  )
#'
#'  server <- function(input, output, session) {
#'   output$plot <- renderPlot({
#'     req(!input$mybox$collapsed)
#'     plot(rnorm(200))
#'   })
#'
#'   output$box_state <- renderText({
#'     state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
#'     paste("My box is", state)
#'   })
#'
#'   observeEvent(input$toggle_box, {
#'     updateBox2("mybox")
#'   })
#'
#'  }
#'
#'  shinyApp(ui, server)
#'
#' }
updateBox2 <- function(inputId, session = getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, message = NULL)
}
