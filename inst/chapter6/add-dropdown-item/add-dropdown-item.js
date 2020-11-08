$(function() {
  Shiny.addCustomMessageHandler('add-dropdown-item', function(message) {
    // convert string to HTML
    var itemTag = $.parseHTML(message)[0];
    $(itemTag).insertBefore($('.dropdown-item.dropdown-footer'));
    // since we do not re-render the dropdown, we must update its item counter
    var $items = $('button.dropdown-item').length;
    $('.dropdown-item.dropdown-header').html($items + ' Items');
    $('.nav-item.dropdown').find('.navbar-badge').html($items);
  });
});
