#' Box JS dependencies
#'
#' Provide basic binding to toggle the box
#' on the client
#'
#' @export
boxDeps <- function() {
  htmlDependency(
    name = "boxBinding",
    version = "1.0.0",
    src = c(file = system.file("input-system/input-bindings", package = "OSUICode")),
    script = "boxBinding.js"
  )
}

#' Enhanced Box JS dependencies
#'
#' Provide enhanced binding to toggle and update some
#' box properties on the client (title en width).
#'
#' @export
box2Deps <- function() {
  htmlDependency(
    name = "boxBinding",
    version = "1.0.0",
    src = c(file = system.file("input-system/input-bindings", package = "OSUICode")),
    script = "boxBindingEnhanced.js"
  )
}



#' Create a custom shinydashboard box with interactive capabilities
#'
#' @param id Box unique id. \link{updateBox2} target.
#' @inheritParams shinydashboard::box
#' @export
box <- function(..., id = NULL, title = NULL, footer = NULL,
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
        id = id,
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


#' Create a custom shinydashboard box with interactive capabilities
#'
#' @param id Box unique id. \link{updateBox2} target.
#' @inheritParams shinydashboard::box
#' @export
box2 <- function(..., id = NULL, title = NULL, footer = NULL,
                 background = NULL, width = 6, height = NULL,
                 collapsible = FALSE, collapsed = FALSE) {

  if (!is.null(title)) {
    processed_title <- if (
      inherits(title, "shiny.tag.list") ||
      inherits(title, "shiny.tag")
    ) {
      as.character(title)
    } else {
      title
    }
  }

  props <- dropNulls(
    list(
      title = processed_title,
      background = background,
      width = width
    )
  )

  # this will make our props accessible from JS
  configTag <- tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = props,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  boxTag <- tagQuery(
    box(
      ..., id = id, title = title, footer = footer,
      background = background, width = width, height = height,
      collapsible = collapsible, collapsed = collapsed
    )
  )$
    append(configTag)$
    allTags()

  tagList(box2Deps(), boxTag)
}



#' Collapse a \link{box2} tag.
#'
#' @param id Box to toggle.
#' @param session Shiny session object.
#' @export
updateBox <- function(
  id,
  session = getDefaultReactiveDomain()
) {
  session$sendInputMessage(id, message = NULL)
}


#' Update a \link{box2} tag.
#'
#' @inheritParams shinydashboardPlus::updateBox
#' @export
updateBox2 <- function(id, action = c("toggle", "update"),
                       options = NULL, session = getDefaultReactiveDomain()) {
  # for update, we take a list of options
  if (action == "update") {
    # handle case where options are shiny tag
    # or a list of tags ...
    options <- lapply(options, function(o) {
      if (inherits(o, "shiny.tag") ||
          inherits(o, "shiny.tag.list")) {
        o <- as.character(o)
      }
      o
    })
    message <- dropNulls(c(action = action, options = list(options)))
    session$sendInputMessage(id, message)
  } else if (message == "toggle") {
    session$sendInputMessage(id, message = match.arg(action))
  }
}
