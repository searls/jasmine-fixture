/* jasmine-fixture Makes injecting HTML snippets into the DOM easy & clean!
 *  site: https://github.com/searls/jasmine-fixture   */
(function($){
  var originalJasmineFixture = window.jasmineFixture,
      defaultConfiguration = {
        el:'div',
        cssClass:'',
        id:'',
        text: '',
        defaultAttribute: 'class'
      };

  window.jasmineFixture = function($) {
    var isReady = false,
        rootId  = 'specContainer',
        defaults = $.extend({},defaultConfiguration);

    $.jasmine = {
      inject: function(arg,context) {
        if(isReady !== true) init();
        var parent = context ? context : $('#'+rootId),
            $toInject;
        if(itLooksLikeHtml(arg)) {
          $toInject = $(arg);
        } else {
          var config = $.extend({},defaults,arg,{ userString: arg });
          $toInject = $('<'+config.el+'></'+config.el+'>');
          applyAttributes($toInject,config);
          if(config.text) {
            $toInject.text(config.text);
          }
        }
        return $toInject.appendTo(parent);
      },
      configure: function(config) {
        $.extend(defaults,config);
      },
      restoreDefaults: function(){
        defaults = $.extend({},defaultConfiguration);
      },
      noConflict: function() {
        window.jasmineFixture = originalJasmineFixture;
        return this;
      }
    };

    $.fn.inject = function(html){
      return $.jasmine.inject(html,$(this));
    };

    var applyAttributes = function($html,config) {
      var attrs = {
        id: config.id,
        'class': config['class'] || config.cssClass
      };
      if(isString(config.userString)) {
        attrs[config.defaultAttribute] = config.userString;
      }
      for(var key in attrs) {
        if(attrs[key]) {
          $html.attr(key,attrs[key]);
        }
      }
    };

    var itLooksLikeHtml = function(arg) {
      return isString(arg) && arg.indexOf('<') !== -1
    };

    var isString = function(arg) {
      return arg && arg.constructor === String;
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
