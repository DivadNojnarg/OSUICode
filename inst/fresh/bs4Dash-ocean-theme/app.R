library(shiny)
library(fresh)
library(bs4Dash)
library(thematic)

layout_vars <- bs4dash_layout(main_bg = "#006994")

navbar_vars <- list(
  # navbar background
  bs4dash_status(light = "#005475", primary = "#00755c"),
  # put toggler in white
  bs4dash_vars(navbar_light_color = "#fff")
)

inverted_colors <- bs4dash_color(
  gray_900 = "#fff",
  white = "#005475"
)

sidebar_vars <- list(
  bs4dash_yiq(
    contrasted_threshold = 10,
    text_dark = "#FFF",
    text_light = "#272c30"
  ),
  bs4dash_sidebar_light(
    bg = "#005475",
    color = "#FFF",
    hover_color = "#FFF",
    submenu_color = "#FFF",
    submenu_hover_color = "#FFF"
  )
)
ocean_theme <- create_theme(
  layout_vars,
  navbar_vars,
  inverted_colors,
  sidebar_vars
)

shinyApp(
  ui = dashboardPage(
    title = "Ocean theme",
    dark = NULL,
    freshTheme = ocean_theme,
    header = dashboardHeader(title = "Theming bs4Dash"),
    controlbar = dashboardControlbar(
      skin = "dark",
      "This is the control bar"
    ),
    sidebar = dashboardSidebar(
      skin = "light",
      sidebarMenu(
        sidebarHeader("Menu:"),
        menuItem(
          tabName = "tab1",
          text = "UI components",
          icon = icon("home")
        ),
        menuItem(
          tabName = "tab2",
          text = "Tab 2"
        ),
        menuItem(
          text = "Item List",
          icon = icon("bars"),
          startExpanded = TRUE,
          menuSubItem(
            text = "Item 1",
            tabName = "item1",
            icon = icon("circle-thin")
          ),
          menuSubItem(
            text = "Item 2",
            tabName = "item2",
            icon = icon("circle-thin")
          )
        )
      )
    ),
    body = dashboardBody(
      tabItems(
        tabItem(
          tabName = "tab1",
          tags$head(
            tags$style(".brand-link { color: #fff !important; }")
          ),
          tags$h2("UI components"),
          tags$h4("bs4ValueBox"),
          fluidRow(
            valueBox(
              value = 150,
              subtitle = "ValueBox with primary status",
              color = "primary",
              icon = icon("shopping-cart"),
              href = "#",
              width = 4
            ),
            valueBox(
              value = 150,
              subtitle = "ValueBox with secondary status",
              color = "secondary",
              icon = icon("shopping-cart"),
              href = "#",
              width = 4
            ),
            valueBox(
              value = "53%",
              subtitle = "ValueBox with danger status",
              color = "danger",
              icon = icon("cogs"),
              width = 4
            )
          ),
          tags$h4("bs4InfoBox"),
          fluidRow(
            infoBox(
              value = 150,
              title = "InfoBox with primary status",
              color = "primary",
              icon = icon("shopping-cart"),
              href = "#",
              width = 4
            ),
            infoBox(
              value = 150,
              title = "InfoBox with secondary status",
              color = "secondary",
              icon = icon("shopping-cart"),
              href = "#",
              width = 4
            ),
            infoBox(
              value = "53%",
              title = "InfoBox with danger status",
              color = "danger",
              icon = icon("cogs"),
              width = 4
            )
          ),
          tags$h4("bs4Card"),
          fluidRow(
            box(
              title = "Card with primary status",
              closable = FALSE,
              width = 6,
              solidHeader = TRUE,
              status = "primary",
              collapsible = TRUE,
              p("Box Content")
            ),
            box(
              title = "Card with secondary status",
              closable = FALSE,
              width = 6,
              solidHeader = TRUE,
              status = "secondary",
              collapsible = TRUE,
              p("Box Content")
            ),
            box(
              title = "Card with danger status",
              closable = FALSE,
              width = 6,
              solidHeader = TRUE,
              status = "danger",
              collapsible = TRUE,
              p("Box Content")
            ),
            box(
              title = "Card with warning status",
              closable = FALSE,
              width = 6,
              solidHeader = TRUE,
              status = "warning",
              collapsible = TRUE,
              p("Box Content")
            ),
            box(
              title = "Card with info status",
              closable = FALSE,
              width = 6,
              solidHeader = TRUE,
              status = "info",
              collapsible = TRUE,
              p("Box Content")
            ),
            box(
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
        tabItem(
          tabName = "tab2",
          box(
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
