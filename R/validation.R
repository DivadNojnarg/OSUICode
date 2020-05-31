#' Validation function
#'
#' Validate a Tabler element width like \link{tabler_card}.
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



valid_statuses <- c(
  "primary",
  "secondary",
  "success",
  "info",
  "warning",
  "danger",
  "light",
  "dark"
)

#' Validation function
#'
#' Validate the status of a Tabler element like \link{tabler_card}.
#'
#' @param status Color to validate.
#'
#' @return TRUE if the test pass.
#' @export
#'
#' @examples
#' validate_status("danger")
#' validate_status("maroon")
validate_status <- function(status) {

  if (is.null(status)) {
    return(TRUE)
  } else {
    if (status %in% valid_statuses) {
      return(TRUE)
    }
  }

  stop("Invalid status: ", status, ". Valid statuses are: ",
       paste(valid_statuses, collapse = ", "), ".")
}




valid_paddings <- c("sm", "md", "lg")

#' Validation function
#'
#' Validate a Tabler card padding. See \link{tabler_card}
#' for more informations.
#'
#' @param padding Padding value to validate.
#'
#' @return An error is raised if the input padding is not valid.
#' @export
#'
#' @examples
#' validate_padding("xs")
#' validate_padding("sm")
validate_padding <- function(padding) {
  if (!is.null(padding)) {
    if (!(padding %in% valid_paddings)) {
      stop("Invalid status: ", padding, ". Valid choices are: ",
           paste(valid_paddings, collapse = ", "), ".")
    }
  }
}
