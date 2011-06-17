//= require jqtools/flashembed
//= depend_on transit/core

$(function(){
	var params = {
			src: '/assets/video_player.swf',
			allowfullscreen: 'true',
			allowscriptaccess: 'always',
			bgcolor: '#000000',
			wmode: 'opaque'
		};

	$('div.video_player')
		.bind('transit:loadVideo', load_video)
		.trigger('transit:loadVideo');
	
	function load_video(){
		var self  = $(this), 
			src   = self.data('video-source'),
			nvars = {},
			image = self.data('video-image'),
			type  = self.data('video-type');

		nvars.movie = src || "";
			
		if( (type && type == 'youtube') && !(/youtube/).test(src) ) {
			nvars.movie = "http://www.youtube.com/v/" + nvars.src;
		}
		
		if( image != "" ) nvars.image = image;
		nvars = $.extend({}, transit.config["context.video"], nvars);
		self.flashembed(params, nvars);
	}
	
});