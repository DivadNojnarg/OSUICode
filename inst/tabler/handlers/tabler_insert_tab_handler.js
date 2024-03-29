$(function() {
  Shiny.addCustomMessageHandler('insert-tab-1', function(message) {
    // define div and li targets
    let $divTag = $(message.content);
    let $liTag = $(message.link);

    if (message.position === 'after') {
      $divTag.insertAfter($('#' + message.target));
      $liTag.insertAfter($('[data-target ="#' + message.target + '"]').parent());
    } else if (message.position === 'before') {
      $divTag.insertBefore($('#' + message.target));
      $liTag.insertBefore($('[data-target ="#' + message.target + '"]').parent());
    }

    if (message.select) {
      // trigger a click on corresponding the new tab button.
      let newTabId = $divTag.attr('id');
      $('#' + message.inputId + ' a[data-target="#' + newTabId +'"]').tab('show');
    }
  });


  Shiny.addCustomMessageHandler('insert-tab-2', function(message) {
    console.log(message.content.deps);
    // define div and li targets
    let $divTag = $(message.content.html);
    let $liTag = $(message.link.html);

    if (message.position === 'after') {
      $divTag.insertAfter($('#' + message.target));
      $liTag.insertAfter($('[data-target="#' + message.target + '"]').parent());
    } else if (message.position === 'before') {
      $divTag.insertBefore($('#' + message.target));
      $liTag.insertBefore($('[data-target="#' + message.target + '"]').parent());
    }

    // needed to render input/output in newly added tab. It takes the possible
    // deps and add them to the tag. Indeed, if we insert a tab, its deps are not
    // included in the page so it can't render properly
    Shiny.renderContent($liTag[0], {html: $liTag.html(), deps: message.link.dependencies});
    Shiny.renderContent($divTag[0], {html: $divTag.html(), deps: message.content.dependencies});

    if (message.select) {
      // trigger a click on corresponding the new tab button.
      let newTabId = $divTag.attr('id');
      $('#' + message.inputId + ' a[data-target="#' + newTabId +'"]').tab('show');
    }
  });
});
