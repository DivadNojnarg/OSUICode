dropdownDeps <- function() {
  htmltools::htmlDependency(
    name = "bs4-dropdown",
    version = "1.0.0",
    src = c(file = "custom-handlers/add-message-item"),
    script = "add-message-item.js",
    package = "OSUICode"
  )
}



#' Insert Bootstrap 4 dropdown menu item
#'
#' @param item Item to insert.
#' @param session Shiny session object.
#' @rdname insertMessageItem
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  shinyAppDir(system.file("custom-handlers/add-message-item", package = "OSUICode"))
#' }
insertMessageItem <- function(item, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("add-message-item", message = as.character(item))
}


#' @rdname insertMessageItem
#' @export
dropdownMenu <- function(..., type = c("messages", "notifications", "tasks"),
                         badgeStatus = "primary", icon = NULL, headerText = NULL,
                         .list = NULL, href = NULL) {
  type <- match.arg(type)
  if (!is.null(badgeStatus)) validate_status(badgeStatus)
  items <- c(list(...), .list)

  # Make sure the items are a tags
  # lapply(items, tagAssert, type = "a", class = "dropdown-item")

  if (is.null(icon)) {
    icon <- switch(
      type,
      messages = shiny::icon("comments"),
      notifications = shiny::icon("bell"),
      tasks = shiny::icon("tasks")
    )
  }

  numItems <- length(items)

  if (is.null(badgeStatus)) {
    badge <- NULL
  } else {
    badge <- shiny::span(class = paste0("badge badge-", badgeStatus, " navbar-badge"), numItems)
  }

  if (is.null(headerText)) {
    headerText <- paste("You have", numItems, type)
  }

  shiny::tags$li(
    dropdownDeps(),
    class = "nav-item dropdown",
    shiny::tags$a(
      class = "nav-link",
      `data-toggle` = "dropdown",
      href = "#",
      `aria-expanded` = "false",
      icon,
      badge
    ),
    shiny::tags$div(
      class = sprintf("dropdown-menu dropdown-menu-lg"),
      shiny::tags$span(
        class = "dropdown-item dropdown-header",
        headerText
      ),
      shiny::tags$div(class = "dropdown-divider"),
      items,
      if (!is.null(href)) {
        shiny::tags$a(
          class = "dropdown-item dropdown-footer",
          href = href,
          target = "_blank",
          "More"
        )
      }
    )
  )
}
