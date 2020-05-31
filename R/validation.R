#' Validation function
#'
#' Validate a Tabler element width.
#'
#' @param width Value to validate.
#'
#' @return An error is raised if conditions are not met
#' @export
#'
#' @examples
#' validate_width(-1)
#' validate_width(13)
#' validate_width("string")
validate_width <- function(width) {
  if (is.numeric(width)) {
    if (width < 1 || width > 12) {
      stop("width must belong to [1, 12], as per Bootstrap 4 grid documentation. See more at https://getbootstrap.com/docs/4.0/layout/grid/")
    }
  } else {
    stop("width must be numeric")
  }
}
