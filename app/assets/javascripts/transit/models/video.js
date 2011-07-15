Transit.Video = Transit.Context.extend({	
	events: {
		"click .play_pause": 'play',
		"click .mute_toggle": 'mute'
	},	
	
	initialize: function(){
		this.set({ source: this.get('body') });
		if( this.get('meta').video_type == 'youtube' && !(/youtube\.com/i).test(this.body) ){
			this.set({ source: "http://youtube.com/v/" + this.get('body') });
		}
	},
	
	play: function(){
		
	},
	
	mute: function(){
		
	}
});