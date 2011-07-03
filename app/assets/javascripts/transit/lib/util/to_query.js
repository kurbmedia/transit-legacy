Transit.Util = Transit.Util || {};	

// Converts a javascript object to a query string
Transit.Util.to_query = function( object ){

	var query = "", k;

	function map(arr, func) {
		var newArr = []; 
		for (var i in arr) {
			if (arr.hasOwnProperty(i)) newArr[i] = func(arr[i]);
		}
		return newArr;
	}
	
	function to_s(obj) { 
		if (obj === null || obj === undefined) { return null; }
		var type = typeof obj;
		if (type == 'object' && obj.push) { type = 'array'; }

		switch (type){  
			case 'string':
				obj = obj.replace(new RegExp('(["\\\\])', 'g'), '\\$1');
				obj = obj.replace(/^\s?(\d+\.?\d+)%/, "$1pct");
				return '"' +obj+ '"';

			case 'array':
				return '['+ map(obj, function(el) {
					return to_s(el);
				}).join(',') +']'; 

			case 'function':
				return '"function()"';
			case 'object':
				var str = [];
				for (var prop in obj) {
					if (obj.hasOwnProperty(prop)) str.push('"'+prop+'":'+ to_s(obj[prop]));
				}
				return '{'+str.join(',')+'}';
		}
		return String(obj).replace(/\s/g, " ").replace(/\'/g, "\"");
	}
	
	for( k in object ) { 
		if( object[k] ) {
			var val = object[k];
			if( jQuery.isFunction(val) ) continue;
			query += k +'='+ ((jQuery.type(val) == 'object') ? to_s(val) : val) + '&';
		}
	}
	
	query = query.slice(0, -1);	
	return query;
	
};