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
#'  get_example("dj-system")
#' }
get_example <- function(path) {
  list(
    app = cat(
      paste0(
        "### RUN ### \n",
        "# shiny::shinyAppDir( \n",
        "# system.file( \n",
        "#  \"", path, "\", \n",
        "#  package = \"OSUICode\" \n",
        "# ) \n",
        "#) \n",
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


