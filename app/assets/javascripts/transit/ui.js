$(function(){
    
	var indicator = $("<div id='ajax_indicator'>Loading...</div>"),
		hideshow  = $('div.panel h4');		

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
	
	hideshow.bind('click', function(event){
		event.preventDefault();
		var mover = $(this).parent('div.panel');
		if( mover.hasClass("closed") ){
			mover.removeClass('closed', 'fast');
		} else {
			mover.addClass("closed", 'fast');
		}
	});
});