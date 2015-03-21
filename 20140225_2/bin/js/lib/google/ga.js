var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-42128381-15']);
_gaq.push(['_trackPageview']);

(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

function _gaCK(inv){
	_gaq.push(['_trackEvent', 'btn', 'btn/' + inv]);
}

function _gaPV(inv){ 	
	_gaq.push(['_trackPageview', inv]);
}
