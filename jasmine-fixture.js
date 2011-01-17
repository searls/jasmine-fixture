/* jasmine-fixture Makes injecting HTML snippets into the DOM easy & clean!
 *  site: https://github.com/searls/jasmine-fixture   */
(function($){
	$.jasmine = {
		isReady: false,
		rootId: 'specContainer',
		init: function() {
			$('body').append('<div id="'+this.rootId+'"></div>');
			this.isReady = true;
		},
		inject:function(html) {
			if(this.isReady !== true) this.init();
      return $(html).appendTo('#'+this.rootId);
		},
		tidyUp: function() {
			$('#'+this.rootId).remove();
			this.isReady = false;
		}
	};	
})(jQuery);
jQuery(function($){
  $.jasmine.init();
});
afterEach(function(){
  $.jasmine.tidyUp();
});