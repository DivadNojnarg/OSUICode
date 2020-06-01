$(function() {
  Shiny.addCustomMessageHandler('say-hello', function(message) {
    alert(`R says ${message} to you!`);
  });
});
