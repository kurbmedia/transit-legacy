$(function(){

	var hideshow  = $('a.toggle_fieldset');
	
	hideshow
		.toggle(function(){
			$(this).parent('fieldset').find('div.toggle_area').slideUp('fast');
		}, 
		function(){
			$(this).parent('fieldset').find('div.toggle_area').slideDown('fast');
		});
	
});