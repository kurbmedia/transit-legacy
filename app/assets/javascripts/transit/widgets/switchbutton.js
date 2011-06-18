//= require jqueryui/widget

(function($){
	
 	$.widget('ui.switchbutton', {
		options : {
			widgetEventPrefix: "switchbutton",
			addClasses: false,
			states: [ 'On', 'Off' ]
		},
		_wrapper: null,	
		_create: function() {
			var self = this,
				wrapper   = $("<span class='widget-holder widget-switchbutton' />");
				state_on  = $("<span class='widget-switch-button-on'></span>"),
				state_off = $("<span class='widget-switch-button-off'></span>");
			
			self.element.wrap(wrapper);						
			state_on.text(self.options.states[0])
						 .insertAfter(self.element);
			state_off.text(self.options.states[1])
						 .insertAfter(self.element);	
			
			self._wrapper = this.element.parent('span.widget-switchbutton');			
			
		},
		_init: function(){
			var self = this;
			self.element.css({ opacity:0 })
				.bind('click.switchbutton', function(event){
					self._wrapper.toggleClass('switchbutton-active', self.element.get(0).checked);
				}).trigger('click.switchbutton');
		},
		value: function() {
			return this.element.val();
		}
	});
	
})( jQuery );