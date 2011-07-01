(function(Transit){
	
	Transit.VideoPlayer = Spine.Controller.create({
		
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