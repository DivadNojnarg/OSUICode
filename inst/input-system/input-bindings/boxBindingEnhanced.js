let boxBinding = new Shiny.InputBinding();
$.extend(boxBinding, {
  find: function(scope) {
    return $(scope).find('.box');
  },
  getValue: function(el) {
    let isCollapsed = $(el).hasClass('collapsed-box');
    return {collapsed: isCollapsed}; // this will be a list in R
  },
  // user defined binding: extract config script
  _getConfigScript: function(el) {
    return(
      $(el)
        .parent()
        .find("script[data-for='" + el.id + "']")
    );
  },
  // user defined binding: process config script
  _processConfig: function(el) {
    return(
      JSON.parse(
        this
        ._getConfigScript(el)
        .html()
      )
    );
  },
  // user defined binding: update box width
  _updateWidth: function(el, o, n) {
    // removes old class
    $(el).parent().toggleClass("col-sm-" + o);
    $(el).parent().addClass("col-sm-" + n);
    // trigger resize so that output resize
    $(el).trigger('resize');
  },
  // Input binding default method
  setValue: function(el, value) {
    let config = this._processConfig(el);

    // JS logic
    if (value.action === "update") {
      if (value.options.hasOwnProperty("width")) {
        if (value.options.width !== config.width) {
          this._updateWidth(
            el,
            config.width,
            value.options.width
          )
          config.width = value.options.width;
        }
      }
      // other items to update
      if (value.options.hasOwnProperty("title")) {
        if (value.options.title !== config.title) {
          let newTitle;
          if (typeof value.options.title !== "string") {
            newTitle = `<h3 class="box-title">${value.options.title[0]}</h3>`
            newTitle = $.parseHTML(newTitle);
          } else {
            newTitle = `<h3 class="box-title">${value.options.title}</h3>`
            newTitle = $.parseHTML(newTitle);
          }

          $(el)
            .find(".box-title")
            .replaceWith($(newTitle));

          config.title = value.options.title;
        }
      }

      // replace the old JSON config by the new one
      // to update the input value
      this
        ._getConfigScript(el)
        .replaceWith(
          '<script type="application/json" data-for="' +
          el.id +
          '">' +
          JSON.stringify(config) +
          '</script>'
        );

    } else if (value.action === "toggle") {
      // if action is toggle
      $(el).toggleBox();
    }

  },
  receiveMessage: function(el, data) {
    this.setValue(el, data);
    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('click', '[data-widget="collapse"]', function(event) {
      setTimeout(function() {
        callback();
      }, 50);
    });

    $(el).on('change', function(event) {
      setTimeout(function() {
        callback();
      }, 50);
    });
  },
  unsubscribe: function(el) {
    $(el).off('.boxBinding');
  }
});

Shiny.inputBindings.register(boxBinding, 'box-input');


$(function() {
  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10;
});
