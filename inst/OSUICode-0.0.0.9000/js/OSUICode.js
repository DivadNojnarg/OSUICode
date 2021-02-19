// srcjs/helpers_config.js
var setConfig = () => {
  let config = $(document).find("script[data-for='app']");
  config = JSON.parse(config.html());
  config.root = "#app";
  config.methods = {
    toggleDarkTheme: function() {
      let self = this;
      let $html = self.$("html");
      $html.toggleClass("theme-dark");
    }
  };
  let isPWA = $("body").attr("data-pwa") === "true";
  if (isPWA) {
    config.serviceWorker = {
      path: window.location.pathname + "service-worker.js",
      scope: window.location.pathname
    };
  }
  config.data = function() {
    return {
      gauge: []
    };
  };
  return config;
};

// srcjs/helpers_theme.js
var setTouchStyle = (config) => {
  if (config.hasOwnProperty("touch")) {
    if (config.touch.tapHold) {
      $("<style>").prop("type", "text/css").html(`
          -moz-user-select: none;
          -webkit-user-select: none;
          user-select: none;`).appendTo("head");
    }
  }
};
var setColorTheme = (config) => {
  if (config.hasOwnProperty("color")) {
    let colorCSS = app.utils.colorThemeCSSProperties(config.color);
    $("<style>").prop("type", "text/css").html(`:root {
        --f7-theme-color: ${colorCSS["--f7-theme-color"]};
        --f7-theme-color-rgb: ${colorCSS["--f7-theme-color-rgb"]};
        --f7-theme-color-shade: ${colorCSS["--f7-theme-color-shade"]};
        --f7-theme-color-tint: ${colorCSS["--f7-theme-color-tint"]};
      }`).appendTo("head");
  }
};
var setFilledTheme = (config) => {
  if (!config.hasOwnProperty("filled"))
    config.filled = false;
  if (config.filled) {
    let filledCSS = `
      :root,
      :root.theme-dark,
      :root .theme-dark {
        --f7-bars-bg-color: var(--f7-theme-color);
        --f7-bars-bg-color-rgb: var(--f7-theme-color-rgb);
        --f7-bars-translucent-opacity: 0.9;
        --f7-bars-text-color: #fff;
        --f7-bars-link-color: #fff;
        --f7-navbar-subtitle-text-color: rgba(255,255,255,0.85);
        --f7-bars-border-color: transparent;
        --f7-tabbar-link-active-color: #fff;
        --f7-tabbar-link-inactive-color: rgba(255,255,255,0.54);
        --f7-sheet-border-color: transparent;
        --f7-tabbar-link-active-border-color: #fff;
      }
      .appbar,
      .navbar,
      .toolbar,
      .subnavbar,
      .calendar-header,
      .calendar-footer {
        --f7-touch-ripple-color: var(--f7-touch-ripple-white);
        --f7-link-highlight-color: var(--f7-link-highlight-white);
        --f7-button-text-color: #fff;
        --f7-button-pressed-bg-color: rgba(255,255,255,0.1);
      }
      .navbar-large-transparent,
      .navbar-large.navbar-transparent {
        --f7-navbar-large-title-text-color: #000;

        --r: 0;
        --g: 122;
        --b: 255;
        --progress: var(--f7-navbar-large-collapse-progress);
        --f7-bars-link-color: rgb(
          calc(var(--r) + (255 - var(--r)) * var(--progress)),
          calc(var(--g) + (255 - var(--g)) * var(--progress)),
          calc(var(--b) + (255 - var(--b)) * var(--progress))
        );
      }
      .theme-dark .navbar-large-transparent,
      .theme-dark .navbar-large.navbar-transparent {
        --f7-navbar-large-title-text-color: #fff;
    }`;
    $("<style>").prop("type", "text/css").html(`${filledCSS}`).appendTo("head");
  }
};
var setDarkMode = (config, app2) => {
  if (!config.hasOwnProperty("dark"))
    config.dark = false;
  if (config.dark) {
    app2.methods.toggleDarkTheme();
  }
  return config.dark;
};
var initTheme = (config, app2) => {
  setTouchStyle(config);
  setColorTheme(config);
  setFilledTheme(config);
  setDarkMode(config, app2);
};

