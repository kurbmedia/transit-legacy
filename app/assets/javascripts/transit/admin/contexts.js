jQuery(function(){
	
	var listing = jQuery('#context_list'),
		form    = listing.closest('form'),
		options = {
			title: 'Options',
			autoOpen: false,
			draggable: true,
			resizable: false,
			dialogClass: 'transit_context_dialog',
			minWidth: false,
			minHeight: false
		};
	
	listing
		.bind("context:added", add_new_context)
		.bind("context:destroyed", remove_context);
	
	listing.find('li.field').each( function(i, item ){
		var item = jQuery(item), panel;
		if( item.hasClass('field_text') ) return true;
		
		panel = item.find('div.toolbar') 
		panel.dialog( options );
		item.bind('mouseover', function( event ){
				item.addClass('ui-state-hover');
			})
			.bind('mouseout', function( event){
				item.removeClass('ui-state-hover');
			})
			.bind('click', function( event ){
				panel.dialog('open');
			});
		
	});
	
	function add_new_context( event, content, type ){
		var toolbar;
		if( (/text/i).test(type) ) return true;
		
		content = jQuery(content);
		toolbar = jQuery(content.filter('div.toolbar'));		
		toolbar.dialog( options );
		listing.append(content);
		
	}
	
	function remove_context( event, target ){
		
	}
		
});