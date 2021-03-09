$(function() {
  // Input binding
  let customTextBinding = new Shiny.InputBinding();

  $.extend(customTextBinding, {
    find: function(scope) {
      return $(scope).find('#mytextInput');
    }
  });

  Shiny.inputBindings.register(customTextBinding, 'text');
});
