var vic = vic || {};
vic.facebook = vic.facebook || {};
(function(){
	
	function init( appId, channelUrl, callback ){
		window.fbAsyncInit = function() {
			vic.facebook.FB = FB;
			FB.init({
			  appId      : appId,
			  channelUrl : channelUrl,
			  xfbml      : true,
			  version    : 'v2.0'
			});
			callback();
		};
		
		(function(d, s, id){
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {return;}
			js = d.createElement(s); js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	}
	
	function postMessageToMyboard( options ){
		login( function( response ){
			FB.ui({
				method: 'feed', // 發布貼文
				name: options.name,
				link: options.link,
				picture: options.picture,
				caption: options.caption,
				description: options.description
			},function(response){
				options.callback( response );
			});
		}, options.error);
	}
	
	function getMyData( callback, error ){
		login( function( auth ){
			FB.api(
				"/me",
				function (response) {
					if (response && !response.error) {					
						response.accessToken = auth.accessToken
						callback( response );
					}else{
						alert(response.error.message)
					}
				}
			);
		}, error);
	}
	
	function login( callback, error ){
		FB.login( function( res ){
			if (res.authResponse) {
				callback( res.authResponse );
			}else{
				if( error != undefined )	error( res );
			}
		});
	}
	
	function getLoginStatus( callback ){
		FB.getLoginStatus( function( res ){
			callback( res.status, res.authResponse, res );
		});
	}
	
	function postOnlyMessageToMyboard( options, error ){
		login( function( response ){
			FB.ui({
				method: 'apprequests', // 發布貼文
				message:options.message,
				to:options.to
			},function(response){
				options.callback( response );
			});
		}, error);
	}
	
	vic.facebook.init = init;
	vic.facebook.login = login;
	vic.facebook.getLoginStatus = getLoginStatus;
	vic.facebook.getMyData = getMyData;
	vic.facebook.postMessageToMyboard = postMessageToMyboard;
	vic.facebook.postOnlyMessageToMyboard = postOnlyMessageToMyboard;
})();
