#' OSUICode dependencies utils
#'
#' @description This function attaches OSUICode dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools tagList htmlDependency
#' @export
add_OSUICode_deps <- function(tag) {
  OSUICode_deps <- htmlDependency(
  name = "OSUICode",
  version = "0.0.0.9000",
  src = c(file = "OSUICode-0.0.0.9000"),
  script = "js/OSUICode.js",
  package = "OSUICode",
 )
 tagList(tag, OSUICode_deps)
}

