$(function() {
  let boxBinding = new Shiny.InputBinding();
  $.extend(boxBinding, {
    initialize: function(el) {
      $(el).activateBox(); // box activation
    },
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
        }, 550);
      });

      $(el).on('change', function(event) {
        setTimeout(function() {
          callback();
        }, 550);
      });
    },
    unsubscribe: function(el) {
      $(el).off('.boxBinding');
    }
  });

  Shiny.inputBindings.register(boxBinding, 'box-input');
});
