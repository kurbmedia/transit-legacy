// Default transit core file.
//= require_self
//= require transit/config

(function($){
	
	var transit;
	
	if( typeof window.transit != 'undefined' ){ return true; }
	
	if ( typeof $ === "undefined" || $ !== window.jQuery ){
		$.error("jQuery not found. Please include jQuery prior to including motr.js.");
		return false;
	}
	
	transit = window.transit = function(){
		
		this.config   = {};
		this.contexts = {};
		
		this.addContext = function( name, plugin ){
			this.contexts[name] = plugin;
			if( $.isFunction( plugin.ready ) ){
				$(plugin.ready);
			}
			return this;
		};
		
		this.configure = function( namespace, conf ){			
			var old_conf = this.config[namespace] || {};			
			this.config[namespace] = $.extend( old_conf, conf );
		};
		
		/**
         * Plugin extension functionality
         *
         * @param namespace String - Namespace of the plugin
         * @param obj Object - Plugin definition
         *
         * @return void
         */
        this.extend = function(namespace, plugin){
			
            if (typeof this[namespace] != "undefined"){
				$.error(["Plugin namespace '",namespace,"' is already taken..."].join);
				return this;
			}
		
			this[namespace] = plugin;
			return this;
			
        };		

		this.load = function( namespace ){
			return this[namespace];
		};
		
	};
	
	window.transit = new transit();
	return window.transit;


})(jQuery);