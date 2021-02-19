$( document ).ready(function() {
  const uiWidgets = ["gauge", "swiper", "searchbar"];
  const serverWidgets = ["toast", "photoBrowser", "notification"];
  const widgets = uiWidgets.concat(serverWidgets);

  // Instantiate a widget
  activateWidget = function(widget) {
    // Handle ui side widgets
    if (uiWidgets.indexOf(widget) > -1) {
      $("." + widget).each(function() {
        var $el = $(this);
        var config = $(document).find(
          "script[data-for='" + $el.attr("id") + "']"
        );
        config = JSON.parse(config.html());
        // add the id
        config.el = '#' + $el.attr("id");

        // feed the create method
        var w = app[widget].create(config);
        // Store the widget instance in the app data cache
        app.data[widget][$el.attr("id")] = w;
      });
    } else {
      // This concerns toasts, notifications, photoBrowser, ...
      // that don't have any UI element in the DOM before creating
      // the widget instance.
      Shiny.addCustomMessageHandler(widget, function(message) {

        // Let shiny lnow about the widget state
        if (message.id !== undefined) {
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

  // Loop over all widgets to activate them
  widgets.forEach(function(w) {
    activateWidget(w);
  });


  // Update widget instances
  Shiny.addCustomMessageHandler('update-instance', function(message) {
    // Recover in which array is stored the given instance.
    // Uniqueness is ensured since HTML id are supposed to be unique.
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
    var newConfig = app.utils.extend(oldConfig,  message.options);

    // Destroy old instance
    oldInstance.destroy();
    // Create new config
    var newInstance = app[instanceFamily].create(newConfig);
    // Update app data
    app.data[instanceFamily][message.id] = newInstance;
  });

});
