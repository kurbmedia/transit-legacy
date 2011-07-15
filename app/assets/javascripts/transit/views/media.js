(function( Transit ){
	
	Transit.View.Media = Transit.View.extend({
		defaults: {
			source: ""
		},
		node: null,
		type: null,
		source: null,
		playing: false,
		events: {
			"click .play_pause": 'play'
		},
		
		initialize: function(){
			_.bindAll(this, 'load', 'render', 'update');
			
			this.model.bind("change:source", this.load);
			this.model.view = this;
			this.type 		= this.model.get('type').underscore();
			
			this.render();						
		},
		
		load: function(){
			this.source = this.model.get('source');
			this.node.attr('src', this.model.get('source'));
		},
		
		play: jQuery.noop,
		
		render: function(){
			var template = _.template( Transit.tpl[this.type], this.model.attributes );
			this.el.html( template );			
			this.node = jQuery('#'+ this.type + '_player_' + this.model.id);
			this.setup();
		},
		
		setup: function(){
			
		},
		
		update: function(){
			
		}
	});
	
})( Transit );