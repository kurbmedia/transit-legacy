//= require libs/underscore
//= require libs/spine
//= require transit/lib/core
//= require transit/config
//= require_self

jQuery(function(){
	
	jQuery('*[data-context-type]')
		.each(function(i, element){
			var self = jQuery(element),
				type = self.data('context-type');
			Transit.build(type, self);
		});
		
	Transit.autoload('Video');
	
});

(function(jQuery){
	
	jQuery.fn.transit = function( name, options ){
		
		var instance;
		
		if( jQuery(this).data('transit.' + name.toLowerCase() ) ){
			instance = jQuery(this).data('transit.' + name.toLowerCase() );
			if( typeof options != 'undefined' ){
				if( jQuery.type(options) == 'string' && jQuery.isFunction(instance[options]) ) instance[options]();
				else instance.configure( options );
			}
			return instance;
		}
				
		this.each(function(i, el){
			Transit.build( name, jQuery(el), options );			
		});
		
		return this;
		
	};
	
})(jQuery);