/**
 * transit.js
 * Copyright (c) 2011 by Brent Kirby / kurb media llc
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
(function(){
	
	var root 	= this,
		transit = root.transit = {};
	
	transit.VERSION 	= '0.0.1';
	transit.config  	= {};
	
	//
	// Add configuration data
	//
	transit.configure = function( name, conf ){
		var old_conf = this.config[name] || {};
		this.config[name] = jQuery.extend(this.config[name], conf);
	};
	
	//
	// Manage editable / viewable contexts.
	//
	transit.context = new function(){
		var cache = [],
			self  = this;
		
		jQuery.extend(self , {
			// Add a new context			
			add: function( name, api ){
				this[ name ] = api;
				cache.push(name);
				return api;
			},
			
			exists: function( name ){
				return _.contains( cache, name );
			},
			
			// Parse the serialize json data within the 
			// element's data-context-options attribute.
			data: function( dom ){
				var element  = jQuery(dom), 
					json_str = unescape(element.data('context-options'));
				return (new Function("return " + json_str))();
			}
		});
		
	};
	
	//
	// Shortcut method to jQuery.extend where
	// options are to be updated not overwritten
	//
	transit.merge = function( oldconf, newconf ){
		return jQuery.extend( {}, oldconf, newconf );
	};
	
	//
	// The ui api includes various utility functions
	// and functionality like form validation etc.
	//
	transit.ui = {};
	
	//
	// Wrapper / helper for underscore's template method.
	// It allows caching of templates, and processing/reprocessing.
	//
	transit.template = (function(){
		
		var cache  = {},
			parsed = {},
			tpl    = function(){
			
			// Store a parsed template for later use
			this.store = function( name, data ){
				parsed[name] = this.parse( cache[name], data );
			};
			
			// Load a previously parsed template
			this.load = function( name ){
				if( parsed[name] ){
					return parsed[name];
				} else {
					return false; 
				}
			};
			
			// Store a html template in the cache 
			// to be parsed later.
			// Returns template object for immediate parsing
			//
			this.add = function( name, html ){
				cache[name] = html;
				return this;
			};
			
			// Parse a cached template with supplied data
			this.parse = function( name, data ){
				return _.template( cache[name], data );
			};
			
			// Render a template with data immediately, without
			// having previously saved a template.
			this.render = function( html, data ){
				return _.template( html, data );
			};
			
		};
		
		return new tpl();
		
	})();

}).call(this);

(function( $, undefined){
	
	jQuery.fn.transit = function( method, options ){
		
		var exist = jQuery(this).data('transit.' + method );
		
		if( exist ){
			if( jQuery.type( options ) == 'string' && jQuery.isFunction( exist[ options ] )){
				return exist[ options ]();
			}else return jQuery(this).data('transit.' + method );
		}	
		
		if( transit.context.exists( method ) ) {			
			jQuery.each(this, function(i, element) {
				var instance = new transit.context[ method ]( jQuery(element), options );
				jQuery(element).data('transit.' + method, instance);
			});
						
			return this;
		} 
	};
	
	
})(jQuery);