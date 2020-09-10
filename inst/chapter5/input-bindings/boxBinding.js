// overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
$.AdminLTE.boxWidget.animationSpeed = 10;

let boxBinding = new Shiny.InputBinding();
$.extend(boxBinding, {
  find: function(scope) {
    return $(scope).find('.box');
  },
  getValue: function(el) {
    let isCollapsed = $(el).hasClass('collapsed-box');
    return {collapsed: isCollapsed}; // this will be a list in R
  },
  setValue: function(el, value) {
    $(el).toggleBox();
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
