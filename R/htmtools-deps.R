#' Simple BS4 card without dependencies
#'
#' This card is missing dependencies
#'
#' @param ... Card content
#'
#' @return An HTML card
#' @export
my_card <- function(...) {
  withTags(
    div(
      class = "card border-success mb-3",
      div(class = "card-header bg-transparent border-success"),
      div(
        class = "card-body text-success",
        h3(class = "card-title", "title"),
        p(class = "card-text", ...)
      ),
      div(
        class = "card-footer bg-transparent border-success",
        "footer"
      )
    )
  )
}


bs4_cdn <- "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/"
bs4_card_dep <- function() {
  htmlDependency(
    name = "bs4_card",
    version = "1.0",
    src = c(href = bs4_cdn),
    stylesheet = "css/bootstrap.min.css"
  )
}


#' Simple BS4 Card with dependencies
#'
#' @inheritParams my_card
#'
#' @return An HTML card
#' @export
my_card_with_deps <- function(...) {
  cardTag <- my_card(...)
  # attach dependencies (old way)
  # htmltools::attachDependencies(cardTag, bs4_card_dep())

  # simpler way
  tagList(cardTag, bs4_card_dep())

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
