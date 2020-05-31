# Tabler dependencies
tablers_deps <- htmlDependency(
  name = "tabler",
  version = "1.0.7", # we take that of tabler,
  src = c(href = "https://cdn.jsdelivr.net/npm/tabler@1.0.0-alpha.7/dist/"),
  script = "js/tabler.min.js",
  stylesheet = "css/tabler.min.css"
)

# Bootstrap 4 dependencies
bs4_deps <- htmlDependency(
  name = "Bootstrap",
  version = "4.3.1",
  src = c(href = "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/"),
  script = "bootstrap.bundle.min.js"
)

# jQUery dependencies. Since Shiny already has 3.4.1, this is not mandatory
jQuery_deps <- htmlDependency(
  name = "jquery",
  version = "3.5.0",
  src = c(href = "https://code.jquery.com/"),
  script = "jquery-3.5.0.slim.min.js"
)


#' Create Tabler dependencies
#'
#' Add all necessary dependencies so that Tabler works
#'
#' @param tag Tag on which to add dependencies. We usually target the body.
#' @export
#' @seealso \link{tabler_page}.
add_tabler_deps <- function(tag) {
  # below, the order is of critical importance!
  deps <- list(bs4_deps, tablers_deps)
  attachDependencies(tag, deps, append = TRUE)
}




#' Create a Tabler HTML page
#'
#' This is the main wrapper
#'
#' @param ... Slot for \link{tabler_body} and \link{tabler_navbar}.
#' @param dark Whether to apply the dark theme. Default to TRUE.
#' @param title Page title.
#' @param favicon Site favicon.
#'
#' @return The Tabler page main wrapper.
#' @export
tabler_page <- function(..., dark = TRUE, title = NULL, favicon = NULL){

  # head
  head_tag <- tags$head(
    tags$meta(charset = "utf-8"),
    tags$meta(
      name = "viewport",
      content = "
        width=device-width,
        initial-scale=1,
        viewport-fit=cover"
    ),
    tags$meta(`http-equiv` = "X-UA-Compatible", content = "ie=edge"),
    tags$title(title),
    tags$link(
      rel = "preconnect",
      href = "https://fonts.gstatic.com/",
      crossorigin = NA
    ),
    tags$meta(name = "msapplication-TileColor", content = "#206bc4"),
    tags$meta(name = "theme-color", content = "#206bc4"),
    tags$meta(name = "apple-mobile-web-app-status-bar-style", content = "black-translucent"),
    tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
    tags$meta(name = "mobile-web-app-capable", content = "yes"),
    tags$meta(name = "HandheldFriendly", content = "True"),
    tags$meta(name = "MobileOptimized", content = "320"),
    tags$meta(name = "robots", content = "noindex,nofollow,noarchive"),
    tags$link(rel = "icon", href = favicon, type = "image/x-icon"),
    tags$link(rel = "shortcut icon", href = favicon, type="image/x-icon")
  )

  # body
  body_tag <- tags$body(
    tags$div(
      class = paste0("antialiased ", if(dark) "theme-dark"),
      style = "display: block;",
      tags$div(class = "page", ...)
    )
  ) %>% add_tabler_deps()

  tagList(head_tag, body_tag)
}



#' Create the Tabler body wrapper
#'
#' @param ... Any Tabler element, especially \link{tabler_tab_items} and
#' \link{tabler_tab_item} if used in combination with \link{tabler_navbar}.
#' @param footer Slot for \link{tabler_footer}.
#'
#' @return An HTML tag containing the page elements.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'
#'  ui <- tabler_page(tabler_body(h1("Hello World")))
#'  server <- function(input, output) {}
#'  shinyApp(ui, server)
#' }
tabler_body <- function(..., footer = NULL) {
  div(
    class = "content",
    div(class = "container-xl", ...),
    tags$footer(class = "footer footer-transparent", footer)
  )
}




#' Create the Tabler footer wrapper
#'
#' @param left Left content.
#' @param right Right content.
#'
#' @return An HTML tag containing the footer elements.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- tabler_page(
#'   tabler_body(
#'     p("Hello World"),
#'     footer = tabler_footer(
#'       left = "Rstats, 2020",
#'       right = a(href = "https://www.google.com", "More")
#'     )
#'   )
#'  )
#'  server <- function(input, output) {}
#'  shinyApp(ui, server)
#' }
tabler_footer <- function(left = NULL, right = NULL) {
  div(
    class = "container",
    div(
      class = "row text-center align-items-center flex-row-reverse",
      div(class = "col-lg-auto ml-lg-auto", right),
      div(class = "col-12 col-lg-auto mt-3 mt-lg-0", left)
    )
  )
}