// srcjs/helpers_pwa.js
var setPWA = (app2) => {
  let installToast = app2.toast.create({
    position: "center",
    text: '<button id="install-button" class="toast-button button color-green">Install</button>'
  });
  let deferredPrompt;
  $(window).on("beforeinstallprompt", (e) => {
    e.preventDefault();
    deferredPrompt = e.originalEvent;
    installToast.open();
  });
  app2.utils.nextTick(function() {
    $("#install-button").on("click", function() {
      installToast.close();
      if (!deferredPrompt) {
        return;
      }
      deferredPrompt.prompt();
      deferredPrompt.userChoice.then((result) => {
        console.log("\u{1F44D}", "userChoice", result);
        deferredPrompt = null;
      });
    });
  }, 500);
};

// srcjs/helpers_disconnect.js
var setCustomDisconnect = (app2) => {
  $(document).on("shiny:connected", function(event) {
    Shiny.shinyapp.onDisconnected = function() {
      let $overlay = $("#shiny-disconnected-overlay");
      if ($overlay.length === 0) {
        $(document.body).append('<div id="shiny-disconnected-overlay"></div>');
      }
    };
  });
  $(document).on("shiny:disconnected", function(event) {
    let reconnectToast = app2.toast.create({
      position: "center",
      text: 'Oups... disconnected </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>'
    }).open();
    $(".toast").css("background-color", "#1c1c1d");
    $(".toast-button").on("click", function() {
      reconnectToast.close();
    });
  });
};

// srcjs/init.js
$(document).ready(function() {
  let config = setConfig();
  app = new Framework7(config);
  mainView = app.views.create(".view-main");
  let isDark = initTheme(config, app);
  config.dark = isDark;
  setCustomDisconnect(app);
  setPWA(app);
  app.notification.create({
    text: "Hello, how are you?",
    on: {
      opened: function() {
        console.log("Notification opened");
      }
    }
  }).open();
  app.utils.nextTick(function() {
    app.notification.create({
      text: "You look great!"
    }).open();
  }, 2e3);
  $("#mybutton").on("taphold", function() {
    app.dialog.alert("Tap hold fired!");
  });
});

// srcjs/widgets.js
$(document).ready(function() {
  const uiWidgets = ["gauge", "swiper", "searchbar"];
  const serverWidgets = ["toast", "photoBrowser", "notification"];
  const widgets = uiWidgets.concat(serverWidgets);
  activateWidget = function(widget) {
    if (uiWidgets.indexOf(widget) > -1) {
      $("." + widget).each(function() {
        var $el = $(this);
        var config = $(document).find("script[data-for='" + $el.attr("id") + "']");
        config = JSON.parse(config.html());
        config.el = "#" + $el.attr("id");
        var w = app[widget].create(config);
        app.data[widget][$el.attr("id")] = w;
      });
    } else {
      Shiny.addCustomMessageHandler(widget, function(message) {
        if (message.id !== void 0) {
          message.on = {
            opened: function() {
              Shiny.setInputValue(message.id, true);
            },
            closed: function() {
              Shiny.setInputValue(message.id, false);
            }
          };
        }
        var w = app[widget].create(message);
        w.open();
      });
    }
  };
  widgets.forEach(function(w) {
    activateWidget(w);
  });
  Shiny.addCustomMessageHandler("update-instance", function(message) {
    var instanceFamily;
    for (const property in app.data) {
      for (const e in app.data[property]) {
        if (e === message.id) {
          instanceFamily = property;
        }
      }
    }
    var oldInstance = app.data[instanceFamily][message.id];
    var oldConfig = oldInstance.params;
    var newConfig = app.utils.extend(oldConfig, message.options);
    oldInstance.destroy();
    var newInstance = app[instanceFamily].create(newConfig);
    app.data[instanceFamily][message.id] = newInstance;
  });
});
