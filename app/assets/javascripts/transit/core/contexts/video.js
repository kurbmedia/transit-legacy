//= require jqtools/flashembed
//= depend_on transit/core

(function(transit){
	
	var video = function(){
		var video_params = {
			src: transit.paths.video_player,
			allowfullscreen: 'true',
			allowscriptaccess: 'always',
			bgcolor: '#000000',
			wmode: 'opaque'
		}, 
		self = this;
		
		this.config = transit.config['video'];
		this.load   = function( element, instance_opts){
			var opts  = self.config,
				inst  = jQuery(element);
			
			if( jQuery.type(inst) == 'array' ){
				jQuery(inst).each(function(ind, el){
					self._load(el, instance_opts);
				});
			}else{
				self._load( inst, instance_opts );
			}
			
		};
		
		this._load = function( element, instance_opts ){
			var opts = self.config,
				inst = jQuery(element),
				conf = transit.parseContextData(inst);

			if( inst.data('transitVideo') ) return true;		
			if( instance_opts ){
				opts = transit.mergeConfigs(self.config, instance_opts);
			}

			if( conf.type == 'youtube' && !(/youtube/).test( conf.source )){
				conf.source = "http://www.youtube.com/v/" + conf.source;
			}

			conf.movie = conf.source;		
			inst.flashembed(video_params, $.extend({}, opts, conf));
			inst.data('transitVideo', true);
			return true;
		};

		this.configure = function( opts ){
			this.config = transit.mergeConfigs(this.config, opts);
		};
		
		this.autoload = function( selectors ){
			if( selectors ) jQuery(selectors).trigger('transit:video');			
			jQuery('*[data-transit-context="video"]').trigger('transit:video');
		};
		
	};	
	
	transit.video = new video();
	
	jQuery(function(){
		jQuery('*[data-transit-context="video"]')
			.bind('transit:video', load_video)
			.live('transit:video', load_video);
	});
	
	// jQuery handler func
	
	function load_video(event){
		jQuery(this).each(function(ind, element){
			transit.video.load(element);
		});
	}
	
})(transit);