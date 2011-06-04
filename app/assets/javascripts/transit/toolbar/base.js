$(function(){
	
	var toolbar = $('#transit_toolbar'),
		tools   = $('#transit_toolbar_content'),
		handle  = $('#transit_toolbar h1.title');

	tools.hide();
	handle.toggle('click', open_toolbar, close_toolbar);
	
	function close_toolbar(event){
		tools.slideUp('fast');
		toolbar.removeClass("open");
	}
	
	function open_toolbar(event){
		tools.slideDown('fast');
		toolbar.addClass('open');
	}
	
});