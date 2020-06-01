$(function() {
  Shiny.addCustomMessageHandler('show-dropdown', function(message) {
    $(`#${message}`).dropdown('show');
  });
});
