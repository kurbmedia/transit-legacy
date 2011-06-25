//= require transit/views/wym_iframe
//= require transit/views/wym_box

(function(transit){
	
	var editor, toolbar, proper, active_editor; 
	
	editor = function( element, options ){
		var self = this,
			tag  = jQuery(element)[0].tagName;
			
		if( (/[h1|h2|h3|h4|h5|h6]/i).test(tag) ) return new editor.inline( jQuery(element), options );
		else return new editor.richtext( jQuery(element), options );
		
		return self;
	};
	
 	proper = new Proper();
	
	
	editor.richtext = function( element, options ){
		
		var config = transit.merge(transit.config['richtext'], options),
			editor, initialized = false;
			
		config.postInit   = setup_instance;
		config.boxHtml    = transit.template.parse('transit/views/wym_box', { iframe: WYMeditor.IFRAME }),	
		config.iframeHtml = transit.template.parse('transit/views/wym_iframe', { frame_index: WYMeditor.INDEX }),
		
		jQuery(element).wymeditor(config);		
		editor = jQuery.wymeditors(jQuery(element).data('wym_index'));
		
		
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
					active_editor = self;
				});
							
			if( wym._index == 0 ) active_editor = self;
			
			initialized = true;
			return true;
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
			
	};
	
	transit.context.add('editor', editor);
		
	
})(transit);