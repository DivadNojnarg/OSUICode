$(function() {
  // Input binding
  let customTextBinding = new Shiny.InputBinding();

  $.extend(customTextBinding, {
    find: function(scope) {
      return $(scope).find('.input-text');
    },
    // Given the DOM element for the input, return the value
    getValue: function(el) {
      return $(el).val();
    },
    setValue: function(el, value) {
      $(el).val(value);
    },
    receiveMessage: function(el, data) {
      if (data.hasOwnProperty('value')) {
        this.setValue(el, data.value);
        $(el).trigger('change');
      }
    },
    subscribe: function(el, callback) {
      $(el).on('keyup.customTextBinding input.textInputBinding', function(event) {
        callback(true);
      });

      $(el).on('change.customTextBinding', function(event) {
        callback();
      });
    },
    getRatePolicy: function() {
      return {
        policy: 'debounce',
        delay: 250
      };
    },
    unsubscribe: function(el) {
      $(el).off('.customTextBinding');
    }
  });

  Shiny.inputBindings.register(customTextBinding, 'text');
});
