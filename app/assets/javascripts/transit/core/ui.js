//= require_self
//= require_tree ./ui

(function(jQuery){
	
	var UI = function(){
		
		var api = {
			init:   function(){},
			configure: function( user_opts ){
				this.options = $.extend({}, this.options, user_opts);
			},
			options:{}
		},
		modules = {},
		enabledItems = [];
		
		this.enable = function( name, options ){
						
			if( $.type(name) == "array" ){				
				$.each( name, function( ind, n ){
					if( $.inArray(n, enabledItems) == -1 ){
						enabledItems.push(n);
					}
				});
				
			}else{
				if( options ){
					modules[name].configure( options );
				}				
				if( !$.inArray(name, enabledItems) ){
					enabledItems.push(name);
				}
			}			
			return true;
		};
		
		this.register = function( name, plugin ){
			modules[name] = $.extend({}, api, plugin);
		};
		
		this.activate = function(){
			$.each( enabledItems, function( ind, name ){
				modules[name].init.apply(modules[name]);
			});
			return enabledItems;
		};
		
		this.list = function(){
			return modules;
		}
		
	};
	
	transit.ui = new UI();
	transit.onReadyCallbacks.push( transit.ui.activate );
	
})(jQuery);