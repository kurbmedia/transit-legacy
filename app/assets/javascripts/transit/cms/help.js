$(function(){
    
	var info_icons    = $('*[data-help-for]'),
		info_messages = $('*[data-help-info]');

	info_messages.slideUp('fast');
	info_icons.live('click', function(event){
		event.preventDefault();
		var target = $(this).attr('data-help-for');
		$('*[data-help-info="'+target+'"]').slideToggle('fast');
	});

});