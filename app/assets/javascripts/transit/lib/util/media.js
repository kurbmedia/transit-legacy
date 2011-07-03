Transit.Util = Transit.Util || {};	
Transit.Util.Media = {};

Transit.Util.Media.seconds_to_time = function( seconds, use_hours ){
	seconds = Math.round(seconds);
	var hours,
	    minutes   = Math.floor(seconds / 60);
	if (minutes >= 60) {
	    hours = Math.floor(minutes / 60);
	    minutes = minutes % 60;
	}
	hours = hours === undefined ? "00" : (hours >= 10) ? hours : "0" + hours;
	minutes = (minutes >= 10) ? minutes : "0" + minutes;
	seconds = Math.floor(seconds % 60);
	seconds = (seconds >= 10) ? seconds : "0" + seconds;
	return ((hours > 0 || use_hours === true) ? hours + ":" :'') + minutes + ":" + seconds;
};

Transit.Util.Media.time_to_seconds = function( string ){
	var tab = string.split(':');
	return tab[0]*60*60 + tab[1]*60 + parseFloat(tab[2].replace(',','.'));
};