//= require transit/plugins/jplayer
//= depend_on transit/core

(function(transit){
	
	var Audio = function( element, instance_opts ){
				
		var audio_params = {
			swfPath: transit.paths.jplayer,
			ready: load_audio,
			solution: "html,flash",
			supplied: 'mp3,m4a',
			idPrefix: 'transit',
			ready: audio_ready
		},
		self    = this,
		config  = transit.config['video'],
		options = transit.parseContextData(element);
		
		if( instance_opts ){
			config = transit.mergeConfigs(config, instance_opts );
		}
						
		element.jPlayer(audio_params);
					
		function audio_ready(event){
			var media_opts = {};
			media_opts[options.ext] = options.source;
			self.jPlayer("setMedia", media_opts);
		}
		
		return self;
			
	};
	
	transit.addContext("audio", Audio);

	jQuery(function(){
		jQuery('*[data-transit-context="audio"]')
			.bind('transit:audio', load_audio)
			.live('transit:audio', load_audio)
			.trigger('transit:audio');
	});
	
	// jQuery handler func
	
	function load_audio(event){
		jQuery(this).transit('audio');
	}
	
})(transit);