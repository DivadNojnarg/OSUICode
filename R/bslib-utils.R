#' Bootstrap 4 toggle input
#'
#' A Bootstrap 4 toggle input similar to a checkbox
#'
#' @export
theme_toggle <- function() {
  div(
    class = "custom-control custom-switch",
    tags$input(
      id = "custom_mode",
      type = "checkbox",
      class = "custom-control-input",
      onclick = HTML(
        "Shiny.setInputValue(
          'dark_mode',
          document.getElementById('custom_mode').value
        );"
      )
    ),
    tags$label(
      "Custom mode?",
      `for` = "custom_mode",
      class = "custom-control-label"
    )
  )
}



#' Custom card component
#'
#' @param ... Card content.
#' @export
super_card <- function(...) {
  div(
    class = "supercard",
    div(class = "supercard_body", ...),
    bslib::bs_dependency_defer(super_card_dependency)
  )
}


super_card_dependency <- function(theme) {

  sass_str <- "
    .supercard {
      box-shadow: 0 4px 10px 0 rgb(0, 0, 0), 0 4px 20px 0
      rgb(0, 0, 0);
      width: 50%;
      height: 200px;

      background-color: $primary;
      .supercard_body {
        padding: 0.01em 16px;
      }
    }
  "

  dep_name <- "supercard"
  dep_version <- "1.0.0"

  if (bslib::is_bs_theme(theme)) {
    bslib::bs_dependency(
      input = sass_str,
      theme = theme,
      name = dep_name,
      version = dep_version
    )
  } else {
    htmlDependency(
      name = dep_name,
      version = dep_version,
      src = "supercard-1.0.0/css",
      stylesheet = "super-card.css",
      package = "OSUICode"
    )
  }
}

#' Neon theme for bslib demo apps
#'
#' @export
bslib_neon_theme <- bslib::bs_theme(
  bg = "#000000",
  fg = "#FFFFFF",
  primary = "#9600FF",
  secondary = "#1900A0",
  success = "#38FF12",
  info = "#00F5FB",
  warning = "#FFF100",
  danger = "#FF00E3",
  base_font = "Marker Felt",
  heading_font = "Marker Felt",
  code_font = "Chalkduster"
)

#' Dark theme for bslib demo apps
#'
#' @export
bslib_dark_theme <- bslib::bs_theme() %>%
  bslib::bs_theme_update(
    bg = "black",
    fg = "white",
    primary = "orange"
  )
