print_function_code <- function(con) {
  cat("### APP CODE ### \n", paste0(readLines(con), collapse = "\n"), "\n")
}


#' Run Shiny app example
#'
#' @param path App location.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  run_example("dj-system")
#' }
run_example <- function(path) {
  list(
    app =  cat(
      "### RUN ###: \n",
      paste0(
        "shiny::shinyAppDir(system.file(\"",
        path,
        "\", package = \"OSUICode\"))"
      ),
      "\n \n"
    ),
    code = print_function_code(
      file.path(
        system.file(path, package = "OSUICode"),
        "app.R"
      )
    )
  )
}


