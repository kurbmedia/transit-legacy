(function( Transit ){
	
	Transit.View.Video = Transit.View.Media.extend({
		initialize: function(){
			this.render();
		},
		render: function(){
			var template = _.template( Transit.tpl.video );
			this.el.html( template );
		}
	});
	
})( Transit );