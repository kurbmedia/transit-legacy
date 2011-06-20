//= require jqtools/validator

(function(transit){
	
	var form_validation = {
		options: {
			selectors: 'form.validate, form[data-js-validatable]',
			lang:'en', 
			showOn:'blur'
		},
		
		init: function(){
			$(this.options.selectors).validator({
				lang: this.options.lang,
				errorInputEvent: this.options.showOn,
				inputEvent: this.options.showOn,
				effect: 'transit'
			});	
		}
	};
	
	transit.ui.register( 'forms.validation', form_validation );
	
})(transit);

$.tools.validator.localize("en", {
	'*'				: 'invalid',
	':email'  		: 'not a valid email',
	':number' 		: 'must be a number',
	'[max]'	 		: 'must be smaller than $1',
	'[min]'	 		: 'must be larger than $1',
	'[required]' 	: 'required'
});
// Validator effect
$.tools.validator.addEffect("transit",

	// Called when errors are to be showed.
	function(errors, event) {
		$.each(errors, function(index, error) {
			var field_with_error = error.input;
			// array of error messages.
			var errors = error.messages;
			if(!$(field_with_error).parent('span.field_with_errors').get(0)){
				$(field_with_error).wrap("<span class='field_with_errors'></span>");
				$(field_with_error).after($("<span class='error_for_field' />").text(errors.join(", ")));
			}
		});

	}, 

	// Called when errors are to be hidden.
	function(inputs){
		$(inputs).each(function(ind, el){
			if($(this).parent('span.field_with_errors').get(0)) $(this).unwrap();			
			$(this).next('span.error_for_field').remove();			
		});
	}
);