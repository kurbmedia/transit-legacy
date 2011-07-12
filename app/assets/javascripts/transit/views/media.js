(function( Transit ){
	
	Transit.View.Media = Transit.View.extend({

		node: null,
		type: null,
		source: null,
		
		initialize: function(){
			_.bindAll(this, 'load', 'render');
			
			this.model.bind("change:source", this.load);
			this.model.view = this;
			this.type 		= this.model.get('type').underscore();
			
			this.render();			
		},
		render: function(){
			var template = _.template( Transit.tpl[this.type], this.model.attributes );
			this.el.html( template );			
			this.node = jQuery('#'+ this.type + '_player_' + this.model.id);
		},
		load: function(){
			this.source = this.model.get('source');
			this.node.attr('src', this.model.get('source'));
		}
	});
	
})( Transit );