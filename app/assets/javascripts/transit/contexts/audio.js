//= require libs/jplayer

(function(transit){
	
	var audio = function( element, options ){
		var self   = this;	
		var data   = transit.context.data( element ) || {},
			config = transit.merge( options, data ),
			conf;
		
		jQuery.extend(self, {
			play:  function(){ element.jPlayer('play'); },
			pause: function(){ element.jPlayer('pause'); },
			stop:  function(){ element.jPlayer("stop"); }
		});
		
		conf.ready = function(){
			var opts = {};
			opts[options.ext] = options.source;			
			element.jPlayer('setMedia', opts);
		};
		element.jPlayer(transit.config['audio']);
		
		return self;
	};
	
	transit.context.add("audio", audio);
	
	
})(transit);