#' Create the Tabler navbar
#'
#' @param ... Extra elements.
#' @param brand_url Navbar brand url.
#' @param brand_image Navbar brand image.
#' @param nav_menu Slot for \link{tabler_navbar_menu}.
#' @param nav_right Right elements.
#'
#' @return The navbar HTML tag, which drives the template navigation.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'
#'  # example without JS
#'  ui <- tabler_page(
#'   tabler_navbar(
#'     brand_url = "https://preview-dev.tabler.io",
#'     brand_image = "https://preview-dev.tabler.io/static/logo.svg",
#'     nav_menu = tabler_navbar_menu(
#'       tabler_navbar_menu_item(
#'         text = "Tab 1",
#'         icon = NULL,
#'         tabName = "tab1",
#'         selected = TRUE
#'       ),
#'       tabler_navbar_menu_item(
#'         text = "Tab 2",
#'         icon = NULL,
#'         tabName = "tab2"
#'       )
#'     )
#'   ),
#'   tabler_body(
#'     tabler_tab_items(
#'       tabler_tab_item(
#'         tabName = "tab1",
#'         p("Hello World")
#'       ),
#'       tabler_tab_item(
#'         tabName = "tab2",
#'         p("Second Tab")
#'       )
#'     ),
#'     footer = tabler_footer(
#'       left = "Rstats, 2020",
#'       right = a(href = "https://www.google.com")
#'     )
#'   )
#'  )
#'  server <- function(input, output) {}
#'  shinyApp(ui, server)
#'
#'  # example with custom JS code to activate tabs
#'  shinyAppDir(system.file("chapter12/tabler_tabs", package = "OSUICode"))
#' }
tabler_navbar <- function(..., brand_url = NULL, brand_image = NULL, nav_menu, nav_right = NULL) {

  header_tag <- tags$header(class = "navbar navbar-expand-md")
  container_tag <- tags$div(class = "container-xl")

  # toggler for small devices (must not be removed)
  toggler_tag <- tags$button(
    class = "navbar-toggler",
    type = "button",
    `data-toggle` = "collapse",
    `data-target` = "#navbar-menu",
    span(class = "navbar-toggler-icon")
  )

  # brand elements
  brand_tag <- if (!is.null(brand_url) || !is.null(brand_image)) {
    a(
      href = if (!is.null(brand_url)) {
        brand_url
      } else {
        "#"
      },
      class = "navbar-brand navbar-brand-autodark d-none-navbar-horizontal pr-0 pr-md-3",
      if(!is.null(brand_image)) {
        img(
          src = brand_image,
          alt = "brand Image",
          class = "navbar-brand-image"
        )
      }
    )
  }

  dropdown_tag <- if (!is.null(nav_right)) {
    div(class = "navbar-nav flex-row order-md-last", nav_right)
  }

  navmenu_tag <- div(
    class = "collapse navbar-collapse",
    id = "navbar-menu",
    div(
      class = "d-flex flex-column flex-md-row flex-fill align-items-stretch align-items-md-center",
      nav_menu
    ),
    if (length(list(...)) > 0) {
      div(
        class = "ml-md-auto pl-md-4 py-2 py-md-0 mr-md-4 order-first order-md-last flex-grow-1 flex-md-grow-0",
        ...
      )
    }
  )

  container_tag <- container_tag %>% tagAppendChildren(
    toggler_tag,
    brand_tag,
    dropdown_tag,
    navmenu_tag
  )

  header_tag %>% tagAppendChild(container_tag)

}



#' Create the Tabler navbar menu
#'
#' @param ... Slot for \link{tabler_navbar_menu_item}.
#' @export
tabler_navbar_menu <- function(...) {
  tags$ul(class = "nav nav-pills navbar-nav", ...)
}



