$(function() {
  $(document).on('shiny:connected', function(event) {
    Shiny.unbindAll();
    $.extend(Shiny
      .inputBindings
      .bindingNames['shiny.actionButtonInput']
      .binding, {
        reset: function(el) {
         $(el).data('val', 0);
        },
        subscribe: function(el, callback) {
          $(el).on('click.actionButtonInputBinding', function(e) {
            var $el = $(this);
            var val = $el.data('val') || 0;
            $el.data('val', val + 1);

            callback();
          });

          $(el).on('change.actionButtonInputBinding', function(e) {
            debugger;
            callback();
          });

        }
      });
    Shiny.bindAll();
  });

  $('#button1').on('click', function() {
    var $obj = $('#button2');
    var inputBinding = $obj.data('shiny-input-binding');
    var val = $obj.data('val') || 0;
    inputBinding.setValue($obj, val + 10);
    $obj.trigger('change');
  });

  $('#reset').on('click', function() {
    var $obj = $('#button2');
    var inputBinding = $obj.data('shiny-input-binding');
    inputBinding.reset($obj);
    $obj.trigger('change');
  });
});
