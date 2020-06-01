#' Function demonstrating the use of Shiny custom message handlers
#'
#' Send a message from R to JavaScript every 5 seconds.
#' The JS answer is an alert containing the message sent by R.
#'
#' @param text Message to send.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  shinyAppDir(system.file("chapter6/say_hello", package = "OSUICode"))
#' }
say_hello_to_js <- function(text, session = getDefaultReactiveDomain()) {
  session$sendCustomMessage(type = 'say-hello', message = text)
}
