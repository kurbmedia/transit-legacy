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
				
	};
	
	window.transit = new transit();
	return window.transit;


})(jQuery);