#' Create a tabler navbar menu item
#'
#' This item is used to navigate. Must match with the
#' \link{tabler_tab_item} function.
#'
#' @param text Item title.
#' @param tabName Unique tab name. Must exactly match with the
#' tabName parameter of \link{tabler_tab_item} on the body side.
#' @param icon Item icon.
#' @param selected Whether to select the current item at start.
#'
#' @return A Tabler navigation item tag.
#' @export
tabler_navbar_menu_item <- function(text, tabName, icon = NULL, selected = FALSE) {

  item_cl <- paste0("nav-link", if(selected) " active")

  tags$li(
    class = "nav-item",
    a(
      class = item_cl,
      href = paste0("#", tabName),
      `data-toggle` = "pill", # see https://getbootstrap.com/docs/4.0/components/navs/
      `data-value` = tabName,
      role = "tab",
      span(class = "nav-link-icon d-md-none d-lg-inline-block", icon),
      span(class = "nav-link-title", text)
    )
  )
}



#' Create a Tabler body item container
#'
#' @param ... Slot for \link{tabler_tab_item}.
#' @export
tabler_tab_items <- function(...) {
  div(class = "tab-content", ...)
}



#' Create a Tabler body tab item
#'
#' This works with the navbar \link{tabler_navbar_menu_item} function
#'
#' @param tabName Unique tab name.
#' @param ... Tab content.
#' @export
tabler_tab_item <- function(tabName = NULL, ...) {
  div(
    role = "tabpanel",
    class = "tab-pane fade container-fluid",
    id = tabName,
    ...
  )
}



#' Create a row container for \link{tabler_card}
#'
#' @param ... Any Tabler element.
#'
#' @return A row tag.
#' @export
tabler_row <- function(...) {
  div(class = "row row-deck", ...)
}



#' Create a Tabler card element
#'
#' This is to be inserted in \link{tabler_body}.
#'
#' @param ... Card content.
#' @param title Card title.
#' @param status Card status color. Valid statuses are given at
#' \url{https://preview-dev.tabler.io/docs/colors.html}.
#' @param width Card width. Numeric between 1 and 12 according to the
#' Bootstrap 4 grid system.
#' @param padding Card padding. Leave NULL or "sm", "md" and "lg".
#'
#' @return A card tag.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- tabler_page(
#'    tabler_body(
#'      tabler_row(
#'        lapply(
#'         1:2,
#'         tabler_card,
#'         title = "Card",
#'         status = "success",
#'         "My amazing card"
#'        )
#'      )
#'    )
#'  )
#'  server <- function(input, output) {}
#'  shinyApp(ui, server)
#' }
tabler_card <- function(..., title = NULL, status = NULL, width = 6, padding = NULL) {

  card_cl <- paste0(
    "card",
    if (!is.null(padding)) paste0(" card-", padding)
  )

  status_tag <- if (!is.null(status)) {
    div(class = paste0("card-status-top bg-", status))
  }

  body_tag <- div(
    class = "card-body",
    # we could have a smaller title like h4 or h5...
    if (!is.null(title)) {
      h3(class = "card-title", title)
    },
    ...
  )

  main_wrapper <- div(class = paste0("col-md-", width))
  card_wrapper <- div(class = card_cl)

  card_wrapper <- card_wrapper %>% tagAppendChildren(status_tag, body_tag)
  main_wrapper %>% tagAppendChild(card_wrapper)
}



#' Create a Tabler ribbon component
#'
#' This is a good complement to \link{tabler_card}. The ribbon
#' parameters are listed at \url{https://preview-dev.tabler.io/docs/ribbons.html}.
#'
#' @param ... Ribbon text.
#' @param position Ribbon position.
#' @param color Ribbon color.
#' @param bookmark Ribbon style. FALSE by default.
#'
#' @return A ribbon shiny tag.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  my_card <- tabler_card(title = "Ribbon", status = "info")
#'  my_card$children[[1]] <- my_card$children[[1]] %>%
#'  tagAppendChild(
#'    tabler_ribbon(
#'      icon("info-circle", class = "fa-lg"),
#'      bookmark = TRUE,
#'      color = "red"
#'    )
#'  )
#'
#'  ui <- tabler_page(
#'   tabler_body(
#'     my_card
#'   )
#'  )
#'  server <- function(input, output) {}
#'  shinyApp(ui, server)
#' }
tabler_ribbon <- function(..., position = NULL, color = NULL, bookmark = FALSE) {

  ribbon_cl <- paste0(
    "ribbon",
    if (!is.null(position)) sprintf(" bg-%s", position),
    if (!is.null(color)) sprintf(" bg-%s", color),
    if (bookmark) " ribbon-bookmark"
  )
  div(class = ribbon_cl, ...)
}
