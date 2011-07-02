//= require transit/views/video/show

(function(Transit){
	
	Transit.VideoPlayer = Spine.Controller.create({
		movie:'',
		autoplay: false,
		loop: false,
		autohide: false,
		fullscreen: true,
		color_text: '0xffffff',
		color_seekbar: '0x333333',
		color_loadingbar: '0x888888',
		color_seekbarbg: '0xCCCCCC',
		color_button_out: '0x333333',
		color_button_over: '0xAAAAAA',
		color_button_highlight: '0xFFFFFF'
	});
	
	Transit.controllers['Video'] = Transit.VideoPlayer;
	
})(Transit);

// jQuery(function(){
// 	
// 	jQuery('*[data-transit-context="Video"]')
// 		.each(function(i, element){
// 			var self  = jQuery(element),
// 				data  = self.data('transit'),
// 				video = data['Video'],
// 				controller;
// 				
// 			if( typeof video == 'undefined' ) return true;
// 			controller = Transit.VideoPlayer.init({ el:self, item:Transit.Video.find(video) });			
// 			self.data("transit.video", controller);
// 		});			
// });