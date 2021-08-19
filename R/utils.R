print_function_code <- function(con) {
  cat("### APP CODE ### \n", paste0(readLines(con), collapse = "\n"), "\n", sep = "")
}


#' Wrapper for running shiny app example
#'
#' Similar to shiny::shinyAppDir
#'
#' @param path App location.
#' @export
#' @examples
#' if (interactive()) {
#'  run_example("dj-system")
#' }
run_example <- function(path) {
  shinyAppDir(system.file(path, package = "OSUICode"))
}

#' Run Shiny app example
#'
#' @param path App location.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  get_example("dj-system")
#' }
get_example <- function(path) {
  list(
    app = cat(
      paste0(
        "### RUN ### \n",
        "# OSUICode::run_example( \n",
        "#  \"", path, "\" \n",
        "# ) \n",
        "\n",
        collapse = "\n"
      ),
      sep = ""
    ),
    code = print_function_code(
      file.path(
        system.file(path, package = "OSUICode"),
        "app.R"
      )
    )
  )
}


