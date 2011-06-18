$(function(){

	$('#context_fields li.field')
		.live('mouseenter.transit', function(event){
			$(this).addClass('active_field');
		})
		.live('mouseleave.transit', function(event){
			$(this).removeClass('active_field');
		});
	
});