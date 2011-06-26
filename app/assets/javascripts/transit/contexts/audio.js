//= require libs/jplayer
//= require transit/views/audio_player

(function(transit){
	
	var audio = function( element, options ){
		var self   = this;	
		var data   = transit.context.data( element ) || {},
			config = transit.merge( options, data ),
			conf   = transit.config['audio'],
			uid    = _.uniqueId(),
			ui     = transit.template.parse('transit/views/audio_player', { uid: uid }),
			player_element = jQuery("<div class='player_instance' id='transit_audio_"+ uid +"'></div>");
		
		jQuery.extend(self, {
			play:  function(){ element.jPlayer('play'); },
			pause: function(){ element.jPlayer('pause'); },
			stop:  function(){ element.jPlayer("stop"); }
		});
		
		conf.ready = function(){
			var opts = {}, ext = config.ext;
			if( typeof ext == 'undefined' ) ext = /[^.]+$/.exec(config.source);
			opts[ext] = config.source;				
			jQuery(player_element).jPlayer('setMedia', opts);
		};
				
		conf.cssSelectorAncestor = '#transit_media_interface_' + uid;
		element.append(player_element);
		element.append(jQuery(ui)).addClass('media-audio');
		player_element.jPlayer(conf);				
		
		return self;
	};
	
	transit.context.add("audio", audio);
	
	
})(transit);