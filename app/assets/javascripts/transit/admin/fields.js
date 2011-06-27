jQuery(function(){
	
	var dp   	 		= jQuery('div.datepicker'),
		name 	 	  	= dp.attr('rel'),
		month_select 	= jQuery('#'+name+"_2i"),
		day_select 		= jQuery('#'+name+"_3i"),
		year_select		= jQuery('#'+name+"_1i");
	

	jQuery('.transit-editable').transit('editor');
	
	if( dp.length > 0 ){
		
		dp.datepicker({
			dateFormat: 'yy-m-d',
			defaultDate: [year_select.val(), month_select.val(), day_select.val()].join("-").toString(),
			onSelect: function( dateText, input ){
				var date_opts = dateText.split("-");
				year_select.val(date_opts[0]);
				month_select.val(date_opts[1]);
				day_select.val(date_opts[2]);
			}
		});
	}
	
	jQuery('#post_edit').bind('submit', function( event ){
		var i, inst;		
		for( i = 0; i < jQuery.wymeditors.length, i++; ){
			jQuery.wymeditors(i).update();
		}
		return true;
	});
	
	jQuery('#post_default_image').fileinput({ buttonText:'', inputText: 'Choose an image' });
	
});