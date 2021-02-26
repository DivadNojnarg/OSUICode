#' Customize bs4Dash with fresh
#'
#' @param theme Theme built with create_theme from fresh
#'
#' @return A shiny app example
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(bs4Dash)
#'  library(fresh)
#'
#'  dark_theme <- create_theme(
#'   bs4dash_vars(
#'     navbar_light_color = "#bec5cb",
#'     navbar_light_active_color = "#FFF",
#'     navbar_light_hover_color = "#FFF"
#'   ),
#'   bs4dash_yiq(contrasted_threshold = 10, text_dark = "#FFF", text_light = "#272c30"),
#'   bs4dash_layout(main_bg = "#353c42"),
#'   bs4dash_sidebar_dark(
#'     bg = "#272c30", color = "#bec5cb", hover_color = "#FFF",
#'     submenu_bg = "#272c30", submenu_color = "#FFF", submenu_hover_color = "#FFF"
#'   ),
#'   bs4dash_status(dark = "#272c30"),
#'   bs4dash_color(gray_900 = "#FFF", white = "#272c30")
#'  )
#'
#'  customize_bs4Dash(dark_theme)
#'
#' }
#' @export
customize_bs4Dash <- function(theme) {
  thematic::thematic_shiny()
  shinyApp(
    ui = bs4Dash::dashboardPage(
      title = "Theming demo",
      dark = FALSE,
      freshTheme = theme,
      header = bs4Dash::dashboardHeader(title = "Theming bs4Dash"),
      controlbar = bs4Dash::dashboardControlbar(
        skin = "dark",
        "This is the control bar"
      ),
      sidebar = bs4Dash::dashboardSidebar(
        skin = "light",
        bs4Dash::sidebarMenu(
          bs4Dash::sidebarHeader("Menu:"),
          bs4Dash::menuItem(
            tabName = "tab1",
            text = "UI components",
            icon = icon("home")
          ),
          bs4Dash::menuItem(
            tabName = "tab2",
            text = "Tab 2"
          ),
          bs4Dash::menuItem(
            text = "Item List",
            icon = icon("bars"),
            startExpanded = TRUE,
            bs4Dash::menuSubItem(
              text = "Item 1",
              tabName = "item1",
              icon = icon("circle-thin")
            ),
            bs4Dash::menuSubItem(
              text = "Item 2",
              tabName = "item2",
              icon = icon("circle-thin")
            )
          )
        )
      ),
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "tab1",
            tags$head(
              tags$style(".brand-link { color: #fff !important; }")
            ),
            tags$h2("UI components"),
            tags$h4("bs4ValueBox"),
            fluidRow(
              bs4Dash::valueBox(
                value = 150,
                subtitle = "ValueBox with primary status",
                color = "primary",
                icon = icon("shopping-cart"),
                href = "#",
                width = 4
              ),
              bs4Dash::valueBox(
                value = 150,
                subtitle = "ValueBox with secondary status",
                color = "secondary",
                icon = icon("shopping-cart"),
                href = "#",
                width = 4
              ),
              bs4Dash::valueBox(
                value = "53%",
                subtitle = "ValueBox with danger status",
                color = "danger",
                icon = icon("cogs"),
                width = 4
              )
            ),
            tags$h4("bs4InfoBox"),
            fluidRow(
              bs4Dash::infoBox(
                value = 150,
                title = "InfoBox with primary status",
                color = "primary",
                icon = icon("shopping-cart"),
                href = "#",
                width = 4
              ),
              bs4Dash::infoBox(
                value = 150,
                title = "InfoBox with secondary status",
                color = "secondary",
                icon = icon("shopping-cart"),
                href = "#",
                width = 4
              ),
              bs4Dash::infoBox(
                value = "53%",
                title = "InfoBox with danger status",
                color = "danger",
                icon = icon("cogs"),
                width = 4
              )
            ),
            tags$h4("bs4Card"),
            fluidRow(
              bs4Dash::box(
                title = "Card with primary status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "primary",
                collapsible = TRUE,
                p("Box Content")
              ),
              bs4Dash::box(
                title = "Card with secondary status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "secondary",
                collapsible = TRUE,
                p("Box Content")
              ),
              bs4Dash::box(
                title = "Card with danger status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "danger",
                collapsible = TRUE,
                p("Box Content")
              ),
              bs4Dash::box(
                title = "Card with warning status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "warning",
                collapsible = TRUE,
                p("Box Content")
              ),
              bs4Dash::box(
                title = "Card with info status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "info",
                collapsible = TRUE,
                p("Box Content")
              ),
              bs4Dash::box(
                title = "Card with success status",
                closable = FALSE,
                width = 6,
                solidHeader = TRUE,
                status = "success",
                collapsible = TRUE,
                p("Box Content")
              )
            )
          ),
          bs4Dash::tabItem(
            tabName = "tab2",
            bs4Dash::box(
              sliderInput(
                "obs",
                "Number of observations:",
                min = 0,
                max = 1000,
                value = 500
              ),
              plotOutput("distPlot")
            )
          )
        )
      )
    ),
    server = function(input, output) {
      output$distPlot <- renderPlot({
        hist(rnorm(input$obs))
      })
    }
  )
}



#' Customize shinydashboard with fresh
#'
#' @param theme Theme built with create_theme from fresh
#'
#' @return A shiny app example
#' @export
customize_shinydashboard <- function(theme) {

  # create tribble for box global config
  box_config <- tibble::tribble(
    ~status, ~background, ~labelStatus,
    "danger", "red", "success",
    "primary", "light-blue", "danger",
    "success", "green", "primary",
    "info", "aqua", "success"
  )

  boxes <- purrr::pmap(box_config, box_factory)

  shinyApp(
    ui = shinydashboardPlus::dashboardPage(
      freshTheme = theme,
      skin = "blue",
      options = list(sidebarExpandOnHover = TRUE),
      header = shinydashboard::dashboardHeader(),
      sidebar = shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(
          shinydashboard::menuItem("Item 1", badgeLabel = icon("heart"), badgeColor = "light-blue"),
          shinydashboard::menuItem("Item 2", badgeLabel = icon("poo"), badgeColor = "maroon")
        )
      ),
      body = shinydashboard::dashboardBody(boxes),
      controlbar = shinydashboardPlus::dashboardControlbar(),
      title = "Fresh theming"
    ),
    server = function(input, output) { }
  )
}


#' @keywords internal
box_factory <- function(status, background, labelStatus) {
  shinydashboardPlus::box(
    title = "Cyberpunk Box",
    collapsible = TRUE,
    solidHeader = TRUE,
    status = status,
    background = background,
    height = "200px",
    label = shinydashboardPlus::boxLabel(1, labelStatus)
  )
}
