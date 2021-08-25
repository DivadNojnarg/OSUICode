library(shiny)
library(sass)
library(magrittr)

win98_cdn <- "https://cdn.jsdelivr.net/npm/98.css@0.1.16/"
win98_css <- paste0(win98_cdn, "dist/98.min.css")

theme %>%
  bs_add_rules(
    sprintf('@import "%s"', win98_css)
  )


windows_grey <- "#c0c0c0"
windows98_theme <- bs_theme(
  bg = windows_grey,
  fg = "#222222",
  primary = "#03158b",
  base_font = c("Times", "Arial"),
  secondary = windows_grey,
  success = windows_grey,
  danger = windows_grey,
  info = windows_grey,
  light = windows_grey,
  dark = windows_grey,
  warning = windows_grey,
  "font-size-base" = "0.75rem",
  "enable-rounded" = FALSE
) %>%
  bs_add_rules(
    sprintf('@import "%s"', win98_css)
  )

windows98_theme %>% bs_theme_preview()
