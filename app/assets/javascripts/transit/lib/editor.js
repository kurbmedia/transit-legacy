//= require transit/views/wym_iframe
//= require transit/views/wym_box
//= require transit/views/editor_toolbar

(function(transit){
	
	var editor, editor_toolbar, proper, active_editor, richtext_buttons; 
	
	editor = function( element, options ){
		var self = this,
			tag  = jQuery(element)[0].tagName;
		
		if( (/[h1|h2|h3|h4|h5|h6]/i).test(tag) ) return new editor.inline( jQuery(element), options );
		else return new editor.richtext( jQuery(element), options );
		
		return self;
	};
	
 	proper = new Proper();
	richtext_buttons = {
		bold: { action:'Bold', title:'Bold' },
		italic: { action:'Italic', title:'Italic' },
		underline: { action:'Underline', title:'Underline' },
		undo: { action:'Undo', title:'Undo' },
		redo: { action:'Redo', title:'Redo' },
		ordered_list: { action:'InsertOrderedList', title:'Insert Ordered List' },
		unordered_list: { action:'InsertUnorderedList', title:'Insert Unordered List' },
		insert_link: { title:'Insert Link' },
		unlink: { title:'Unlink', action:'Unlink' },
		insert_image: { title:'Insert Image' }
	};
	
	editor_toolbar = function(){
		var content     = jQuery(transit.template.parse('transit/views/editor_toolbar', { buttons: richtext_buttons })),
			initialized = false,
			self 		= this,
			widget;
			
		this.init = function( parent ){
			if( initialized ) return true;
			content.find('li a').bind('click', this.exec);
			content.insertBefore( parent );
			initialized = true;
			return true;
		};
		
		this.exec = function( event ){
			var btn = jQuery(this), button;
			event.preventDefault();
			if( event.isPropagationStopped() ) return true;
			event.stopPropagation();
			
			button = richtext_buttons[ btn.attr('rel') ];

			if( button.action ) instance.exec( button.action );
			else instance[ btn.attr('rel') ].call();
			return true;
			
		};
	};
	
	
	editor.richtext = function( element, options ){
		
		var config = transit.merge(transit.config['richtext'], options),
			editor, initialized = false,
			self = this
			toolbar;
			
		config.postInit   = setup_instance;
		config.boxHtml    = transit.template.parse('transit/views/wym_box', { iframe: WYMeditor.IFRAME });
		config.iframeHtml = transit.template.parse('transit/views/wym_iframe', { frame_index: WYMeditor.INDEX });
		
		jQuery(element)
			.wymeditor(config)
			.bind( "transit:update_richtext", update_callback );
			
		editor = jQuery.wymeditors(jQuery(element).data('wym_index'));
		
		this.exec = function( cmd ){
			editor._exec( cmd );
			return true;
		};
		
		this.save = function(){
			editor.update();
		};
		
		this.insert_link = function( options ){
			var href  = prompt('Enter the URL to link to:'),
				stamp = editor.uniqueStamp(),
				link;
				
			editor._exec(WYMeditor.CREATE_LINK, stamp);
			link = jQuery("a[href=" + stamp + "]", editor._doc.body);
			link.attr('href', href);
		};
		
		this.insert_image = function( options ){
			
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
					e.stopPropagation();
					active_editor = self;
				})
				.bind('blur', function(e){
					editor.update();
				});
							
			if( wym._index == 0 ) active_editor = self;
			
			toolbar = new editor_toolbar();
			toolbar.init( jQuery(wym._box) );
			
			initialized = true;
			return true;
		}
		
		function update_callback( event, method, options ){
			if( active_editor != self || event.isPropagationStopped() ) return true;
			self[ method ].call( options );
		}
		
	};
	
	//
	// The inline editor handles editing content within headings.
	// Add the class .transit-editable to the heading, and set its rel attribute
	// to match the form field that is to be updated on change.
	//
	editor.inline = function( element, options ){
		
		var target = jQuery('#'+ element.attr('rel')),
			conf   = transit.merge({ markup: false, multiline: false }, options);
		
		element
			.bind('click', function( event ){
				event.preventDefault();
				proper.activate( element, conf );
			})
			.bind('blur', function( event ){
				if( target.length > 0 ) target.val( proper.content() );
			});
			
			if( target.val() == "" ) target.val( element.text() );
			
	};
	
	transit.context.add('editor', editor);
		
	
})(transit);