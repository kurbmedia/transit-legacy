$(function(){
    
	var pstyle_obj = $("<p>inherited content paragraph</p>"),
		pstyles; 
		
	$('h1.inheritable, div.inheritable').each(
		function( ind, ele ){
			var self   = $(ele),
				fields = self.find('input[type="text"]');
			fields.css(inherit_default_styles(self, ['color', 'font-family', 'font-size']));
		});
		
	$('textarea.inheritable').each(function(i, el){
		var self = $(el);
		pstyle_obj.insertAfter(self);
		self.css(inherit_default_styles(pstyle_obj));
		pstyle_obj.remove();
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