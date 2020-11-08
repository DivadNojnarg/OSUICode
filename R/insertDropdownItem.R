dropdownDeps <- function() {
  htmltools::htmlDependency(
    name = "bs4-dropdown",
    version = "1.0.0",
    src = c(file = "chapter6/add-dropdown-item"),
    script = "add-dropdown-item.js",
    package = "OSUICode"
  )
}



#' Insert Bootstrap 4 dropdown menu item
#'
#' @param item Item to insert.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  shinyAppDir(system.file("chapter6/add-dropdown-item", package = "OSUICode"))
#' }
insertDropdownItem <- function(item, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("add-dropdown-item", message = as.character(item))
}


#' Create a Boostrap 4 dashboard dropdown menu
#'
#' Build an adminLTE3 dashboard dropdown menu
#'
#' @param ... Slot for \link[bs4Dash]{dropdownMenuItem}.
#' @param show Whether to start with the dropdown open. FALSE by default.
#' @param status Dropdown menu status. "primary", "success", "warning", "danger" or "info".
#' @param labelText Dropdown label text.
#' @param src Dropdown link to an external ressource.
#' @param menuIcon Fontawesome icon (default = "bell")
#' @param align Menu alignment (default = "right")
#' @export
dropdownMenu <- function(..., show = FALSE, labelText = NULL, src = NULL,
                         status = c("primary", "warning", "danger", "info", "success"),
                         menuIcon = "bell", align = "right") {

  status <- match.arg(status)
  items <- list(...)
  n_items <- length(items)
  # remove the divider from the last item
  #items[[n_items]][[2]] <- NULL

  labelText <- n_items

  tagList(
    dropdownDeps(),
    shiny::tags$li(
      class = if (isTRUE(show)) "nav-item dropdown show" else "nav-item dropdown",
      shiny::tags$a(
        class = "nav-link",
        `data-toggle` = "dropdown",
        href = "#",
        shiny::icon(menuIcon),
        shiny::tags$span(
          class = paste0("badge badge-", status, " navbar-badge"),
          labelText
        )
      ),
      shiny::tags$div(
        class = if (isTRUE(show)) {
          sprintf("dropdown-menu dropdown-menu-lg dropdown-menu-%s show", align)
        } else {
          sprintf("dropdown-menu dropdown-menu-lg dropdown-menu-%s", align)
        },
        shiny::tags$span(
          class = "dropdown-item dropdown-header",
          paste0(n_items, " Items")
        ),
        shiny::tags$div(class = "dropdown-divider"),
        ...,
        shiny::tags$a(
          class = "dropdown-item dropdown-footer",
          href = src,
          target = "_blank",
          "See more"
        )
      )
    )
  )
}
