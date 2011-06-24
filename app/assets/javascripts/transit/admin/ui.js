//= require jqueryui/button
//= require jqueryui/accordion

$(function(){
	
	var post_sidebar = $('#edit_post_sidebar');
	
	$('#transit_toolbar .transit_toolbar_button, input.toggle_button, a.ui-button').each(
		function(i, el){
			var self = $(el),
				icon = self.data('ui-icon');
				opts = {};
			if( icon ){
				if( !(/ui-icon/i).test(icon) ) icon = "ui-icon-"+icon;
				opts.icons = { primary:icon };
			}
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
	
	post_sidebar.accordion({header:'h4', autoHeight:false })
		.find('div')
		.bind('resize', function(event){
			post_sidebar.accordion("resize");
		});
	
});