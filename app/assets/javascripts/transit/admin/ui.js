//= require jqueryui/button

$(function(){
	
	$('#transit_toolbar .transit_toolbar_button, input.toggle_button').each(
		function(i, el){
			var self = $(el),
				icon = self.data('ui-icon');
				opts = {};
			if( icon ) opts.icons = { primary:icon };
			$(el).button(opts);
		});
	
	
	$('*.inherits_styles').each(
		function( ind, ele ){
			var self   = $(ele),
				fields = self.find('input[type="text"]');
			fields.css(inherit_default_styles(self, ['color', 'font-family', 'font-size']));
			fields.css({ margin:'0px', padding:'0px', width:'100%' });
		});	
	
	function inherit_default_styles(parent, styles){
		var new_css = {},
			options = styles || ['color', 'font-family', 'font-size', 'line-height'];
		$.each(options, function( i, style ){
			new_css[style] = parent.css(style);
		});
		
		return new_css;
	}
	
});