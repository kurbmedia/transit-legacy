Transit.Util = Transit.Util || {};	
Transit.Util.Base64 = {};

Transit.Util.Base64.encode = function( input ){
	var output = "",
		key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
		chr1, chr2, chr3,
		enc1, enc2, enc3, enc4, 
		i = 0;
		
	input = utf8_encode( input );
	
	while (i < input.length) {
		chr1 = input.charCodeAt(i++);
		chr2 = input.charCodeAt(i++);
		chr3 = input.charCodeAt(i++);
		enc1 = chr1 >> 2;
		enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		enc4 = chr3 & 63;

		if( isNaN( chr2 ) ) enc3 = enc4 = 64;
		else if( isNaN( chr3 ) ) enc4 = 64;

		output = output +
		key.charAt(enc1) + 
		key.charAt(enc2) +
		key.charAt(enc3) + 
		key.charAt(enc4);

	}
	
	function utf8_encode( string ){
		var utftext = "", n, c;
		
		string = string.replace(/\r\n/g,"\n");
		
		for ( n = 0; n < string.length; n++ ){
			c = string.charCodeAt(n);
			
			if ( c < 128 ) utftext += String.fromCharCode(c);
			else if( (c > 127) && (c < 2048) ){
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}
		return utftext;
	}
	
	return output;
	
};

Transit.Util.Base64.decode = function( input ){
	var output = "",
		key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
		chr1, chr2, chr3,
		enc1, enc2, enc3, enc4, 
		i = 0;
	
	input = input.replace( /[^A-Za-z0-9\+\/\=]/g, "" );
	
	while( i < input.length ){
			enc1 = key.indexOf(input.charAt(i++));
		enc2 = key.indexOf(input.charAt(i++));
		enc3 = key.indexOf(input.charAt(i++));
		enc4 = key.indexOf(input.charAt(i++));

		chr1 = (enc1 << 2) | (enc2 >> 4);
		chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
		chr3 = ((enc3 & 3) << 6) | enc4;

		output = output + String.fromCharCode(chr1);

		if( enc3 != 64 ) output = output + String.fromCharCode(chr2);
		if( enc4 != 64 ) output = output + String.fromCharCode(chr3);

	}
	
	output = utf8_decode( output );
	
	function utf8_decode( textstr ) {
		var string = "",
			i = 0, 
			c = c1 = c2 = 0;

		while( i < textstr.length ){
			c = textstr.charCodeAt(i);

			if( c < 128 ) {
				string += String.fromCharCode(c);
				i++;
				
			}else if( (c > 191) && (c < 224) ) {
				c2 = textstr.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
				
			}else {
				c2 = textstr.charCodeAt(i+1);
				c3 = textstr.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}

		return string;
	}
	
	return output;
	
};