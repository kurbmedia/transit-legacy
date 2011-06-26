//= require libs/uploadify
//= require transit/views/file_upload

jQuery(function(){
	
	var upload_button = jQuery('#upload_file_link'),
		upload_dialog,
		upload_field,
		upload_url  = upload_button.data('upload-path'),
		field_id    = _.uniqueId('upload_field'),
		upload_conf = transit.merge(transit.config['uploadify'], {
			id              : field_id,
			buttonClass     : '',
			uploader		: upload_url,
			fileObjName     : upload_button.attr('rel'),
			postData        : {},
			height          : 25,
			width           : 135,
			onUploadSuccess : process_upload,
			onUploadProgress: update_progress,
			onSelect: add_to_queue
		}),
		queue_list;
	
	if( upload_button.length == 0 ) return true;
	
	upload_dialog = jQuery(transit.template.parse('transit/views/file_upload', 
		{ 
			field_name: upload_button.attr('rel'), 
			field_id:field_id 
		}));
		
	upload_dialog
		.appendTo(jQuery('body'))
		.dialog({
			title:'Upload Files',
			position:['center', 'center'],
			autoOpen:false,
			closeOnEscape:false,
			width:400,
			minHeight: 300,
			draggable:true,
			resizable: false,
			buttons: [
				{ text: 'Start Upload',
				  click: start_queue,
				  icon: 'ui-icon-check'
				},
				{ text: 'Cancel',
				  click: cancel_queue,
				  icon: 'ui-icon-closethick'
				}
			]
		});
		
	upload_field = jQuery("#"+field_id);
	queue_list = jQuery('#file_upload_queue');
	
	upload_button.bind('click', function( event ){
		event.preventDefault();
		upload_dialog.dialog('open');
		activate_queue();
	});
	
	function activate_queue(){
		upload_field.uploadify(upload_conf);
		jQuery('#'+field_id+'_button').button({ icons: { primary: 'ui-icon-plusthick' } });
		jQuery('#'+field_id).css({
			position: 'absolute',
			top: '1em',
			left: '1em'
		});
	}
	
	function add_to_queue(){
		jQuery('#file_upload_queue div.uploadifyProgress').progressbar();
	}
		
	function start_queue( event ){
		upload_field.uploadifyUpload();	
	}
	
	function cancel_queue( event ){
		upload_dialog.dialog('close');
	}
	
	function process_upload(file, data, success){
		var resp = jQuery.parseJSON(data),
			item = jQuery(resp.content);
			
		if( resp.image ) item.hide().appendTo( jQuery('#asset_image_list') );
		else item.hide().appendTo( jQuery('#asset_image_list') );
		
		item.fadeIn('fast');
		jQuery('#' + file.id).next('div.uploadifyProgress').progressbar('value', 0);
		jQuery('#asset_upload').uploadifyCancel(file.id);
	}
	
	function update_progress(file, fileBytesLoaded, fileTotalBytes, queueBytesLoaded, queueSize){
		var percentage = Math.round(fileBytesLoaded / fileTotalBytes * 100);
		jQuery('#' + file.id).next('div.uploadifyProgress').progressbar('value', percentage);
		return false;		
	}
	
	
});