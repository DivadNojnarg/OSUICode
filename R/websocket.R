#' Initialize a websocket server
#'
#' This has to be used with \link{websocket_client}.
#'
#' @param host A string that is a valid IPv4 address that is owned by this server,
#' or "0.0.0.0" to listen on all IP addresses.
#' @param port A number or integer that indicates the server port that should be listened on.
#' Note that on most Unix-like systems including Linux and Mac OS X, port numbers smaller than
#' 1025 require root privileges.
#'
#' @export
#' @rdname websocket
#' @examples
#' library(OSUICode)
#' server <- websocket_server()
#' client_1 <- websocket_client()
#' client_2 <- websocket_client()
#' client_1$send("Hello from client 1")
#' client_2$send("Hello from client 2")
#' client_1$close()
#' client_2$send("Only client 2 is here")
#' Sys.sleep(1)
#' server$stop()
websocket_server <- function(host = "127.0.0.1", port = 8080) {
  # set the server
  httpuv::startServer(
    host,
    port,
    list(
      onWSOpen = function(ws) {
        # The ws object is a WebSocket object
        cat("New connection opened.\n")
        # Capture client messages
        ws$onMessage(function(binary, message) {
          print(binary)
          cat("Server received message:", message, "\n")
          ws$send("Hello client!")
        })
        ws$onClose(function() {
          cat("Server connection closed.\n")
        })
      }
    )
  )
}



#' Initialize a client websocket
#'
#' @return A client websocket connection
#' @export
#' @rdname websocket
websocket_client <- function(host = "127.0.0.1", port = 8080) {
  ws <- websocket::WebSocket$new(sprintf("ws://%s:%s/", host, port))
  # Capture server messages
  ws$onMessage(function(event) {
    cat("Client received message:", event$data, "\n")
  })
  ws
}
