/**
 * selectToList
 *
 * Uses a select dropdown and an ordered/unordered list to simulate a more user-friendly multiple-select list.
 *
**/
(function( $, undefined ) {

	jQuery.fn.selectToList = function(conf){
	
		var target, 
			add_link, 
			rem_link, 
			opts = {},
			field_name,
			existing = [],
			all_list = $(this);
		
		if ( $.type(conf) == 'string' ){
			target = $(conf);
			opts   = {};
		}else{
			target = $(conf.target);
			opts   = conf;
		}
		
		add_link   = opts.add  || target.closest('a.add_to_list');
		rem_link   = opts.rem  || $('<a href="#" class="icon_delete remove_from_list">Remove</a>');
		field_name = opts.name || this.attr('name');
		
		$('a.remove_from_list').bind('click.selectToList', remove_from_list);
		
		add_link.bind('click.selectToList', function(event, id, name){
			event.preventDefault();
			var to_add = id || all_list.val().toString(), 
				newli, newel, new_rem_link;			
			if ( $.inArray(to_add, existing) != -1 ) return true;
			
			newli = $("<li></li>");		
			newel = $("<input type='hidden' />");						

			target.append(newli);
			newli.text(name || all_list.find("option:selected").text())
				.append(newel);
			
			new_rem_link = rem_link.clone(true);
			
			newli.attr('rel', to_add);
			newel.attr({ name:field_name, value: to_add });
			newli.append(new_rem_link);
			new_rem_link.bind("click.selectToList", remove_from_list);
			existing.push(to_add);
		});
		
		function find_existing(){
			var input;
			existing = [];
			target.find('li').each(function(i, li){
				input = $(li).find('input:first');
				existing.push($(input).val().toString());
			});
		}
		
		find_existing();
		
		function remove_from_list(event){
			event.preventDefault();
			var self = $(this), li = self.parent('li');
			li.remove();
			find_existing();
		}
		
	};

})( jQuery );