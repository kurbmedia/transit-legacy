//= require transit/plugins/jplayer
//= depend_on transit/core

(function(transit){
	
	var audio = function(){
		
		var audio_params = {
				swfPath: transit.paths.jplayer,
				ready: load_audio,
				solution: "html,flash",
				supplied: 'mp3,m4a',
				idPrefix: 'transit'
			};
			
		this.load = function( element, instance_conf, instance_opts){
			var opts  = self.config,
				inst  = jQuery(inst);
			
			if( jQuery.type(inst) == 'array' ){
				jQuery(inst).each(function(ind, el){
					self._load(el, instance_opts);
				});
			}else{
				self._load( inst, instance_opts );
			}
		};
		
		this._load = function( element, instance_conf, instance_opts ){
			var opts = self.config,
				inst = $(element),
				conf = transit.parseContextData(inst);

			if( inst.data('transitAudio') ) return true;		
			if( instance_opts ){
				opts = transit.mergeConfigs(self.config, instance_opts);
			}
			if( instance_conf ){
				conf = transit.mergeConfigs(conf, instance_conf);
			}

			inst.data('transitAudio', conf);		
			inst.jPlayer({ ready: audio_ready });
			return true;
		};

		this.configure = function( opts ){
			this.config = transit.mergeConfigs(this.config, opts);
		};
		
		this.autoload = function( selectors ){
			if( selectors ) jQuery(selectors).trigger('transit:audio');			
			jQuery('*[data-transit-context="audio"]').trigger('transit:audio');
		};
	};
	
	transit.audio = new audio();
	
	jQuery(function(){
		jQuery('*[data-transit-context="audio"]')
			.bind('transit:audio', load_audio)
			.live('transit:audio', load_audio);
	});
	
	// jQuery handler func
	
	function load_audio(event){
		transit.audio.load(this);
	}
	
	function audio_ready(event){
		var self = $(this), 
			conf = self.data('transitAudio'),
			opts = {};
			
		opts[conf.ext] = conf.source;
		self.jPlayer("setMedia", opts);
	}
	
})(transit);