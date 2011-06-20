$('form[data-js-validatable]').validator({lang:'en', errorInputEvent:'blur', inputEvent:'blur', effect:'rails'});
(function(transit){
	
	var UI = function(){
		
		var api = {
			init:   function(){},
			configure: function( user_opts ){
				this.options = $.extend({}, this.options, user_opts);
			},
			options:{}
		},
		modules,
		enabledItems = [];
		
		this.enable = function( name, options ){			
			if( typeof this[name] == 'undefined') return false;
			this[name].configure( options );
			if( !$.inArray(name, enabledItems) ){
				enabledItems.push(name);
			}
			return true;
		};
		
		this.register = function( name, plugin ){
			modules[name] = $.extend({}, options, api);
		};
		
		this.activate = function(){
			$.each( enabledItems, function( ind, name ){
				this[name].init();
			});
		};
		
	};
	
	transit.ui = new UI();
	
	var ajax_indication = {
		options: {
			template: "<div id='ajax_indicator'>Loading...</div>",
			location: 'top'	
		},
		
		init: function(){
			this.indicator = $(this.options.template);
			this.indicator.hide()
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
		}
	};
	
	var form_validation = {
		options: {
			selectors: 'form.validate, form[data-js-validatable]'
		},
		
		init: function(){
			
		}
	};
	
})(transit);

$(function(){
	transit.ui.activate();	
});