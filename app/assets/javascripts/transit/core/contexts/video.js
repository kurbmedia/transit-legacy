//= require jqtools/flashembed
//= depend_on transit/core

(function(transit){
	
	var Video = function( element, instance_opts ){
		var video_params = {
			src: transit.paths.video_player,
			allowfullscreen: 'true',
			allowscriptaccess: 'always',
			bgcolor: '#000000',
			wmode: 'opaque'
		},
		self	= this,
		config  = transit.config['video'],
		options = transit.parseContextData(element);
		
		if( instance_opts ){
			config = transit.mergeConfigs(config, instance_opts );
		}
		
		if( options.type == 'youtube' && !(/youtube/).test( options.source )){
			options.source = "http://www.youtube.com/v/" + options.source;
		}
		
		options.movie = options.source;		
		element.flashembed(video_params, $.extend({}, config, options));
		
		return self;
		
	};	

	transit.addContext('video', Video);
	
	jQuery(function(){
		jQuery('*[data-transit-context="video"]')
			.bind('transit:video', load_video)
			.live('transit:video', load_video)
			.trigger('transit:video');
	});
	
	// jQuery handler func
	
	function load_video(event){
		jQuery(this).transit('video');
	}
	
})(transit);