//= require transit
//= require transit/frontend
//= require libs/proper
//= require libs/wymeditor
//= require libs/selecttolist
//= require libs/cookie
//= require_tree ./lib
//= require_tree ./admin
//= require jqueryui/core
//= require jqueryui/widget
//= require jqueryui/button
//= require jqueryui/datepicker
//= require jqueryui/tabs
//= require_self

jQuery(function(){
	
	jQuery('#transit_admin_panel_wrapper').tabs({ cookie:{} });
	jQuery('*[data-ui-button]').each(function(i, element){
		var self = jQuery(element),
			icon = self.data('ui-button');	
		self.button({ icons: { primary: 'ui-icon-'+ icon } });
	});
	
});