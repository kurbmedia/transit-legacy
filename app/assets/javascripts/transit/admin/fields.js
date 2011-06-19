$(function(){
	
	var dp   	 = $('#datepicker_holder'),
		dptarget = $('#datepicker_target'),
		link 	 = $(dp.data('calendar-link')),
		name 	 = dp.attr('rel'),
		month_select, day_select, year_select;
		
	month_select = $('#'+name+'_2i');
	day_select   = $('#'+name+'_3i');
	year_select  = $('#'+name+'_1i');
	
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

	
	dptarget.bind("click", function(){
		dp.focus();
	});
	
	dp.css({ 
		position:'fixed',
		top: dptarget.offset().top + dptarget.outerHeight(true) + 10,
		left: dptarget.offset().left
	});
	
});