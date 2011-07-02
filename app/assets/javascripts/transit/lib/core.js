//= require ./prefix
//= require_self
//= require_directory ./util
//= require ./setup.js.erb
//= require ./suffix
	
var root 	= this,
	Transit = root.Transit = {};

Transit.VERSION 	= '0.0.1';
Transit.config  	= {};
Transit.controllers = {};
Transit.views       = {};

//
// Add configuration data
//
Transit.configure = function( name, conf ){
	var old_conf = this.config[name] || {};
	this.config[name] = jQuery.extend(this.config[name], conf);
};
//
// Automatically generate controllers for specified model types, with optional configuration.
//
Transit.autoload = function( name, options ){
	jQuery('*[data-context-type="'+ name +'"]')
		.each(function(i, element){
			var self    = jQuery(element),
				data    = self.data('transit.models'),
				context = data[name],
				controller,
				attrs;
				
			attrs = jQuery.extend({}, { el:self, item:Transit[name].find(context) }, options );
			
			if( typeof context == 'undefined' ) return true;
			controller = Transit.controllers[name].init(attrs);			
			self.data("transit."+name, controller);
			return self;
		});
};

Transit.build = function( name, element ){
	var data = Transit.Util.Base64.decode( jQuery(element).data('context-attributes') ),
		model,
		model_data;
	
	data =  (new Function("return " + data))();
	data = jQuery.extend(data, { element_id: jQuery(element).attr('id'), type: name });
	
	model 	   = Transit[name].create( data );
	model_data = element.data('transit.models') || {};
	model_data[name] = model.id;
	
	element.data('transit.models', model_data);
	return element;
	
};


// Transit.Model       = Backbone.Model.extend({});
// Transit.View        = Backbone.View.extend({});
// Transit.AdminView   = Backbone.View.extend({});
// 
// Transit.Context = Transit.Model.extend({
// 	defaults:{
// 		body: '',
// 		package_id:   '',
// 		package_type: ''
// 	},
// 	url: function(){ 
// 		return "/transit/" + this.get('resource_url') + "/" + this.get('package_id') + "/contexts/" + this.get("id"); 
// 	}
// },
// {
// 	build: function( name, element ){
// 		var data  = Transit.Util.Base64.decode( jQuery(element).data('context-attributes') ),
// 			model = new Transit.Context[name]((new Function("return " + data))()),
// 			view;
// 			
// 		if( typeof Transit.View[name] == 'undefined' ) view = new Transit.View({ el: element, model: model });
// 		else view  = new Transit.View[name]( { el: element, model: model } );
// 		
// 		return view;
// 		
// 	}
// });