(function(Transit){
	
	Transit.AudioPlayer = Spine.Controller.create({
		
	});
	
	Transit.controllers['Audio'] = Transit.AudioPlayer;
	
})(Transit);

// jQuery(function(){
// 	
// 	jQuery('*[data-transit-context="Audio"]')
// 		.each(function(i, element){
// 			var self  = jQuery(element),
// 				data  = self.data('transit'),
// 				audio = data['Audio'],
// 				controller;
// 
// 			if( typeof audio == 'undefined' ) return true;			
// 			controller = Transit.AudioPlayer.init({ el:self, item:Transit.Audio.find(audio) });			
// 			self.data("transit.audio", controller);
// 			
// 		});
// 		
// });