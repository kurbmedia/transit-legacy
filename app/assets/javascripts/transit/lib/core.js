//= require ./prefix
//= require_self
//= require_directory ./util
//= require ./setup.js.erb
//= require ./suffix
//= require_tree ../contexts
//= require_tree ../views
	
var root 	= this,
	Transit = root.Transit = {};

Transit.VERSION 	= '0.0.1';
Transit.controllers = {};
Transit.views       = {};

//
// Add configuration data
//
Transit.configure = function( name, conf ){
	this[name].configure(conf);
};
//
// Automatically generate controllers for specified model types, with optional configuration.
//
Transit.autoload = function( name, options ){
	jQuery('*[data-context-type="'+ name +'"]')
		.each(function(i, element){
			var self    = jQuery(element),
				context = self.data('transit.' + name.toLowerCase()),
				conf;
					
			if( options ) context.configure( options );
			if( typeof context == 'undefined' ) return true;
			context.render();
			return self;
		});
};

Transit.build = function( name, element, options ){
	var data = Transit.Util.Base64.decode( jQuery(element).data('context-attributes') ),
		model;
	data = (new Function("return " + data))();
	
	element = jQuery(element);
	data.el = element;
	model   = Transit[name].init( data );
	
	if( options ) model.configure( options );
	
	element.data('transit.' + name.toLowerCase(), model );
	return element;
	
};

Transit.Context = Spine.Controller.create({
	init: function( attrs ){
		this.config = jQuery.extend({}, this.parent.config);
		for( var name in attrs ) this[name] = attrs[name];
	},
	// Instance level configure
	configure: function( options ){
		this.config = jQuery.extend(this.config, attrs);
	},
	// Instance configuration
	config: {},
	render: jQuery.noop
},{	
	// Class configuration
	config: {},
	// Class level configure
	configure: function( attrs ){
		this.config = jQuery.extend(this.config, attrs);
	}
});


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