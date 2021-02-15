# Tabler dependencies
tablers_deps <- htmlDependency(
  name = "tabler",
  version = "1.0.7", # we take that of tabler,
  src = c(href = "https://cdn.jsdelivr.net/npm/tabler@1.0.0-alpha.7/dist/"),
  script = "js/tabler.min.js",
  stylesheet = "css/tabler.min.css"
)

# contains bindings and other JS code
tabler_custom_js <- htmlDependency(
  name = "tabler-bindings",
  version = "1.0.7",
  src = c(href = "tabler"),
  package = "OSUICode",
  script = c(
    "input-bindings/navbarMenuBinding.js",
    "tabler_progress_handler.js",
    "tabler_toast_handler.js",
    "tabler_dropdown_handler.js",
    "tabler_insert_tab_handler.js"
  )
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
  deps <- list(bs4_deps, tablers_deps, tabler_custom_js)
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
#' @param inputId Optional: used to recover the currently selected tab item.
#' @export
tabler_navbar_menu <- function(..., inputId = NULL) {
  tags$ul(id = inputId, class = "nav nav-pills navbar-nav", ...)
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
      `data-toggle` = "pill", # see https://getbootstrap.com/docs/4.0/components/navs/
      `data-target` = paste0("#", tabName),
      `data-value` = tabName,
      href = "#",
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



#' Update the currently selected \link{tabler_navbar_menu_item} on the client
#'
#' @param inputId \link{tabler_navbar_menu} id.
#' @param value New target.
#' @param session Shiny session.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  # example with input binding: inputId is required for tabler_navbar_menu!!!
#'  ui <- tabler_page(
#'   tabler_navbar(
#'     brand_url = "https://preview-dev.tabler.io",
#'     brand_image = "https://preview-dev.tabler.io/static/logo.svg",
#'     nav_menu = tabler_navbar_menu(
#'       id = "current_tab",
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
#'     ),
#'     tabler_button("update", "Change tab", icon = icon("exchange-alt"))
#'   ),
#'   tabler_body(
#'     tabler_tab_items(
#'       tabler_tab_item(
#'         tabName = "tab1",
#'         sliderInput(
#'           "obs",
#'           "Number of observations:",
#'           min = 0,
#'           max = 1000,
#'           value = 500
#'         ),
#'         plotOutput("distPlot")
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
#'  server <- function(input, output, session) {
#'    output$distPlot <- renderPlot({
#'      hist(rnorm(input$obs))
#'    })
#'
#'    observeEvent(input$current_tab, {
#'      showNotification(
#'        paste("Hello", input$current_tab),
#'        type = "message",
#'        duration = 1
#'      )
#'    })
#'
#'    observeEvent(input$update, {
#'      newTab <- if (input$current_tab == "tab1") "tab2" else "tab1"
#'      update_tabler_tab_item("current_tab", newTab)
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
update_tabler_tab_item <- function(inputId, value, session = getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, message = value)
}



#' Run the update_tabler_tab_item example
#'
#' @return A shiny app
#' @export
update_tabler_navbar_example <- function() {
  shinyAppDir(system.file('tabler/input-bindings', package='OSUICode'))
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




#' Custom Tabler action button
#'
#' @inheritParams shiny::actionButton
#' @param status Button color.
#' @return A Tabler action button tag.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- tabler_page(
#'   tabler_body(
#'     tabler_button(
#'       "btn",
#'       HTML(paste("Value", textOutput("val"), sep = ":")),
#'       icon = icon("thumbs-up"),
#'       width = "25%"
#'     )
#'   )
#'  )
#'
#'  server <- function(input, output) {
#'    output$val <- renderText(input$btn)
#'  }
#'
#'  shinyApp(ui, server)
#' }
tabler_button <- function(inputId, label, status = NULL, icon = NULL, width = NULL, ...) {

  btn_cl <- paste0(
    "btn action-button",
    if (is.null(status)) {
      " btn-primary"
    } else {
      paste0(" btn-", status)
    }
  )

  value <- restoreInput(id = inputId, default = NULL)

  # custom right margin
  if (!is.null(icon)) icon$attribs$class <- paste0(
    icon$attribs$class, " mr-1"
  )

  tags$button(
    id = inputId,
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    type = "button",
    class = btn_cl,
    `data-val` = value,
    list(icon, label), ...
  )
}



#' Custom Tabler switch input
#'
#' Similar to the shiny checkbox
#'
#' @inheritParams shiny::checkboxInput
#'
#' @return A toggle input tag.
#' @export
#' @seealso \link{update_tabler_switch}.
tabler_switch <- function(inputId, label, value = FALSE, width = NULL) {

  value <- restoreInput(id = inputId, default = value)
  input_tag <- tags$input(
    id = inputId,
    type = "checkbox",
    class = "form-check-input"
  )

  if (!is.null(value) && value) {
    input_tag <- input_tag %>% tagAppendAttributes(checked = "checked")
  }

  input_wrapper <- tags$label(
    class = "form-check form-switch",
    style = if (!is.null(width)) {
      paste0("width: ", validateCssUnit(width), ";")
    }
  )

  input_wrapper %>% tagAppendChildren(
    input_tag,
    span(class = "form-check-label", label)
  )
}




#' Update \link{tabler_switch} on the client
#'
#' @inheritParams shiny::updateCheckboxInput
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- tabler_page(
#'   tabler_body(
#'     tabler_row(
#'       tabler_button("update", "Go!", width = "25%", class = "mr-2"),
#'       tabler_switch("toggle", "Switch", value = TRUE, width = "25%")
#'     )
#'   )
#'  )
#'
#'  server <- function(input, output, session) {
#'    observe(print(input$toggle))
#'    observeEvent(input$update, {
#'      update_tabler_switch(
#'        session,
#'        "toggle",
#'        value = !input$toggle
#'      )
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#' }
update_tabler_switch <- function (session, inputId, label = NULL, value = NULL) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}




#' Create a Tabler progress bar
#'
#' The progress bar may be updated server side. See \link{update_tabler_progress}.
#'
#' @param id Progress unique id.
#' @param value Progress value. Numeric between 0 and 100.
#'
#' @return A progress bar tag.
#' @export
#' @seealso \link{update_tabler_progress}
tabler_progress <- function(id = NULL, value) {

  validate_progress_value(value)

  div(
    class = "progress",
    div(
      id = id,
      class = "progress-bar",
      style = paste0("width: ", value, "%"),
      role = "progressbar",
      `aria-valuenow` = as.character(value),
      `aria-valuemin` = "0",
      `aria-valuemax` = "100",
      span(class = "sr-only", paste0(value,"% complete"))
    )
  )
}

#' Update a \link{tabler_progress} on the client
#'
#' @param id Progress unique id.
#' @param value New value.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyWidgets)
#'  ui <- tabler_page(
#'   tabler_body(
#'     noUiSliderInput(
#'       inputId = "progress_value",
#'       label = "Progress value",
#'       min = 0,
#'       max = 100,
#'       value = 20
#'     ),
#'     tabler_progress(id = "progress1", 12)
#'   )
#'  )
#'
#'  server <- function(input, output, session) {
#'    observeEvent(input$progress_value, {
#'      update_tabler_progress(
#'        id = "progress1",
#'        input$progress_value
#'      )
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
update_tabler_progress <- function(id, value, session = shiny::getDefaultReactiveDomain()) {
  message <- list(id = session$ns(id), value = value)
  session$sendCustomMessage(type = "update-progress", message)
}



#' Run the update_tabler_progress example
#'
#' @return A shiny app
#' @export
update_tabler_progress_example <- function() {
  shinyAppDir(system.file('tabler/update-progress-app', package='OSUICode'))
}


#' Create a Tabler toast
#'
#' Display user feedback
#'
#' @param id Unique toast id.
#' @param title Toast title.
#' @param subtitle Toast subtitle.
#' @param ... Toast content.
#' @param img Toast image.
#'
#' @return A toast
#' @export
#' @seealso \link{show_tabler_toast}
tabler_toast <- function(id, title = NULL, subtitle = NULL, ..., img = NULL) {

  toast_header <- div(
    class = "toast-header",
    if (!is.null(img)) {
      span(
        class = "avatar mr-2",
        style = sprintf("background-image: url(%s)", img)
      )
    },
    if (!is.null(title)) strong(class = "mr-2", title),
    if (!is.null(subtitle)) tags$small(subtitle)
  )

  toast_body <- div(class = "toast-body", ...)

  toast_wrapper <- div(
    id = id,
    class = "toast",
    role = "alert",
    style = "position: absolute; top: 0; right: 0;",
    `aria-live` = "assertive",
    `aria-atomic` = "true",
    `data-toggle` = "toast"
  )

  toast_wrapper %>% tagAppendChildren(toast_header, toast_body)
}




#' Show a tabler toast on the client
#'
#' @param id Toast id.
#' @param options Toast options: see \url{https://getbootstrap.com/docs/4.3/components/toasts/}.
#' @param session Shiny session
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  ui <- tabler_page(
#'   tabler_toast(
#'     id = "toast",
#'     title = "Hello",
#'     subtitle = "now",
#'     "Toast body",
#'     img = "https://preview-dev.tabler.io/static/logo.svg"
#'   ),
#'   tabler_button("launch", "Go!", width = "25%")
#'  )
#'
#'  server <- function(input, output, session) {
#'    observe(print(input$toast))
#'    observeEvent(input$launch, {
#'      removeNotification("notif")
#'      show_tabler_toast(
#'        "toast",
#'        options = list(
#'          animation = FALSE,
#'          delay = 3000
#'        )
#'      )
#'    })
#'
#'    observeEvent(input$toast, {
#'      showNotification(
#'        id = "notif",
#'        "Toast was closed",
#'        type = "warning",
#'        duration = 1,
#'
#'      )
#'    })
#'  }
#'
#'  shinyApp(ui, server)
#' }
show_tabler_toast <- function(id, options = NULL, session = getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      id = id,
      options = options
    )
  )
  session$sendCustomMessage(type = "tabler-toast", message)
}




#' Create a tabler dropdown menu
#'
#' This must be inserted in \link{tabler_navbar}
#'
#' @param ... Slot for \link{tabler_dropdown_item}
#' @param id Optional: this is to be able to toggle the dropdown based on
#' another event like after a click on an action button.
#' @param title Dropdown title
#' @param subtitle Dropdown subtitle
#' @param img Dropdown image.
#'
#' @return A dropdown menu container.
#' @export
#' @seealso \link{show_tabler_dropdown}.
tabler_dropdown <- function(..., id = NULL, title, subtitle = NULL, img = NULL) {

  img_tag <- if (!is.null(img)) {
    span(
      class = "avatar",
      style = sprintf("background-image: url(%s)", img)
    )
  }

  titles_tag <- div(
    class = "d-none d-xl-block pl-2",
    div(title),
    if (!is.null(subtitle)) {
      div(class = "mt-1 small text-muted", subtitle)
    }
  )

  link_tag <- a(
    href = "#",
    id = id,
    class = "nav-link d-flex lh-1 text-reset p-0",
    `data-toggle` = "dropdown",
    `aria-expanded` = "false"
  ) %>%
    tagAppendChildren(img_tag, titles_tag)

  dropdown_tag <- div(
    class = "dropdown-menu dropdown-menu-right",
    `aria-labelledby` = id,
    ...
  )

  div(class = "nav-item dropdown") %>% tagAppendChildren(
    link_tag,
    dropdown_tag
  )
}




#' Create Tabler dropdown item
#'
#' @param ... Content.
#' @param id Optional. If provided, the current item will behave like
#' a \link{tabler_button}.
#' @export
tabler_dropdown_item <- function(..., id = NULL) {
  a(id = id, class = "dropdown-item action-button", href = "#", ...)
}



#' Show a \link{tabler_dropdown} on the client
#'
#' @param id Dropdown id.
#' @param session Shiny session
#' @export
#'
#' @examples
#' if (interactive()) {
#'  ui <- tabler_page(
#'   tabler_navbar(
#'     brand_url = "https://preview-dev.tabler.io",
#'     brand_image = "https://preview-dev.tabler.io/static/logo.svg",
#'     nav_menu = NULL,
#'     tabler_dropdown(
#'       id = "mydropdown",
#'       title = "Dropdown",
#'       subtitle = "click me",
#'       tabler_dropdown_item(
#'         id = "item1",
#'         "Show Notification"
#'       ),
#'       tabler_dropdown_item(
#'         "Do nothing"
#'       )
#'     )
#'   ),
#'   tabler_body(
#'     tabler_button("show", "Open dropdown", width = "25%"),
#'     footer = tabler_footer(
#'       left = "Rstats, 2020",
#'       right = a(href = "https://www.google.com")
#'     )
#'   )
#'  )
#'  server <- function(input, output, session) {
#'
#'    observeEvent(input$show, {
#'      show_tabler_dropdown("mydropdown")
#'    })
#'
#'    observeEvent(input$item1, {
#'      showNotification(
#'        "Success",
#'        type = "message",
#'        duration = 2,
#'
#'      )
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
show_tabler_dropdown <- function(id, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage(type = "show-dropdown", message = id)
}




#' Insert a tab in a \link{tabler_navbar}
#'
#' @param inputId Tabler navbar menu unique id.
#' @param tab Tab to insert. Must be a \link{tabler_tab_item}.
#' @param target Target tab after or before which the new tab will be inserted.
#' @param position Insert position: "before" or "after".
#' @param select Whether to select the new tab at start. Default to FALSE.
#' @param handler_type Only for the Book purpose. Allow to select a given
#' custom message handler, to produce different behavior. You don't need
#' this in production!
#' @param session Shiny session.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  # See book section 15.4 (Tab events)
#'  # insert tab with wrong custom handler. The tab is inserted
#'  # but nothing is displayed inside.
#'  insert_tabler_tab_example(1)
#'
#'  # insert tab with good custom handler.
#'  insert_tabler_tab_example(2)
#' }
insert_tabler_tab <- function(inputId, tab, target, position = c("before", "after"),
                              select = FALSE, handler_type, session = getDefaultReactiveDomain()) {

  inputId <- session$ns(inputId)
  position <- match.arg(position)
  navbar_menu_item <- tags$li(
    class = "nav-item",
    a(
      class = "nav-link",
      href = paste0("#", session$ns(tab$attribs$id)),
      `data-toggle` = "pill",
      `data-value` = tab$attribs$id,
      role = "tab",
      tab$attribs$id
    )
  )

  # don't needed in production
  if (handler_type == 1) {
    tab <- force(as.character(tab))
    navbar_menu_item <- force(as.character(navbar_menu_item))
  }

  message <- dropNulls(
    list(
      inputId = inputId,
      # in production, only use processDeps(tab, session)
      content = if (handler_type == 1) {
        tab
      } else if (handler_type == 2) {
        processDeps(tab, session)
      },
      # in production, only use processDeps(navbar_menu_item, session)
      link = if (handler_type == 1) {
        navbar_menu_item
      } else if (handler_type == 2) {
        processDeps(navbar_menu_item, session)
      },
      target = target,
      position = position,
      select = select
    )
  )

  # this is for the book purpose. In theory the type should
  # remain fixed
  type <- paste0("insert-tab-", handler_type)

  session$sendCustomMessage(type, message)
}



#' Create an example for \link{insert_tabler_tab}.
#'
#' @param handler_type Only for the Book purpose. Allow to select a given
#' custom message handler, to produce different behavior. You don't need
#' this in production!
#'
#' @return A shiny app.
#' @export
#' @seealso \link{insert_tabler_tab}.
#' @importFrom graphics hist
#' @importFrom stats rnorm
insert_tabler_tab_example <- function(handler_type) {
  ui <- tabler_page(
    tabler_navbar(
      brand_url = "https://preview-dev.tabler.io",
      brand_image = "https://preview-dev.tabler.io/static/logo.svg",
      nav_menu = tabler_navbar_menu(
        inputId = "tabmenu",
        tabler_navbar_menu_item(
          text = "Tab 1",
          icon = NULL,
          tabName = "tab1",
          selected = TRUE
        ),
        tabler_navbar_menu_item(
          text = "Tab 2",
          icon = NULL,
          tabName = "tab2"
        )
      ),
      tabler_button("insert", "Insert Tab")
    ),
    tabler_body(
      tabler_tab_items(
        tabler_tab_item(
          tabName = "tab1",
          p("Hello World")
        ),
        tabler_tab_item(
          tabName = "tab2",
          p("Second Tab")
        )
      ),
      footer = tabler_footer(
        left = "Rstats, 2020",
        right = a(href = "https://www.google.com")
      )
    )
  )
  server <- function(input, output, session) {

    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })

    observeEvent(input$insert, {
      insert_tabler_tab(
        handler_type = handler_type,
        inputId = "tabmenu",
        tab = tabler_tab_item(
          tabName = "tab3",
          sliderInput("obs", "Number of observations:",
                      min = 0, max = 1000, value = 500
          ),
          plotOutput("distPlot")
        ),
        target = "tab2",
        position = "before",
        select = TRUE
      )
    })
  }
  shinyApp(ui, server)
}
