$(function() {
  // Input binding
  let customTextBinding = new Shiny.InputBinding();

  $.extend(customTextBinding, {
    find: function(scope) {
      return $(scope).find('.input-text');
    },
    // Given the DOM element for the input, return the value
    getValue: function(el) {
      console.log($(el));
      return $(el).val();
    }
  });

  Shiny.inputBindings.register(customTextBinding, 'text');
});
