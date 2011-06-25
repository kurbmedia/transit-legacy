(function(transit){
	
	var media_defaults = {
		swfPath:  			"assets/",
		solution: 			"html,flash",
		idPrefix: 			"transit_media",
		preload: 			"auto",
		cssSelector: {
			play: 				".media-play",
			pause: 				".media-pause",
			stop: 				".media-stop",
			videoPlay: 			".media-video-play",
			seekBar: 			".media-seek-bar",
			playBar: 			".media-play-bar",
			mute: 				".media-mute",
			unmute: 			".media-unmute",
			volumeBar: 			".media-volume-bar",
			volumeBarValue: 	".media-volume-bar-value",
			currentTime: 		".media-current-time",
			duration: 			".media-duration"
		}
	};

	
	transit.configure('video', jQuery.extend({}, media_defaults, { supplied: 'm4v' }));
	transit.configure('audio', jQuery.extend({}, media_defaults, { supplied: 'mp3,m4a,wav' }));
	
	transit.configure('richtext', {
		basePath:'assets/', 
		skin:'compact',
		toolsItems: [],
		containersItems: [],
		classesItems: []
	});
	
})(transit);