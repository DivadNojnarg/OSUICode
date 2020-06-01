$(function() {
  Shiny.addCustomMessageHandler('update-progress', function(message) {
    $('#' + message.id).css('width', message.value +'%');
  });
});
