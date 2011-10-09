/* jasmine-fixture Makes injecting HTML snippets into the DOM easy & clean!
 *  site: https://github.com/searls/jasmine-fixture   */
(function($){
  var originalJasmineFixture = window.jasmineFixture;

  window.jasmineFixture = function($) {
    var isReady = false,
        rootId  = 'specContainer',
        defaults = {
          el:'div',
          cssClass:'',
          id:'',
          text: ''
        };

    $.jasmine = {
      inject: function(config,context) {
        if(isReady !== true) init();
        var parent = context ? context : $('#'+rootId);
        var $toInject;
        if (config && config.constructor === String) {
          if(config.indexOf('<') === -1) {
            $toInject = $('<div class="'+config+'"></div>');
          } else {
            $toInject = $(config);
          }
        } else {
          config = $.extend(defaults,config);
          $toInject = $('<'+config.el+' id="'+config.id+'" class="'+config.cssClass+'"></'+config.el+'>');
          if(config.text) {
            $toInject.text(config.text);
          }
        }
        return $toInject.appendTo(parent);
      },
      configure: function(config) {
        $.extend(defaults,config);
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
