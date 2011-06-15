//= require jqtools/flashembed
//= depend_on transit/core

$(function(){
	var flashvars = transit.config["context.video"],
		params = {
			src: '/assets/video_player.swf',
			allowfullscreen: 'true',
			allowscriptaccess: 'always',
			bgcolor: '#000000',
			wmode: 'opaque'
		};

	$('div.video_player')
		.bind('transit:loadVideo', load_video)
		.live('transit:loadVideo', load_video)
		.trigger('transit:loadVideo');
	
	function load_video(){
		var self  = $(this), 
			src   = self.data('video-source'),
			nvars = {},
			image = self.data('video-image'),
			type  = self.data('video-type');

		nvars.movie = src;
			
		if( (type && type == 'youtube') && !(/youtube/).test(src) ) {
			nvars.movie = "http://www.youtube.com/v/" + nvars.src;
		}
		
		if( image != "" ) nvars.image = image;
		self.flashembed(params, $.extend({}, flashvars, nvars));
	}
	
});