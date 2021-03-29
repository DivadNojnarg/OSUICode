#' Introduction app to HTML, CSS and JS for Shiny
#'
#' @return A shiny app example
#' @export
run_dj_app <- function() {
  shinyAppDir(system.file("dj-system", package = "OSUICode"))
}
