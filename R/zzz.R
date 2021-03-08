#' Register custom handler for text date and Add resources for tabler
#'
#' @importFrom shiny registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(...) {
  addResourcePath("tabler", system.file("tabler", package = "OSUICode"))

  registerInputHandler("OSUICode.textDate", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      res <- try(as.Date(unlist(data)), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse dates!")
        # as.Date(NA)
        data
      } else {
        res
      }
    }
  }, force = TRUE)

  registerInputHandler("OSUICode.textNumber", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      res <- as.numeric(unlist(data))
      if (is.na(res)) {
        warning("Failed to parse number!")
        # as.Date(NA)
        data
      } else {
        res
      }
    }
  }, force = TRUE)
}
