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
      console.log(data);
      this.setValue(el, data);
    }
  });

  Shiny.inputBindings.register(customTextBinding, 'text');
});
