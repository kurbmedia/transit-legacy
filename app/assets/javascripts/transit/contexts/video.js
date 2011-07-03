//= require jqtools/flashembed
//= require jqtools/rangeinput

(function(Transit){
	//http://www.youtube.com/e/OQNNqKQs_F4?controls=0&enablejsapi=1
	Transit.Video.include({
		events: {
			"click button.play_pause":  "play_pause",
			"click button.volume": "volume_control",
			"click button.mute_toggle": "mute"
		},
		
		proxied: ['play_pause', 'play_state_changed', 'update_playhead', 'setup_controls'],
		
		player_data:{
			time: { seconds:0, string:"00:00" },
			duration: { seconds:0, string:"00:00" },
			buffer:{},
			progress: null
		},
		
		render: function( template ){
			var playerid = _.uniqueId(),
				player, ext_source, conf, self = this;
			
			this.playerid = playerid;
			
			if( typeof this.player != 'undefined' ) return true;
			if( typeof template == 'undefined' ) template = Transit.views['video/show'];
			this.el.html( _.template(template, { source: this.options.src, playerid: playerid }) );
			
			if( this.options.type == 'youtube' ){
				ext_source = "http://www.youtube.com/e/" + this.options.src + "?controls=0&enablejsapi=1";
				this.el.prepend('<div class="me-plugin"></div>');
				jQuery(this.el.find('div.me-plugin:first')).flashembed({ src: ext_source, id:playerid, width:'100%', height:'100%', wmode:'opaque' });
				jQuery(this.el.find('video')).remove();
				player = jQuery(this.el.find('div.me-plugin:first')).data('flashembed');
				
			}else {										
					
				conf = this.config;				
				if( this.options.poster ) conf.poster = this.options.poster;
				
				player = new MediaElement("video_player_" + playerid, conf);
				this.player = jQuery(player)[0];				
				
				if( this.player.player ) this.player = this.player.media;
				
				_.delay(function(){
					self.player.setSrc(self.options.src);
				}, 500);
				
				jQuery.each(['play', 'playing', 'pause', 'progress', 'timeupdate', 'ended', 'loadedmetadata', 'seeked'], 
					function(i, event){
						self.player.addEventListener(event, function(e){
							self.trigger('media:' + event, [ event ]);
						}, true);						
					});
					
				self.player.addEventListener('canplay', function(e){
					self.trigger('media:ready');
				});
				
				this.bind('media:play', this.play_state_changed);
				this.bind('media:pause', this.play_state_changed);
				this.bind('media:ended', this.play_state_changed);
				this.bind('media:timeupdate', this.update_playhead);
				this.bind('media:ready', this.setup_controls);
				
				this.player.addEventListener('timeupdate', function(e){
					self.player_data.time = {
						seconds: self.player.currentTime,
						string: Transit.Util.Media.seconds_to_time( self.player.currentTime | 0, self.player.duration > 3600 )
					};
					self.player_data.duration = {
						seconds: self.player.duration,
						string: Transit.Util.Media.seconds_to_time( self.player.duration | 0, self.player.duration > 3600 )
					};
					
					self.player_data.progress = (Math.round(self.player.currentTime) / Math.round(self.player.duration)) * 100;
					
				});
			}
		},
		
		status: function(){
			return this.player_data;
		},
		
		mute: function( event ){
			var button = jQuery(this.el.find('button.toggle_mute'));
			if( this.player.muted ) button.removeClass('mute').addClass('unmute');
			else button.removeClass('mute').addClass('unmute');			
			this.player.setMuted(!this.player.muted);
		},
				
		play_pause: function( event ){			
			if( this.player.paused ) this.play();
			else this.pause();
		},
		
		play: function(){
			this.player.play();
		},
		
		pause: function(){
			this.player.pause();
		},
		
		source: function(src){
			this.player.setSrc(src);
		},
		
		volume: function(vol){
			this.player.setVolume(vol);
		},
		
		play_state_changed: function( event ){
			var button = jQuery(this.el.find('button.play_pause'));
			if( event == 'play' || event  == 'ended' ) button.removeClass('play').addClass('pause').html('Pause');
			else button.removeClass('pause').addClass('play').html('Play');
		},
		
		setup_controls: function( event ){
			var self = this;
			
			this.control_bar = jQuery(this.el.find('div.video_player_controls:first'));
			this.controls = {
				seek_bar: jQuery(this.el.find('input.seek_bar:first')),
				volume_bar: jQuery(this.el.find('input.volume_bar:first'))
			};
			
			this.controls.seek_bar.attr('max', Math.ceil(this.status().duration.seconds));
			this.controls.seek_bar.bind('change', function(event){
				self.player.setCurrentTime(jQuery(this).val());
				self.update_playhead();
			});
			
			this.player.addEventListener('volumechange', function(e){
				if( self.player.muted ) self.controls.volume_bar.val(0);
				else self.controls.volume_bar.val(self.player.volume);
			});
		},
		
		update_playhead: function( event ){
			var timer = jQuery(this.el.find('span.time')),
				data  = this.player_data;				
			timer.text(data.time.string + " / " + data.duration.string);
			this.controls.seek_bar.val(Math.ceil(data.time.seconds));
		}
	});
	
})(Transit);