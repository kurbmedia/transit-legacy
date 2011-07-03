(function(Transit){
	
	Transit.Audio.include({
		render: function( template ){
			if( typeof template == 'undefined' ) template = Transit.views['audio/show'];
			this.el.html( _.template( template, { options: options }) );
		}
	});
	
})(Transit);