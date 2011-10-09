/* jasmine-fixture Makes injecting HTML snippets into the DOM easy & clean!
 *  site: https://github.com/searls/jasmine-fixture   */
(function($){
  var originalJasmineFixture = window.jasmineFixture;

  window.jasmineFixture = function($) {
    var isReady = false,
        rootId  = 'specContainer';

    $.jasmine = {
      inject: function(html,context) {
        if(isReady !== true) init();
        var parent = context ? context : $('#'+rootId);
        var injected;
        if(html.indexOf('<') === -1) {
          injected = $('<div class="'+html+'"></div>').appendTo(parent);
        } else {
          injected = $(html).appendTo('#'+rootId);
        }

        return injected;
      },
      noConflict: function() {
        window.jasmineFixture = originalJasmineFixture;
        return this;
      }
    };

    $.fn.inject = function(html){
      return $.jasmine.inject(html,$(this));
    };

    var init = function() {
      $('body').append('<div id="'+rootId+'"></div>');
      isReady = true;
    };

    var tidyUp = function() {
      $('#'+rootId).remove();
      isReady = false;
    };

    $(function(jQuery){
      init();
    });
    afterEach(function(){
      tidyUp();
    });

    return $.jasmine;
  };

  if(jQuery) {
    window.jasmineFixture(jQuery)
  }
})(jQuery);
