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

Transit.Context = Backbone.Model.extend({}, {
	instances:[],
	find: function( id ){
		return _.detect( this.instances, 
			function( inst ){ 
				return inst.id.toString() == id.toString(); 
			});
	}
});

Transit.Audio = Transit.Context.extend({});
Transit.Video = Transit.Context.extend({});