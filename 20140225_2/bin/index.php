<?php
require_once 'libs/utility.php';
if (isMobile()) { header('Location:mobile/'); }
?>
<!DOCTYPE html>
<html lang="en" class=" js no-touch cssanimations csstransitions">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！ </title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="keywords" content="HTC, HTC One M9, HTC專賣店,體驗會,宏達電,早鳥優惠,好禮,Hima,林佳陵">
	<meta name="description" content="HTC One M9 登峰造極 萬中選一!馬上來參加體驗分享活動就有機會拿好禮喔！"> 
		
	<!-- Facebook meta -->
	<meta property="og:title" content="HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！" /> 
	<meta property="og:description" content="HTC One M9 登峰造極 萬中選一!馬上來參加體驗分享活動就有機會拿好禮喔！" />
    <!-- HTC fav and touch icons -->
<link rel="shortcut icon" href="favicon.ico">
	
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/lib/jquery/jquery-1.9.min.js"></script>
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/lib/underscore/underscore.js"></script>
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/lib/backbone/backbone.js"></script>
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/lib/google/ga.js"></script>
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/lib/vic/vic.facebook.js"></script>
	<script src="http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/js/swfobject.js"></script>
	<!-- facebook api -->
	<script>
	(function(d, s, id) {
		//local test
		//var appid = '1059025554112783'
		
		//real test
		var appid = '772221816202407'
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&appId="+appid+"&version=v2.0";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	</script>
	<script>
		var flashvars = {
		};
		var params = {
			menu: "false",
			scale: "noScale",
			allowFullscreen: "true",
			allowScriptAccess: "always",
			bgcolor: "",
			wmode: "direct" // can cause issues with FP settings & webcam
		};
		var attributes = {
			id:"HTC"
		};
		swfobject.embedSWF(
			"HTC.swf?v=" + Math.random(), 
			"altContent", "100%", "100%", "10.0.0", 
			"expressInstall.swf", 
			flashvars, params, attributes);
	</script>
	<style>
		html, body { height:100%; overflow:hidden; }
		body {
	margin: 0;
	background-color: #000;
}
	</style>
</head>
<body>
	<script>
	var Router = Backbone.Router.extend({
		routes:{
			'':'index',
			index:'index',
			TechPage:'TechPage',
			TechBlink:'TechBlink',
			TechBoom:'TechBoom',
			TechCamera: 'TechCamera',
			TechDouble: 'TechDouble',
			TechDolby: 'TechDolby',
			TechFrame: 'TechFrame',
			TechPerson: 'TechPerson',
			TechPhoto: 'TechPhoto',
			TechSitu: 'TechSitu',
			TechUltra: 'TechUltra',
			MoviePage: 'MoviePage',
			"MoviePage/id=:id": "MoviePageWithId",
			RelativePage: 'RelativePage',
			ProductPage: 'ProductPage',
			ExpInfoPage: 'ExpInfoPage'
		},
		index:function(){
			callFlashMethod( 'router', 'index' );
		},
		TechPage:function(){
			callFlashMethod( 'router', 'TechPage' );
		},
		TechBlink: function(){
			callFlashMethod( 'router', 'TechBlink' );
		},
		TechBoom: function(){
			callFlashMethod( 'router', 'TechBoom' );
		},
		TechCamera: function(){
			callFlashMethod( 'router', 'TechCamera' );
		},
		TechDouble: function(){
			callFlashMethod( 'router', 'TechDouble' );
		},
		TechDolby: function(){
			callFlashMethod( 'router', 'TechDolby' );
		},
		TechFrame: function(){
			callFlashMethod( 'router', 'TechFrame' );
		},
		TechPerson: function(){
			callFlashMethod( 'router', 'TechPerson' );
		},
		TechPhoto: function(){
			callFlashMethod( 'router', 'TechPhoto' );
		},
		TechSitu: function(){
			callFlashMethod( 'router', 'TechSitu' );
		},
		TechUltra: function(){
			callFlashMethod( 'router', 'TechUltra' );
		},
		MoviePage: function(){
			callFlashMethod( 'router', 'MoviePage' );
		},
		MoviePageWithId: function(id){
			callFlashMethod( 'router', {page:'MoviePage', params:{ id:id }} );
		},
		RelativePage: function(){
			callFlashMethod( 'router', 'RelativePage' );
		},
		ProductPage: function(){
			callFlashMethod( 'router', 'ProductPage' );
		},
		ExpInfoPage: function(){
			callFlashMethod( 'router', 'ExpInfoPage' );
		}
	})
	
	var router = new Router();
	window.__router = router;
	
	function flashReady(){
		console.log( 'flashReady' );
		Backbone.history.start();
	}
	
	function preloadReady(){
		closeFakeLoading();
	}
	
	function thisMovie(movieName) 
	{
		if (navigator.appName.indexOf("Microsoft") != -1) 
		{
			return window[movieName];
		} 
		else 
		{
			return document[movieName];
		}
	}
	
	function callFlashMethod( methodName, val )
	{
		thisMovie("HTC")[ methodName ]( val );
	}
	
	function flashCallJs( val ){
		console.log( 'from flash: ' + val );
		callFlashMethod();
	}
	
	function closeFakeLoading(){
		//for fakeloading
	/*
		$("#cover").fadeOut( 2500, function(){
			$("#cover").remove();
		});
		*/
	}
	</script>
	
	<!-- bridge -->
	
	<script>
	var externalObject = {}
	
	externalObject.changeHash = function( hash, cb ){
		_gaPV( hash );
		window.__router.navigate( hash, { trigger: false } )
		cb( null, null );
	}
	
	externalObject.getMe = function( cb ){
		vic.facebook.getMyData(
			function( res ){
				cb( null, res );
			},
			function( err ){
				cb( err, null );
			}
		);
	}
	
	externalObject.loginFB = function( cb ){
		console.log('loginFB');
		vic.facebook.login( function( res ){
			console.log(res)
			cb(null, res );
		}, function( error ){
			cb(error, false );
		}, {scope: 'email'});
		
	}
	
	externalObject.shareFB = function( name, link, picture, caption, description, cb ){
		console.log('shareFB');
		vic.facebook.postMessageToMyboard( {
			name: name,
			link: window.location.href,
			picture: picture,
			caption: caption,
			description: description,
			callback:function( res ){
				console.log( res )
				cb( null, res );
			},
			error:function( error ){
				cb(error, false);
			}
		});
	}
	
	externalObject.isFBLogin = function( cb ){
		console.log('isFBLogin');
		vic.facebook.getLoginStatus( function( val ){
			console.log( val );
			cb(null, val);
		});
	}
	
	externalObject.tracking = function( type, name, cb ){
		if( type == 'page' )
			_gaPV( name );
		else
			_gaCK( name );
		cb( null, null );
	}
	
	/*
	window.onfocus = function(e){
		alert( 'onfocus' );
	};
	*/
	
	$(window).blur(function() {
		callFlashMethod( 'onWindowBlur' );
	});
	
	</script>
	
	<!-- basic -->
	<script>
	
	function genCallback( id ){
		return function(){
			thisMovie("HTC")[ 'callFromHtml' ]( {id: id, params:arguments } );
		}
	}
	
	function callFromFlash( val ){
		var id = val.id
		var method = val.method
		var params = val.params
		var callback = genCallback( id )
		params.push(callback)
		externalObject[method].apply( null, params );
	}
	
	</script>
	
	<div id="altContent">
	  <h1>HTC</h1>
		<p><a href="http://www.adobe.com/go/getflashplayer">Get Adobe Flash player</a></p>
	</div>
		<!-- basic <div id="cover" style="position:absolute; left:0; top:0; width:100%; height:100%">
			<img style="width:100%; height:100%" src="images/loading/loading.jpg"/>
	</div>-->
</body>
</html>