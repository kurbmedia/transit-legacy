$(function(){
		
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
	
	$('#context_fields a.delete_field').live('click', function(){
		
	});

});