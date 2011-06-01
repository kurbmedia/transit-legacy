$(function(){
    
	var dialogs;
		
	$('body').bind('overlay:show', function(event, contents, callback) {
		var holder  = $(this), 
			content = $(contents),
			options = {
				top:   'center',
				left:  'center',
				close: 'a.close',
				speed: 50,
				mask: { color: null }
			};
			
		$.extend(options, { 
			load: true,
			onBeforeLoad:  function(){
				var overlay = this.getOverlay(), win = $(window);
				overlay.css({ left: ((win.width() / 2) - (overlay.width() / 2)) +"px" });
				return true;
			},
			onLoad: function(){
				var self = this;
				var overlay = this.getOverlay(), closer = overlay.find('a.close');
				closer.bind('click', function(event){
					event.preventDefault();
					overlay.overlay().close();
				});
				
				if ( $.isFunction(callback) ){
					callback.apply(self, [holder, content, callback]);
				}
			},
			onClose: function(){
				content.remove();
			}
		});

		holder.prepend(content);
		content.hide().overlay(options);
	});
	

});