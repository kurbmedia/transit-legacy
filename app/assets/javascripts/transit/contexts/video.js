//= require jqtools/flashembed

$(function(){

	var flashvars = {
		image:    '',
		movie:    '',
		autoplay:  'false',
		loop:      'false',
		autohide:  'false',
		fullscreen: 'true',
		color_text: "0xffffff",
		color_seekbar: "0x108194",
		color_loadingbar: "0xe4f2f6",
		color_seekbarbg: "0x108194",            
		color_button_out: "0x108194",
		color_button_over: "0xd15245",
		color_button_highlight: "0xffffff"
	},
	fparams = {
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
		var self = $(this), nvars, src = self.attr('data-video-source');
		if(self.hasClass('youtube_player')){
			src = ((/youtube/).test(src)) ? src : "http://www.youtube.com/watch?v=" + src;
		}
		nvars = $.extend({}, flashvars, { movie:src })
		self.flashembed(fparams, nvars);
	}
	
});