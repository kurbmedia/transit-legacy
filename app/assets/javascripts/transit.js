//= require jqueryui/core
//= require jqueryui/widget
//= require jqueryui/mouse
//= require jqueryui/position
//= require jqueryui/sortable
//= require jqueryui/draggable
//= require jqueryui/droppable
//= require underscore
//= require_tree ./transit

$(function(){
	
	$('li.datepicker').each(function(i, li){
		var self  = $(li),
			sels  = self.find('select'),
			mon, day, year, wrap;
					
		sels.each(function(i, el){
			var r = $(el).attr('id');
			if( /1i/.test(r) ){
				year = $(el);
				$(el).addClass('jcalendar-select-year');
			}else if ( /2i/.test(r) ){
				mon = $(el);
				$(el).addClass('jcalendar-select-month');
			}else{
				day = $(el);
				$(el).addClass('jcalendar-select-day');
			}
		});
		
		wrap = $('<div class="jcalendar-selects"></div>');
		self.wrapInner(wrap);
		self.jcalendar();
		
	});
	
});