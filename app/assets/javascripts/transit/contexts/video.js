//= require libs/jplayer
//= require transit/views/video_player

(function(transit){
	
	var video = function( element, options ){
		var self = this;	
		var data = transit.context.data( element, true ) || {},
			inst, config = transit.merge( options, data ),
			player, player_element, 
			pid = _.uniqueId();
			
		config.uid = pid;
			
		player_element = jQuery("<div class='player_instance' id='transit_video_"+ pid +"'></div>");
		element.prepend(player_element);
		player_element.css({ width:'100%', height:'100%' });
		if( typeof data.type == 'undefined' || data.type == 'you_tube' ){
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
		var params = {
			allowfullscreen: 'true',
			allowscriptaccess: 'always',
			bgcolor: '#000000',
			wmode: 'opaque'
		},
		self		= this,
		config  	= transit.merge(transit.config['video'], options);
		params.src  = config.src;
		
		if( options.type == 'youtube' && !(/youtube/).test( options.source )){
			options.source = "http://www.youtube.com/v/" + options.source;
		}
		
		options.movie = options.source;		
		player_element.flashembed(params, $.extend({}, config, options));
		
		return self;
	}
	
	// video.basic = function( element, player_element, options ){		
	// 		var conf = _.clone(transit.config['video']),
	// 			ui   = transit.template.parse('transit/views/video_player', { uid: options.uid });
	// 		
	// 		element.append(jQuery(ui));
	// 		
	// 		conf.ready = function(){
	// 			var opts = {}, ext = options.ext;
	// 			
	// 			if( typeof ext == 'undefined' ) ext = /[^.]+$/.exec(options.source);
	// 			if( ext == 'mp4' ) ext = 'm4v';
	// 			if( options.image ) opts.poster = options.image;
	// 			opts[ext] = options.source;	
	// 			jQuery(player_element).jPlayer('setMedia', opts);
	// 		};
	// 		conf.cssSelectorAncestor = '#transit_media_interface_' + options.uid;
	// 		jQuery(player_element).jPlayer(conf);
	// 	};
	
	video.youtube = function( element, options ){
		
	};
	
	transit.context.add("video", video);
	
	
})(transit);