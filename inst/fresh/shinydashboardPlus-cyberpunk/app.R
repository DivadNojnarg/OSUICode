library(shiny)
library(fresh)
library(shinydashboard)
library(shinydashboardPlus)

box_factory <- function(status, background, labelStatus) {
  box(
    title = "Cyberpunk Box",
    collapsible = TRUE,
    solidHeader = TRUE,
    status = status,
    background = background,
    height = "200px",
    label = boxLabel(1, labelStatus)
  )
}

# create tribble for box global config
box_config <- tibble::tribble(
  ~status, ~background, ~labelStatus,
  "danger", "red", "success",
  "primary", "light-blue", "danger",
  "success", "green", "primary",
  "info", "aqua", "success"
)

boxes <- purrr::pmap(box_config, box_factory)

cyberpunk_theme <- create_theme(
  adminlte_color(
    green = "#3fff2d",
    blue = "#2635ff",
    red = " #ff2b2b",
    yellow = "#feff6e",
    fuchsia = "#ff5bf8",
    navy = "#374c92",
    purple = "#615cbf",
    maroon = "#b659c9",
    light_blue = "#5691cc"
  ),
  adminlte_sidebar(
    dark_bg = "#D8DEE9",
    dark_hover_bg = "#81A1C1",
    dark_color = "#2E3440"
  ),
  adminlte_global(
    content_bg = "#aaaaaa"
  )
)

shinyApp(
  ui = dashboardPage(
    freshTheme = cyberpunk_theme,
    skin = "blue",
    options = list(sidebarExpandOnHover = TRUE),
    header = dashboardHeader(),
    sidebar = dashboardSidebar(
      sidebarMenu(
        menuItem("Item 1", badgeLabel = icon("heart"), badgeColor = "light-blue"),
        menuItem("Item 2", badgeLabel = icon("poo"), badgeColor = "maroon")
      )
    ),
    body = dashboardBody(boxes),
    controlbar = dashboardControlbar(),
    title = "Fresh theming"
  ),
  server = function(input, output) { }
)
