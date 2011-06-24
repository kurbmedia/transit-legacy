//= depend_on transit/core
//= require transit/plugins/wymeditor
//= require transit/views/wym_box
//= require transit/views/wym_iframe
//= require transit/views/editor_toolbar

(function(transit){
	
	var Editor = function( element, instance_opts ){
		var defaults = {
			boxHtml: transit.templates.parse('transit/views/wym_box', { iframe: WYMeditor.IFRAME }),	
			iframeHtml: transit.templates.parse('transit/views/wym_iframe', { frame_index: WYMeditor.INDEX }),
			postInit: setup_instance
		},
		self    	= this,
		initialized = false,
		config  	= transit.config['richtext'],
		editor,
		editordoc;
		
		if( instance_opts ) config = transit.mergeConfigs( config, instance_opts );		
		config = $.extend({}, defaults, config);
		jQuery(element).wymeditor(config);
		
		editor = jQuery.wymeditors(jQuery(element).data('wym_index'));
		this.toolbar = WYMeditor.TRANSIT_TOOLBAR;
		this.editor  = editor;
		this.exec    = function( action ){ editor.exec( action ); return editor; };
		
		this.createLink = function( ){
			var selected = editor.selected(),
				uid		 = editor.uniqueStamp();
			if(selected && selected.tagName && selected.tagName.toLowerCase != WYMeditor.A){
				selected = jQuery(selected).parentsOrSelf(WYMeditor.A);
			}		      
			
		};
		
		this.insertImage = function( ){
			
		};
		
		function setup_instance( wym ){
			if( initialized ) return false;
			
			var parentbody  = jQuery('body'),
				editorbody  = jQuery(wym._doc).find('body'),
				docheight   = jQuery(wym._doc).height(),				
				iframe	    = jQuery(wym._iframe),
				box         = jQuery(wym._box);
				
			editordoc = jQuery(wym._doc);

			editorbody.css({
				'font-family': parentbody.css('font-family'),
				'font-size': parentbody.css('font-size'),
				'color': parentbody.css('color'),
				'line-height': parentbody.css("line-height")
			});
			
			if( docheight > 400 ) docheight = 400; 
			
			box.css({ height:docheight });
			iframe.css({ height:'100%' });
			
			editordoc.find('body')
				.bind('focus', function(e){
					self.toolbar.attach(self);
					WYMeditor.ACTIVE_INSTANCE = self;
				});
				
			parentbody.bind('click', function(e){ self.toolbar.release(self); });
			
			if( wym._index == 0 ){
				WYMeditor.ACTIVE_INSTANCE = self;
				WYMeditor.TRANSIT_TOOLBAR = new toolbar().init();
			}
			
			initialized = true;
			return true;
		}
		
		return self;		
	};

	transit.addContext('editor', Editor);
	
	jQuery(function(){
		jQuery('textarea.richtext_editor')
			.bind('transit:richtext', load_editor)
			.live('transit:richtext', load_editor)
			.trigger('transit:richtext');
	});
	
	// jQuery handler func
	
	function load_editor(event){
		jQuery(this).transit('editor');
	}
	
	

///// Toolbar

	var toolbar = function(){
		var button_list = [
			{ css:'bold', action:'Bold', title:'Bold' },
			{ css:'italic', action:'Italic', title:'Italic' },
			{ css:'underline', action:'Underline', title:'Underline' },
			{ css:'undo', action:'Undo', title:'Undo' },
			{ css:'redo', action:'Redo', title:'Redo' },
			{ css:'ordered_list', action:'InsertOrderedList', title:'Insert Ordered List' },
			{ css:'unordered_list', action:'InsertUnorderedList', title:'Insert Unordered List' },
			{ css:'insert_link', action:'createLink', title:'Insert Link' }
		],
		self    	= this,
		initialized = false,
		instance,
		element 	= jQuery(transit.templates.parse('transit/views/editor_toolbar', { buttons: button_list })),
		action_box;
		
		this.init = function(){
			if( initialized == true ) return self;
			element.appendTo( jQuery('body') ).hide();
			element.find('a')
				.bind('click', function( event ){
					event.preventDefault();
					if( event.isPropagationStopped() ) return true;
					
					event.stopPropagation();
					
					var button = jQuery(this),
						action = button.attr('rel');
					
					if( instance ){
						if( jQuery.isFunction(instance[action])) {
							instance[action].call();
						}else{
							instance.exec(action);
						}
					}
					return true;
				});
			element.bind('click', function(event){
				event.stopPropagation();
			});
			
			element.dialog({ 
				width:'auto', 
				title:'Edit Content',
				dialogClass:'transit_editor_button_dialog',
				minHeight:false,
				minWidth:false,
				autoOpen:false
			});
			
			instance    = jQuery.wymeditors(0);
			action_box  = element.find('#transit_editor_toolbar_action');
			action_box.dialog({
				width:'auto',
				dialogClass:'transit_editor_action_dialog',
				minHeight:false,
				minWidth:false,
				autoOpen:false
			});
			initialized = true;
			
			return self;
		};
		
		this.attach = function( editor ){
			instance = editor;
			element.dialog('open');
			return instance;
		};
		
		this.release = function(){
			element.dialog('close');
		};
		
	};
	
	
})(transit);