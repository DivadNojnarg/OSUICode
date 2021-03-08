$(function() {
  Shiny.addCustomMessageHandler('add-message-item', function(message) {
    // since we do not re-render the dropdown, we must update its item counter
    var $items = $('.dropdown-menu').find('.dropdown-item').length;
    $('.dropdown-item.dropdown-header').html($items + ' Items');
    $('.nav-item.dropdown').find('.navbar-badge').html($items);
    // convert string to HTML
    var itemTag = $.parseHTML(message)[0];
    $(itemTag).insertAfter($('.dropdown-item.dropdown-header'));
  });
});
