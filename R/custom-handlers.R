#' Function demonstrating the use of Shiny custom message handlers
#'
#' Send a message from R to JavaScript every 5 seconds.
#' The JS answer is an alert containing the message sent by R.
#'
#' @param text Message to send.
#' @param session Shiny session object.
#' @export
say_hello_to_js <- function(text, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage(type = 'say-hello', message = text)
}

#' JS script to run the pokemon app
#'
#' @export
pokemonDeps <- function() {
  htmlDependency(
    name = "pokemon",
    version = "1.0.0",
    src = c(file = "pokemon-1.0.0"),
    script = "pokemons-handlers.js",
    package = "OSUICode"
  )
}



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

#' @inheritParams shinydashboard::dropdownMenu
#' @param href Link target.
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

#' User image from dropdownMenu items
#'
#' @export
dashboardUserImage <- "https://adminlte.io/themes/v3/dist/img/user2-160x160.jpg"

#' Generate dashboard UI for dropdownMenu example
#'
#' @export
dropdownMenuUI <- function() {
  bs4Dash::dashboardPage(
    dark = FALSE,
    header = bs4Dash::dashboardHeader(
      rightUi = OSUICode::dropdownMenu(
        badgeStatus = "danger",
        type = "messages"
      )
    ),
    sidebar = bs4Dash::dashboardSidebar(),
    controlbar = bs4Dash::dashboardControlbar(),
    footer = bs4Dash::dashboardFooter(),
    title = "test",
    body = bs4Dash::dashboardBody(actionButton("add", "Add dropdown item"))
  )
}
