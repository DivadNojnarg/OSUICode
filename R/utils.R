# Print function code
print_function_code <- function(con) {
  cat("### APP CODE ### \n", paste0(readLines(con), collapse = "\n"), "\n", sep = "")
}


#' Wrapper for running shiny app example
#'
#' Similar to shiny::shinyAppDir
#'
#' @param path App location.
#' @param package Where to take the example from. Default
#' to current package.
#' @export
#' @examples
#' if (interactive()) {
#'  run_example("dj-system")
#' }
run_example <- function(path, package = "OSUICode") {
  shinyAppDir(system.file(path, package = package))
}

#' Run Shiny app example
#'
#' @param path App location.
#' @param view_code Whether to print the app code.
#' TRUE if document is HTML output, FALSE otherwise.
#' @param package Where to take the example from. Default
#' to current package.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  get_example("dj-system")
#' }
get_example <- function(path, view_code = knitr::is_html_output(),
                        package = "OSUICode") {
  cat(
    cat(
      paste0(
        "### RUN ### \n",
        "# OSUICode::run_example( \n",
        "#  \"", path, "\", \n",
        "#   package = \"", package, "\" \n",
        "# ) \n",
        if (view_code) "\n",
        collapse = "\n"
      ),
      sep = ""
    ),
    if (view_code) {
      print_function_code(
        file.path(
          system.file(path, package = package),
          "app.R"
        )
      )
    }
  )
}


