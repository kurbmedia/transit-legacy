$(function(){
    
	var indicator = $("<div id='ajax_indicator'>Loading...</div>");

	indicator
		.hide()
		.appendTo($('body'))
		.ajaxSend(function(event, XMLHttpRequest, settings){
			var self = $(this), h = self.outerHeight(true);
			self.css({ top:-h+"px", display:'block' })
				.animate({ top:"0px" }, 500);
		})
		.ajaxComplete(function(event){ 
			var self = $(this), h = self.outerHeight(true);
			self.animate({ top:-h+"px" }, 500, function(){ self.css({ display:'none' }); } ); 
		});
	

});