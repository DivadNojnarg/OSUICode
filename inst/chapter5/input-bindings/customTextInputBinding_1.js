$(function() {
  // Input binding
  let customTextBinding = new Shiny.InputBinding();

  $.extend(customTextBinding, {
    find: function(scope) {
      console.log($(scope).find('.input-text'));
      return $(scope).find('.input-text');
    }
  });

  Shiny.inputBindings.register(customTextBinding, 'text');
});
