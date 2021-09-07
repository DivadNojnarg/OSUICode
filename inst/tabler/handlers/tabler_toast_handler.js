$(function() {
  Shiny.addCustomMessageHandler('tabler-toast', function(message) {
    $(`#${message.id}`)
    .toast(message.options)
    .toast('show');

    // add custom Shiny input to listen to the toast state
    $(`#${message.id}`).one('hidden.bs.toast', function() {
      Shiny.setInputValue(message.id, true, {priority: 'event'});
    });
  });
});
