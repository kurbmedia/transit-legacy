// Default transit core file.
//= require underscore
//= require_self
//= require transit/config
//= require_tree ./core

(function($){
	
	var transit;
	
	if( typeof window.transit != 'undefined' ){ return true; }
	
	if ( typeof $ === "undefined" || $ !== window.jQuery ){
		$.error("jQuery not found. Please include jQuery prior to including motr.js.");
		return false;
	}
	
	transit = window.transit = function(){
		
		this.config    = {};
		this.contexts  = {};
		this.callbacks = {};
		this.paths	   = {};
		
		this.templates = {
			parse: function( name, data ){
				return this.cache[name](data);
			},
			cache: {}
		};
		
		this.configure = function( namespace, conf ){			
			var old_conf = this.config[namespace] || {};			
			this.config[namespace] = $.extend( old_conf, conf );
		};
		
		this.addTemplate = function( pathOrName, content){
			this.templates.cache[pathOrName] = _.template(content);
		};
		
		this.addCallback = function( eventName, func ){
			
		};
		
		this.addContext = function( name, api ){
			this.contexts[name] = api;
		};
		
		this.mergeConfigs = function( oldconf, newconf ){
			return $.extend({}, oldconf, newconf);
		};
		
		this.parseContextData = function( object ){
			var element  = jQuery(object), 
				json_str = unescape(element.data('context-options'));
			return (new Function("return " + json_str))();
		};
		
		this.onReadyCallbacks = [];
				
	};
	
	window.transit = new transit();	
	return window.transit;


})(jQuery);

(function(jQuery, undefined){
	
	jQuery.fn.transit = function( method, options ){

		if( jQuery.isFunction(transit.contexts[method]) ) {
			
			var tdata = jQuery(this).data("transit_"+ method);
			if( tdata ) return tdata;
			this.each( function(i, element) {	
				var item     = transit.contexts[method],
					instance = new item( jQuery(element), options );				
				jQuery(this).data("transit_" + method, instance);
			});
						
			return this;
		} 
	};
	
	
})(jQuery);