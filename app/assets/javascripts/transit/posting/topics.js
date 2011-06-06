// $(function(){
// 	
// 	var selected_list = $('#topic_selections ul'),
// 		field_name    = $('#topic_selections').attr('rel'),
// 		all_list	  = $('#all_topics_list'),
// 		add_button    = $('a.add_topic_link'),
// 		existing      = [],
// 		removelink    = $('a.remove_topic_link:first');
// 		
// 		$('#topic_selections ul li').each(function(i, li){
// 			existing.push($(li).attr('rel').toString());
// 		});
// 		
// 		existing = _.uniq(existing);
// 
// 		add_button.bind('click', function(event){			
// 			var to_add = all_list.val().toString(), newli, newel;
// 			event.preventDefault();
// 			if ( _.detect(existing, function(id){ to_add == id }) ) return true;
// 			
// 			newli = $("<li></li>");						
// 			newel = $("<input type='hidden' />");						
// 
// 			selected_list.append(newli);
// 			newli.text($("#all_topics_list option:selected").text())
// 				.append(newel);
// 			
// 			newli.attr('rel', to_add);
// 			newel.attr({ name:field_name, value: to_add });
// 			newli.append(removelink.clone(true));
// 				
// 			existing.push(to_add);			
// 		});
// 		
// 		$('a.remove_topic_link').bind('click', function(event){
// 			event.preventDefault();
// 			var self = $(this), li = self.parent('li'); oldid = li.attr('rel');
// 			li.remove();
// 			existing = _.reject(existing, function(id){ id == oldid });
// 		});
// 	
// });