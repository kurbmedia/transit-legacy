//= require transit/core
//= require_tree ./widgets
//= require_tree ./plugins
//= require_tree ./contexts
//= require_self
//= require transit/ui
//= require_tree ./admin

$(function(){
	
	// var editable_defaults = {
	// 	excludes: ['fontname', 'FontSize', 'forecolor', 'backcolor', 'justifyleft', 'justifycenter',
	// 			   'justifyright', 'justifyfull', 'insertheading1', 'insertheading2', 'insertheading3', 'insertheading4']
	// }
	
	$('textarea.richtext_editor').wymeditor({
		basePath:'/assets/', 
		skin:'compact',
		toolsItems: [
		    {'name': 'Bold', 'title': 'Strong', 'css': 'wym_tools_strong'}, 
		    {'name': 'Italic', 'title': 'Emphasis', 'css': 'wym_tools_emphasis'},
		    {'name': 'InsertOrderedList', 'title': 'Ordered_List', 'css': 'wym_tools_ordered_list'},
		    {'name': 'InsertUnorderedList', 'title': 'Unordered_List', 'css': 'wym_tools_unordered_list'},
		    {'name': 'Undo', 'title': 'Undo', 'css': 'wym_tools_undo'},
		    {'name': 'Redo', 'title': 'Redo', 'css': 'wym_tools_redo'},
		    {'name': 'CreateLink', 'title': 'Link', 'css': 'wym_tools_link'},
		    {'name': 'Unlink', 'title': 'Unlink', 'css': 'wym_tools_unlink'},
		    {'name': 'InsertImage', 'title': 'Image', 'css': 'wym_tools_image'},
		    {'name': 'Paste', 'title': 'Paste_From_Word', 'css': 'wym_tools_paste'}
		  ],
		containersItems: [],
		classesItems: [],
		boxHtml:   "<div class='wym_box'>"
	              + "<div class='wym_area_main'>"
	              + WYMeditor.IFRAME
	              + "</div>"
	              + "<div class='wym_area_bottom'>"
	              + "</div>"
	              + "</div>",
		iframeHtml:"<div class='wym_iframe wym_section'>"
	              + "<iframe src='javascript:false;'"
	              + "onload='this.contentWindow.parent.WYMeditor.INSTANCES["
	              + WYMeditor.INDEX + "].initIframe(this)'"
	              + "></iframe>"
	              + "</div>",
		postInit: function(wym) {
			var parentbody  = $('body'),
				editorbody  = $(wym._doc).find('body'),
				docheight   = $(wym._doc).height();
			
			editorbody.css({
				'font-family': parentbody.css('font-family'),
				'font-size': parentbody.css('font-size'),
				'color': parentbody.css('color'),
				'line-height': parentbody.css("line-height")
			});
			
			if( docheight > 400 ) docheight = 400; 
			wym._box.css({ height:docheight });
			$(wym._iframe).css({ height:'100%' });
			
		  }
	});
	
	
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