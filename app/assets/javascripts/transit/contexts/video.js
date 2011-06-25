//= require libs/jplayer

(function(transit){
	
	var video = function( element, options ){
		var self = this;	
		var data = transit.context.data( element ) || {},
			inst, config = transit.merge( options, data ),
			player, player_element, 
			pid = _.uniqueId();
			
		player_element = jQuery("<div class='player_instance' id='transit_video_"+ pid +"'></div>");
		element.prepend(player_element);
		player_element.css({ width:'100%', height:'100%' });

		if( typeof data.type == 'undefined' ){
			inst = new video.basic( element, player_element, config );
		}else inst = new video[data.type]( element, player_element, config );
		
		jQuery.extend(inst, {
			play:  function(){ element.jPlayer('play'); },
			pause: function(){ element.jPlayer('pause'); },
			stop:  function(){ element.jPlayer("stop"); }
		});
		
		return inst;
	};
	
	video.basic = function( element, player_element, options ){		
		var conf = _.clone(transit.config['video']);
		
		conf.ready = function(){
			var opts = {};
			opts[options.ext] = options.source;	
			jQuery(player_element).jPlayer('setMedia', opts);
		};
		conf.cssSelectorAncestor = '#transit_media_interface_0';
		jQuery(player_element).jPlayer(conf);
	};
	
	video.youtube = function( element, options ){
		
	};
	
	transit.context.add("video", video);
	
	
})(transit);