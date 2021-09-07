library(shiny)
library(OSUICode)
library(apexcharter)
library(dplyr)
library(ggplot2)

# test the card
data("economics_long")
economics_long <- economics_long %>%
  group_by(variable) %>%
  slice((n()-100):n())

spark_data <- data.frame(
  date = Sys.Date() + 1:20,
  var1 = round(rnorm(20, 50, 10)),
  var2 = round(rnorm(20, 50, 10)),
  var3 = round(rnorm(20, 50, 10))
)

my_card <- tabler_card(
  apexchartOutput("my_chart"),
  title = "My card",
  status = "danger"
)

thematic_shiny()

ui <- tabler_page(
  tabler_body(
    tabler_row(
      my_card,
      tabler_card(
        apexchartOutput("spark_box"),
        title = "My card",
        status = "success"
      )
    )
  )
)
server <- function(input, output) {
  output$my_chart <- renderApexchart({
    apex(
      data = economics_long,
      type = "area",
      mapping = aes(x = date, y = value01, fill = variable)
    ) %>%
      ax_yaxis(decimalsInFloat = 2) %>% # number of decimals to keep
      ax_chart(stacked = TRUE) %>%
      ax_yaxis(max = 4, tickAmount = 4)
  })

  output$spark_box <- renderApexchart({
    spark_box(
      data = spark_data[, c("date", "var3")],
      title = mean(spark_data$var3),
      subtitle = "Variable 3",
      color = "#FFF", background = "#2E93fA",
      title_style = list(color = "#FFF"),
      subtitle_style = list(color = "#FFF")
    )
  })
}
shinyApp(ui, server)
