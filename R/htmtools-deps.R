#' Simple Material Bootstrap card without dependencies
#'
#' This card is missing dependencies
#'
#' @param ... Card content
#'
#' @return An HTML card
#' @export
my_card <- function(...) {
  withTags(
    tags$div(
      class = "card",
      tags$div(
        class = "card-body",
        tags$h5(class = "card-title", "Card title"),
        tags$p(class = "card-text", "Card content"),
        tags$button(
          type = "button",
          class = "btn btn-primary",
          "Button"
        )
      )
    )
  )
}


mdb_cdn <- "https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.6.0/"
mdb_card_dep <- function() {
  htmlDependency(
    name = "mdb-card",
    version = "1.0",
    src = c(href = mdb_cdn),
    stylesheet = "mdb.min.css"
  )
}


#' Simple Material Bootstrap card with dependencies
#'
#' @inheritParams my_card
#'
#' @return An HTML card
#' @export
my_card_with_deps <- function(...) {
  cardTag <- my_card(...)
  # attach dependencies (old way)
  # htmltools::attachDependencies(cardTag, mdb_card_dep())

  # simpler way
  tagList(cardTag, mdb_card_dep())

}


# Get shinydashboard deps
dashboard_ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(),
  shinydashboard::dashboardSidebar(),
  shinydashboard::dashboardBody()
)
dashboard_deps <- findDependencies(dashboard_ui)


#' Standalone shinydashboard box
#'
#' box from shinydashboard you can use inside
#' a basic shiny app.
#'
#' @param title Box title.
#' @param status Box color.
#'
#' @return A box HTML tag.
#' @export
my_dashboard_box <- function(title, status) {
  tagList(
    shinydashboard::box(title = title, status = status),
    dashboard_deps
  )
}
