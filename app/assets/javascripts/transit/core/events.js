////////////////////////////////
// Default event callbacks
////////////////////////////////

(function(transit){
	
	var ajax_indicator = "<div id='ajax_indicator'>Loading...</div>";
	transit.addTemplate('core/ui/ajax_indicator', ajax_indicator);
	
	transit.events = {
		register: function( name, callback ){
			this.cache[name] = callback;
		},
		trigger: function( name, scope, opts ){
			if( this.cache[name] ){
				if( typeof scope != 'undefined' && scope != false ){
					this.cache[name].apply(scope, Array.prototype.slice.call( arguments, 2 ));
				}else{
					this.cache[name].call(opts);
				}				
			}
		},
		
		cache: {}
	};

})(transit);

$(function(){
	
	$(document)
		.ajaxComplete(show_flash_messages);
	$('form')
		.live('ajax:complete', show_flash_messages)
		.bind('ajax:complete', show_flash_messages);
			
	function show_flash_messages(event, xhr, settings){
		if( !$.isFunction(transit.events.cache['ui.flash']) ){
			return true;
		}		
		var messages = xhr.getResponseHeader('X-Flash-Messages'), divs = [];
		if(!messages) return true;		
		messages = $.parseJSON(messages);
		$.each(messages, function(key, value){
			var div = $("<div></div>").addClass('flash_message')
						.addClass('flash_'+key)
						.addClass(key)
						.html(value);
			
			transit.events.trigger('ui.flash', false, div);
		});
		
		return true;
	}
	
});

// var indicator = $("<div id='ajax_indicator'>Loading...</div>"),
// 	hideshow  = $('div.panel h4');		
// 
// indicator
// 	.hide()
// 	.appendTo($('body'))
// 	.ajaxSend(function(event, XMLHttpRequest, settings){
// 		var self = $(this), h = self.outerHeight(true);
// 		self.css({ top:-h+"px", display:'block' })
// 			.animate({ top:"0px" }, 500);
// 	})
// 	.ajaxComplete(function(event){ 
// 		var self = $(this), h = self.outerHeight(true);
// 		self.animate({ top:-h+"px" }, 500, function(){ self.css({ display:'none' }); } ); 
// 	});