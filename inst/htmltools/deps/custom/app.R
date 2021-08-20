library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

options <- list(
  sidebarExpandOnHover = TRUE,
  boxWidgetSelectors = list(
    remove = '[data-widget="remove"]'
  )
)

shinyApp(
  ui = dashboardPage(
    options = options,
    header = dashboardHeader(),
    sidebar = dashboardSidebar(),
    body = dashboardBody(),
    controlbar = dashboardControlbar(),
    title = "DashboardPage"
  ),
  server = function(input, output) { }
)
