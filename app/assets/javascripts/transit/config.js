///////////////////////////////////
// Default configuration data
///////////////////////////////////

(function(transit){
	
	transit.configure('context.video', { 
		image:    '',
		movie:    '',
		autoplay:  'false',
		loop:      'false',
		autohide:  'false',
		fullscreen: 'true',
		color_text: "0xffffff",
		color_seekbar: "0x108194",
		color_loadingbar: "0xe4f2f6",
		color_seekbarbg: "0x108194",            
		color_button_out: "0x108194",
		color_button_over: "0xd15245",
		color_button_highlight: "0xffffff" 
	});
	
	transit.configure('context.text', {
		basePath:'/assets/', 
		skin:'compact',
		toolsItems: [
		    // {'name': 'Bold', 'title': 'Strong', 'css': 'wym_tools_strong'}, 
		    // {'name': 'Italic', 'title': 'Emphasis', 'css': 'wym_tools_emphasis'},
		    // {'name': 'InsertOrderedList', 'title': 'Ordered_List', 'css': 'wym_tools_ordered_list'},
		    // {'name': 'InsertUnorderedList', 'title': 'Unordered_List', 'css': 'wym_tools_unordered_list'},
		    // {'name': 'Undo', 'title': 'Undo', 'css': 'wym_tools_undo'},
		    // {'name': 'Redo', 'title': 'Redo', 'css': 'wym_tools_redo'},
		    // {'name': 'CreateLink', 'title': 'Link', 'css': 'wym_tools_link'},
		    // {'name': 'Unlink', 'title': 'Unlink', 'css': 'wym_tools_unlink'},
		    // {'name': 'InsertImage', 'title': 'Image', 'css': 'wym_tools_image'},
		    // {'name': 'Paste', 'title': 'Paste_From_Word', 'css': 'wym_tools_paste'}
		  ],
		containersItems: [],
		classesItems: [],		
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
			$(wym._element).trigger("transit:track_editor", [wym]);
			
		  }
	});
	
})(transit);