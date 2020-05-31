#' Adds resource path for tabler
#' @noRd
#'
.onLoad <- function(...) {
  addResourcePath("tabler", system.file("tabler", package = "OSUICode"))
}
