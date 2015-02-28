 var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-47299451-14']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
 

function _gaCK(inv){
	//console.log( 'click', inv );
 _gaq.push(['_trackEvent', 'btn', 'btn/' + inv]);
}

function _gaPV(inv){ 	
	//console.log( 'pageview', inv );
_gaq.push(['_trackPageview', inv]);
}
