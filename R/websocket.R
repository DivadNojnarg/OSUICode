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
#' if (interactive()) {
#'  library(OSUICode)
#'  server <- websocket_server()
#'  client_1 <- websocket_client()
#'  client_2 <- websocket_client()
#'  client_1$send("Hello from client 1")
#'  client_2$send("Hello from client 2")
#'  client_1$close()
#'  client_2$send("Only client 2 is here")
#'  Sys.sleep(1)
#'  server$stop()
#' }
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


#' Create demo httpuv app
#'
#' This app is composed of an HTTP response containing a
#' an HTML page with a range slider and a client websocket connection.
#' The app has also a server websocket handler.
#' At the end of the day, don't forget to stop the app!
#'
#' @param delay To simulate computationally intense task.
#' @return An httpuv powered app
#' @importFrom graphics hist
#' @importFrom stats rnorm
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(OSUICode)
#'  my_app <- httpuv_app()
#'  my_app$stop()
#' }
httpuv_app <- function(delay = NULL) {
  s <- httpuv::startServer(
    "127.0.0.1",
    8080,
    list(
      call = function(req) {
        list(
          status = 200L,
          headers = list(
            'Content-Type' = 'text/html'
          ),
          body = '
            <!DOCTYPE HTML>
            <html lang="en">
              <head>
                <script language="javascript">
                  document.addEventListener("DOMContentLoaded", function(event) {
                    var gauge = document.getElementById("mygauge");
                    // Initialize client socket connection
                    var mySocket = new WebSocket("ws://127.0.0.1:8080");
                    mySocket.onopen = function (event) {
                      // do stuff
                    };
                    // update the gauge value on server message
                    mySocket.onmessage = function (event) {
                      var data = JSON.parse(event.data);
                      gauge.value = data.val;
                    };

                    var sliderWidget = document.getElementById("slider");
                    var label = document.getElementById("sliderLabel");
                    label.innerHTML = "Value:" + slider.value; // init
                    // on change
                    sliderWidget.oninput = function() {
                      var val = parseInt(this.value);
                      mySocket.send(
                        JSON.stringify({
                          value: val,
                          message: "New value for you server!"
                        })
                      );
                      label.innerHTML = "Value:" + val;
                    };
                  });
                </script>
                <title>Websocket Example</title>
              </head>
              <body>
                <div>
                  <input type="range" id="slider" name="volume" min="0" max="100">
                  <label for="slider" id ="sliderLabel"></label>
                </div>
                <br/>
                <label for="mygauge">Gauge:</label>
                <meter id="mygauge" min="0" max="100" low="33" high="66" optimum="80" value="50"></meter>
              </body>
            </html>
          '
        )
      },
      onWSOpen = function(ws) {
        # The ws object is a WebSocket object
        cat("New connection opened.\n")
        # Capture client messages
        ws$onMessage(function(binary, message) {

          # create plot
          input_message <- jsonlite::fromJSON(message)
          print(input_message)
          cat("Number of bins:", input_message$value, "\n")
          hist(rnorm(input_message$value))
          if (!is.null(delay)) Sys.sleep(delay)

          # update gauge widget
          output_message <- jsonlite::toJSON(
            list(
              val = sample(0:100, 1),
              message = "Thanks client! I updated the plot..."
            ),
            pretty = TRUE,
            auto_unbox = TRUE
          )
          ws$send(output_message)
          cat(output_message)
        })
        ws$onClose(function() {
          cat("Server connection closed.\n")
        })
      }
    )
  )
  s
}

