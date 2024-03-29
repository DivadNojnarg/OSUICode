shinyInputLabel <- function(inputId, label = NULL) {
  tags$label(label, class = "control-label", class = if (is.null(label)) {
    "shiny-label-null"
  }, `for` = inputId)
}


#' Attach all created dependencies in the ./R directory to the provided tag
#'
#' This function only works if there are existing dependencies. Otherwise,
#' an error is raised.
#'
#' @param tag Tag to attach the dependencies.
#' @param deps Dependencies to add. Expect a vector of names.
#' If NULL, all dependencies are added.
#' @export
#'
#' @examples
#' \dontrun{
#'  library(htmltools)
#'  findDependencies(add_dependencies(div()))
#'  findDependencies(add_dependencies(div(), deps = "bulma"))
#' }
add_dependencies <- function(tag, deps = NULL) {
  if (is.null(deps)) {
    temp_names <- list.files("./R", pattern = "dependencies.R$")
    deps <- unlist(lapply(temp_names, strsplit, split = "-dependencies.R"))
  }

  if (length(deps) == 0) stop("No dependencies found.")

  deps <- lapply(deps, function(x) {
    dep <- eval(
      parse(
        text = sprintf("htmltools::findDependencies(add_%s_deps(htmltools::div()))", x)
      )
    )
    dep
  })
  # flatten list by one level
  deps <- unlist(deps, recursive = FALSE)

  htmltools::tagList(tag, deps)
}


#' Remove NULL list elements
#'
#' @param x list from which to drop NULL elements.
#' @export
dropNulls <- function (x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}
