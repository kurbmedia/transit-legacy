//= require libs/underscore
//= require libs/spine
//= require transit/lib/core
//= require transit/config
//= require_directory ./transit/controllers
//= require_self

jQuery(function(){
	
	jQuery('*[data-transit-context]')
		.each(function(i, element){
			var self = jQuery(element),
				type = self.data('transit-context');
			Transit.build(type, self);
		});
		
	Transit.autoload('Video');
	
});

(function(jQuery){
	
	jQuery.fn.transit = function( name, options ){
		
		if( jQuery(this).data('transit.' + name )) 
			return jQuery(this).data('transit.' + name);
		
		if( typeof Transit.controllers[name] == 'undefined' ) 
			return this;
		
		this.each(function(i, el){
			var controller;
			if( jQuery(el).data('transit.' + name)) return true;

			controller = Transit.controllers[name].init(options);
			jQuery(el).data('transit.' + name, controller);
			
		});
		
		return this;
		
	};
	
})(jQuery);