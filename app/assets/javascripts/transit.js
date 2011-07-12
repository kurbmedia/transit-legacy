//= require libs/underscore
//= require libs/json2
//= require libs/backbone
//= require transit/lib/core
//= require transit/config
//= require_tree ./transit/views
//= require_self


jQuery(function(){


	jQuery("[data-context-id]").each(function(){
		var self = jQuery(this),
			uid  = self.attr('data-context-id'),
			type = self.attr('data-context-type'),
			meta = jQuery("meta[name='context:" + uid + "']").eq(0),
			data = Transit.Util.Base64.decode( meta.attr('content') ),
			model;
	
		data = data.replace("_id", "id")
				   .replace("_type", "type");
				
		data  = JSON.parse(data);
		model = new Transit[type]( data );
		Transit[type].instances.push(model);
		
		if( Transit.View[type.capitalize()] ){
			return new Transit.View[type.capitalize()]({ el: self, model: model });
		}
		
	});
	
});