//= require transit/plugins/wymeditor
//= require transit/views/wym_box
//= require transit/views/wym_iframe
//= require transit/views/editor_toolbar

$(function(){
	var content_opts = {
			boxHtml: transit.templates.parse('transit/views/wym_box', { iframe: WYMeditor.IFRAME }),	
			iframeHtml: transit.templates.parse('transit/views/wym_iframe', { frame_index: WYMeditor.INDEX })
		},
		active_editor, 
		button_list = [
			{ css:'bold', action:'Bold', title:'Bold' },
			{ css:'italic', action:'Italic', title:'Italic' },
			{ css:'underline', action:'Underline', title:'Underline' },
			{ css:'undo', action:'Undo', title:'Undo' },
			{ css:'redo', action:'Redo', title:'Redo' },
			{ css:'ordered_list', action:'InsertOrderedList', title:'Insert Ordered List' },
			{ css:'unordered_list', action:'InsertUnorderedList', title:'Insert Unordered List' },
			{ css:'insert_link', action:'', title:'Insert Link' },
			{ css:'insert_image', action:'', title:'Insert Image' }
		],
		toolbar = $(transit.templates.parse('transit/views/editor_toolbar', { buttons: button_list })),
		toolbar_dialog;
		
	if( $('textarea.richtext_editor').length >= 1){
		toolbar.appendTo($('body')).hide();
	}
	
	$('textarea.richtext_editor')
		.bind('transit:track_editor', function(event, editor){
			var self  = $(this), 
				index = editor._index,
				doc   = $(editor._doc);
			self.data('editor-instance-id', index);
			doc.find('body')
				.bind('focus', function(e){
					active_editor = jQuery.wymeditors(index);
					enable_toolbar();
				});
			$('body').bind('click', function(e){
				disable_toolbar();
			});
			
			if( editor._index == 0 ){
				active_editor = editor;
				setup_toolbar();
			}
				
		})
		.wymeditor($.extend({}, transit.config['context.text'], content_opts));
		

	function find_wrapper(){
		return $(active_editor._element[0]).parent('li.field');
	}
	
	function get_toolbar_position(){
		var position = {},
			parent   = $(find_wrapper());
		return [
			(parent.offset().top - $(window).scrollTop()) - 100,
			parent.offset().left
		]
	}
	
	function exec(event){		
		event.preventDefault();
		if( event.isPropagationStopped() ) return true;
		event.stopPropagation();
		var self = $(this);
		
		if( self.attr('rel') === "") return true;
		active_editor.exec(self.attr('rel'));
		return true;
	}
	
	function setup_toolbar(){
		var parent = $(find_wrapper());
		toolbar.dialog({ 
			width:'auto', 
			title:'Edit Content', 
			position: get_toolbar_position(),
			dialogClass:'transit_editor_button_dialog',
			minHeight:false,
			minWidth:false,
			autoOpen:false
		});
	}
	
	function enable_toolbar(){
		var parent = $(find_wrapper()),
			position_data = [(parent.offset().top - toolbar.outerHeight(true) + 5), parent.offset().left];
		toolbar.dialog("open").offset(position_data);
			
		toolbar.find('a').bind('click', exec);
		toolbar.bind('click', function(event){
			event.stopPropagation();
		});
	}
	
	function disable_toolbar(){
		toolbar.dialog('close');
	}
	
});

// 	position:'fixed',
// 	top: parent.offset().top - toolbar.outerHeight(true) + 5,
// 	left: parent.offset().left,
// 	width: parent.outerWidth(true)
// });
