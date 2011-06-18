//= require transit/plugins/shortcut

/* jQuery.contentEditable Plugin
Copyright Â© 2011 FreshCode
http://www.freshcode.co.za/

DHTML text editor jQuery plugin that uses contentEditable attribute in modern browsers for in-place editing.

Dependencies
------------
 - jQuery core
 - shortcut.js for keyboard hotkeys
 - farbtastic color picker plugin

License
-------
Let's keep it simple:
 1. You may use this code however you wish, including for commercial projects.
 2. You may not sell it or charge for it without my written permission.
 3. You muse retain the license information in this file.
 4. You are encouraged to contribute to the plugin on bitbucket (https://bitbucket.org/freshcode/jquery.contenteditable)
 5. You are encouraged to link back to www.freshcode.co.za if you publish something about it so everyone can benefit from future updates.

Best regards
Petrus Theron
contenteditable@freshcode.co.za
FreshCode Software Development
_____________________________________________
Improvments by Quan Nguyen (github.com/mquan):
- font size and name selections
- font color and background color with color picker plugin
- text-alignment
- plugin automatically builds toolbar, lets user specify which buttons to exclude

*/
(function ($) {
	var bgcolorpicker = false,
		toolbar,
		methods = {
		edit: function (isEditing) {
			return this.each(function () {
				$(this).attr("contentEditable", (isEditing === true) ? 'true' : 'false');
			});
		},
		save: function (callback) {
			return this.each(function () {
				(callback)($(this).attr("id"), $(this).html());
			});
		},		
		createlink: function () { /* This can be improved */
			var urlPrompt = prompt("Enter URL:", "http://");
			document.execCommand("createlink", false, urlPrompt);
		},
		insertimage: function () { /* This can be improved */
			var urlPrompt = prompt("Enter Image URL:", "http://");
			document.execCommand("insertimage", false, urlPrompt);
		},
		formatblock: function (block) {
			document.execCommand("formatblock", null, block);
		},
		init: function (options) {
			
			if(typeof options == 'undefined') {
				options = {};
			}
			if( typeof options.toolbar_selector != 'undefined') {
				toolbar = $(options.toolbar_selector);
			}else { //
				$(this).before("<ul id='editor-toolbar'></ul>");
				toolbar = $('#editor-toolbar');
			}
			
			toolbar.addClass('fresheditor-toolbar');

			//build toolbar
			var groups = [
				[{name: 'bold', label: 'B', title: 'Bold (Ctrl+B)', classname: 'toolbar_bold'},
				{name: 'italic', label: 'I', title: 'Italic (Ctrl+I)', classname: 'toolbar_italic'},
				{name: 'underline', label: 'U', title: 'Underline (Ctrl+U)', classname: 'toolbar_underline'},
				{name: 'strikethrough', label: "<span style='text-shadow:none;text-decoration:line-through;'>ABC</span>", title: 'Strikethrough', classname: 'toolbar_strikethrough'},
				{name: 'removeFormat', label: '&minus;', title: 'Remove Formating (Ctrl+M)', classname: 'toolbar_remove'}],
				
				[{name: 'createlink', label: '@', title: 'Link to a web page (Ctrl+L)', userinput: "yes", classname: 'toolbar_link'},
				{name: 'insertimage', label: '<div>&nbsp;</div>', title: 'Insert an image (Ctrl+G)', userinput: "yes", classname: 'toolbar_image'},
				{name: 'insertorderedlist', label: '<div>&nbsp;</div>', title: 'Insert ordered list', classname: 'toolbar_ol'},
				{name: 'insertunorderedlist', label: '<div>&nbsp;</div>', title: 'Insert unordered list', classname: 'toolbar_ul'}]
								
			];
			var excludes = options.excludes || [];
			$.each(groups, function (index, commands) {
				var group='';
				$.each(commands, function(i, command) {
					if(jQuery.inArray(command.name, excludes)) { //lets developers exclude buttons
						var button = "<li><a href='#' class='toolbar-cmd " + command.classname + "' title='" + command.title + "' command='" + command.name;
						if(typeof command.userinput != 'undefined') {
							button = button + "' userinput='" + command.userinput;
						}
						if(typeof command.block != 'undefined') {
							button = button + "' block='" + command.block;
						}
						button = button + "'>" + command.label + "</a></li>";
						group = group + button;
					}
				});
				$(toolbar).append(group);
			});
				
			//this keeps the toolbar always on top when scroll
			$(window).scroll(function () {
				var docTop = $(window).scrollTop();
				var toolbarTop = toolbar.offset().top;
				if (docTop > toolbarTop) {
					$("div.buttons", toolbar).css({ "position": "fixed", "top": "0" });
				} else {
					$("div.buttons", toolbar).css("position", "relative");
				}
			});
			
			//one common click event for all command buttons
			$("a.toolbar-cmd").click(function() { 
				
				var cmd = $(this).attr('command');
				if($(this).attr('userinput') === 'yes') {
					methods[cmd].apply(this);
				} else if ($(this).attr('block')) {
					methods['formatblock'].apply(this, ["<" + $(this).attr('block') + ">"]);
				} else {
                    document.execCommand(cmd, false, null);
				}
				return false;
			});
			
			// var shortcuts = [
			// 	{ keys: 'Ctrl+l', method: function () { methods.createlink.apply(this); } },
			// 	{ keys: 'Ctrl+g', method: function () { methods.insertimage.apply(this); } },
			// 	{ keys: 'Ctrl+Alt+U', method: function () { document.execCommand('insertunorderedlist', false, null); } },
			// 	{ keys: 'Ctrl+Alt+O', method: function () { document.execCommand('insertorderedlist', false, null); } },
			// 	{ keys: 'Ctrl+q', method: function () { methods.formatblock.apply(this, ["<blockquote>"]); } },
			// 	{ keys: 'Ctrl+Alt+k', method: function () { methods.formatblock.apply(this, ["<pre>"]); } },
			// 	{ keys: 'Ctrl+.', method: function () { document.execCommand('superscript', false, null); } },
			// 	{ keys: 'Ctrl+Shift+.', method: function () { document.execCommand('subscript', false, null); } },
			// 	{ keys: 'Ctrl+Alt+0', method: function () { methods.formatblock.apply(this, ["p"]); } },
			// 	{ keys: 'Ctrl+b', method: function () { document.execCommand('bold', false, null); } },
			// 	{ keys: 'Ctrl+i', method: function () { document.execCommand('italic', false, null); } },
			// 	{ keys: 'Ctrl+Alt+1', method: function () { methods.formatblock.apply(this, ["H1"]); } },
			// 	{ keys: 'Ctrl+Alt+2', method: function () { methods.formatblock.apply(this, ["H2"]); } },
			// 	{ keys: 'Ctrl+Alt+3', method: function () { methods.formatblock.apply(this, ["H3"]); } },
			// 	{ keys: 'Ctrl+Alt+4', method: function () { methods.formatblock.apply(this, ["H4"]); } },
			// 	{ keys: 'Ctrl+m', method: function () { document.execCommand("removeFormat", false, null); } },
			// 	{ keys: 'Ctrl+u', method: function () { document.execCommand('underline', false, null); } },
			// 	{ keys: 'tab', method: function () { document.execCommand('indent', false, null); } },
			// 	{ keys: 'Ctrl+tab', method: function () { document.execCommand('indent', false, null); } },
			// 	{ keys: 'Shift+tab', method: function () { document.execCommand('outdent', false, null); } }
			// ];
			// 
			// $.each(shortcuts, function (index, elem) {
			// 	shortcut.add(elem.keys, function () {
			// 		elem.method();
			// 		return false;
			// 	}, { 'type': 'keydown', 'propagate': false });
			// });

			return this.each(function () {

				var $this = $(this), data = $this.data('fresheditor'),
					tooltip = $('<div />', {
						text: $this.attr('title')
					});

				// If the plugin hasn't been initialized yet
				if (!data) {
					/* Do more setup stuff here */

					$(this).data('fresheditor', {
						target: $this,
						tooltip: tooltip
					});
				}
			});
		}
	};

	$.fn.freshereditor = function (method) {
		// Method calling logic
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			if( !this.data('fresheditor') ) return methods.init.apply(this, arguments);
		} else {
			$.error('Method ' + method + ' does not exist on jQuery.contentEditable');
		}
		return;
	};
})(jQuery);