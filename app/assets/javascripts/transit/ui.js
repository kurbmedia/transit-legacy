$(function(){
    
	var indicator = $("<div id='ajax_indicator'>Loading...</div>"),
		hideshow  = $('a.toggle_fieldset');		

	indicator
		.hide()
		.appendTo($('body'))
		.ajaxSend(function(event, XMLHttpRequest, settings){
			var self = $(this), h = self.outerHeight(true);
			self.css({ top:-h+"px", display:'block' })
				.animate({ top:"0px" }, 500);
		})
		.ajaxComplete(function(event){ 
			var self = $(this), h = self.outerHeight(true);
			self.animate({ top:-h+"px" }, 500, function(){ self.css({ display:'none' }); } ); 
		});
	
	hideshow
		.toggle(function(){
			$(this).parent('fieldset').find('div.toggle_area').slideUp('fast');
		}, 
		function(){
			$(this).parent('fieldset').find('div.toggle_area').slideDown('fast');
		});
		
	$('#context_fields').sortable({handle:'h4', revert:true, start:capture_richtext, beforeStop:sort_fields});

	function capture_richtext(event, ui){
		var area = ui.item.find('textarea:first');
		if(area.length > 0){
			$(area).wysiwyg('save').wysiwyg('destroy');
		}
	}

	function sort_fields(event, ui){		
		create_editors();
		$('#context_fields li.field').each(function(i, el){
			var self = $(el), index_field = self.find('input[rel="field_position"]:first');
			$(index_field).val(i);
		});
	}

});