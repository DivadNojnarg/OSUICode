#' Default shinyMobile template options
#'
#' @export
shinyMobile_options <- list(
  theme = "auto",
  dark = TRUE,
  filled = FALSE,
  color = "#007aff",
  # TOUCH MODULE OPTIONS
  touch = list(
    tapHold = TRUE,
    tapHoldDelay = 750,
    iosTouchRipple = FALSE
  ),
  iosTranslucentBars = FALSE,
  navbar = list(
    iosCenterTitle = TRUE,
    hideOnPageScroll = TRUE
  ),
  toolbar = list(
    hideOnPageScroll = FALSE
  )
  # remaining options ...
)



#' Mobile page wrapper
#'
#' @param ... Body elements
#' @param navbar Slot for \link{f7_navbar}.
#' @param toolbar Slot for \link{f7_toolbar}.
#' @param title Tab title.
#' @param options Options to configure the template.
#' @param allowPWA Whether to allow PWA. Defaults to TRUE.
#' @export
f7_page <- function(..., navbar, toolbar, title = NULL,
                    options = shinyMobile_options,
                    allowPWA = TRUE) {

  config_tag <- tags$script(
    type = "application/json",
    `data-for` = "app",
    jsonlite::toJSON(
      x = options,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  # create body_tag
  body_tag <- tags$body(
    `data-pwa` = tolower(allowPWA),
    tags$div(
      id = "app",
      tags$div(
        class = "view view-main",
        tags$div(
          class = "page",
          navbar,
          toolbar,
          tags$div(
            class = "page-content",
            ...
          )
        )
      )
    ),
    config_tag
  )

  tagList(
    tags$head(
      tags$meta(charset = "utf-8"),
      tags$meta(
        name = "viewport",
        content = "width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, viewport-fit=cover"
      ),
      tags$meta(
        name = "apple-mobile-web-app-capable",
        content = "yes"
      ),
      tags$meta(
        name = "theme-color",
        content = "#2196f3"
      ),
      tags$title(title)
    ),
    add_dependencies(
      body_tag,
      deps = c(
        "framework7",
        "OSUICode",
        if (allowPWA) c("pwa", "pwacompat")
      )
    )
  )
}


#' Navbar element
#'
#' Include in \link{f7_page}.
#'
#' @param title Navbar title
#' @export
f7_navbar <- function(title) {
  tags$div(
    class = "navbar",
    tags$div(class = "navbar-bg"),
    tags$div(
      class = "navbar-inner",
      tags$div(
        class = "title",
        title
      )
    )
  )
}


#' Toobar element
#'
#' Include in \link{f7_page}.
#'
#' @param ... Content.
#' @export
f7_toolbar <- function(...) {
  tags$div(
    class = "toolbar toolbar-bottom",
    tags$div(
      class = "toolbar-inner",
      ...
    )
  )
}




#' Gauge widget
#'
#' @param id Gauge unique id. Needed by \link{update_f7_instance}.
#' @param value Gauge value.
#' @param options Gauge options. Pass a list.
#' @export
#' @examples
#' if (interactive()) {
#'  shiny::shinyAppDir(system.file("shinyMobile/pwa", package = "OSUICode"))
#' }
f7_gauge <- function(id, value, options = NULL) {

  if (is.null(options[["valueText"]])) options[["valueText"]] <- paste(value * 100, "%")

  gaugeProps <- c(list(value = value), options)

  gaugeConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = gaugeProps,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  shiny::tags$div(
    class = "gauge",
    id = id,
    gaugeConfig
  )
}



#' Notification widget
#'
#' @param id Notification unique id. Needed by \link{update_f7_instance}.
#' @param text Notification text.
#' @param options List of options.
#' @param session Shiny session object.
#' @export
#' @examples
#' if (interactive()) {
#'  shiny::shinyAppDir(system.file("shinyMobile/notification", package = "OSUICode"))
#' }
f7_notif <- function(id = NULL, text, options = NULL, session = shiny::getDefaultReactiveDomain()) {

  if (!is.null(options$icon)) options$icon <- as.character(options$icon)

  message <- c(dropNulls(list(id = id, text = text)), options)
  # see my-app.js function
  send_custom_message("notification", message, session)

}



#' Update any UI widget on the server
#'
#' @param id Widget id.
#' @param options New configuration list.
#' @param session Shiny session object.
#' @export
#' @examples
#' if (interactive()) {
#'  shiny::shinyAppDir(system.file("shinyMobile/pwa", package = "OSUICode"))
#' }
update_f7_instance <- function(id, options, session = shiny::getDefaultReactiveDomain()) {

  # Convert any shiny tag into character so that toJSON does not cry
  listRenderTags <- function(l) {
    lapply(
      X = l,
      function(x) {
        if (inherits(x, c("shiny.tag", "shiny.tag.list"))) {
          as.character(x)
        } else if (inherits(x, "list")) {
          # Recursive part
          listRenderTags(x)
        } else {
          x
        }
      }
    )
  }
  options <- listRenderTags(options)

  message <- list(id = id, options = options)
  send_custom_message("update-instance", message, session)
}



validate_selector <- function(id, selector) {
  if (!is.null(id) && !is.null(selector)) {
    stop("Please choose either target or selector!")
  }
}

"%OR%" <- function(a, b) if (!is.null(a)) a else b



#' Create a tooltip on the server side
#'
#' @param id Target id.
#' @param selector Target selector.
#' @param options Tooltip options
#' @param session Shiny session object
#' @export
add_f7_tooltip <- function(
  id = NULL,
  selector = NULL,
  options,
  session = shiny::getDefaultReactiveDomain()
) {
  # We use already defined popover functions
  validate_selector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  options$targetEl <- id %OR% selector
  send_custom_message("add_tooltip", options, session)
}



#' Update/toggle tooltip on server side
#'
#' @param id Tooltip id.
#' @param selector Tooltip selector.
#' @param action Action to perform: toggle or update.
#' @param text New text if action is update.
#' @param session Shiny session object.
#' @export
update_f7_tooltip <- function(
  id = NULL,
  selector = NULL,
  action = c("toggle", "update"),
  text = NULL,
  session = shiny::getDefaultReactiveDomain()
) {
  validate_selector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  message <- dropNulls(
    list(
      targetEl = targetEl,
      action = action,
      text = text
    )
  )
  send_custom_message("update_tooltip", message, session)
}
