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
      $('#'+this.rootId).append(html);
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