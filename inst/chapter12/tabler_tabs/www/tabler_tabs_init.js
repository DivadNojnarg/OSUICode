$(function() {
  // this makes sure to trigger the show event on the active   tab at start
  let activeTab = $('#navbar-menu .nav-link.active');
  // if multiple items are found
  if (activeTab.length > 0) {
    let tabId = $(activeTab).attr('data-value');
    $(activeTab).tab('show');
    $(`#${tabId}`).addClass('show active');
  } else {
    $('#navbar-menu .nav-link')
    .first()
    .tab('show');
  }
});
