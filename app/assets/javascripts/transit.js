//= require_tree ./transit

var editor_options = {
	rmUnusedControls: true,
	css: '/assets/editor.css?' + parseInt(Math.random()*99999999),
	initialContent: "<p>Add some text!</p>",
	resizeOptions: true,
	plugins: {
		rmFormat: { rmMsWordMarkup:true }
	},
	controls: {
	        bold: 	   	{ visible: true },
			italic: 	{ visible: true },
	        underline: 	{ visible: true },
	        createLink: { visible: true },
	        insertImage:{ visible: false },
			insertOrderedList:{ visible:true },
			insertUnorderedList:{ visible:true },			
			undo: { visible:true },
			redo: { visible:true }
	    }	
	};