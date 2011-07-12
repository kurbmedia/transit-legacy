//= require ./prefix
//= require_self
//= require_tree ./core-ext
//= require_tree ./util
//= require_tree ../models
//= require ./suffix
	
var root 	= this,
	Transit = root.Transit = {};

Transit.VERSION = '0.0.1';
Transit.tpl     = {};
Transit.Asset   = Backbone.Model.extend({});
Transit.View    = Backbone.View.extend({});


Transit.Model   = Backbone.Model.extend({}, {
	instances:[],
	find: function( id ){
		return _.detect( this.instances, 
			function( inst ){ 
				return inst.id.toString() == id.toString(); 
			});
	},
	first: function(){
		return this.instances[0];
	},
	last: function(){
		return this.instances[ this.instances.length - 1];
	}	
});

Transit.Context = Transit.Model.extend({});

Transit.Audio = Transit.Context.extend({});