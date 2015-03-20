package model;
import control.SimpleController;
import flash.errors.Error;
import helper.JSInterfaceHelper;
import org.vic.web.WebManager;

/**
 * ...
 * @author han
 */
class FBAPI
{

	public static function isFBLogin( params:{} ):Dynamic {
		return function( cb:Dynamic ) {
			var isWeb = JSInterfaceHelper.callJs( 'isFBLogin', [], function(info:Dynamic) {
				SimpleController.onLog(info);
				
				var err = Reflect.field(info, "0");
				var res = Reflect.field(info, "1");
				if ( err != null ) {
					cb( new Error(err), {isLogin: false, fbid: '', accessToken: ''}  );
				}else {
					var status = Reflect.field(res, 'status');
					var isLogin = status == 'connected';
					if ( isLogin ) {
						var authResponse = Reflect.field(info, 'authResponse');
						var accessToken = Reflect.field(authResponse, 'accessToken');
						var fbid = Reflect.field(authResponse, 'userID');
						cb( null, {isLogin: true, fbid: fbid, accessToken: accessToken});
						
					} else {
						cb( null, {isLogin: false, fbid: '', accessToken: ''} );
					}
					
				}
			});
			
			if ( isWeb == false ) {
				cb( null,  { isLogin: true, fbid: 'testfbid', accessToken: 'testtoken' } );
			}
		}
	}
	
	
	public static function callFBLogin( params:{} ) {
		return function( cb:Dynamic ) {
			var isWeb = JSInterfaceHelper.callJs( 'loginFB', [], function(info:Dynamic) {
				SimpleController.onLog(info);
				/*
				accessToken: "CAAKZBVOcK5KcBAEC3jzCIcWZAIniXp8pZCjfPTs2M4FzWYrF7yKcLajxPbEPT6a5EcCmHvG19pEa9csDY21cHYF5x54xLfChM1Wh7xQ8tVuiTrycYHmumNZBaIU91U3KbNxbNNvAtLWIIrJJdmB30J2tKnUN7hJaXXWpERDfcfKMvZCQT6dqHNOFHcUqSsDPWSALizuNASvHnRLpXgorhBuyytTLCP6gZD"
				expiresIn: 5087
				signedRequest: "Yi38rjt0IBqnSzTkyfoQx0bJNaLHn8kf9ac8iT-_8Rs.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJ5cnJIcEtsdW1iMmY4Z1oxbHU1eTJacXM3UkZmTDR1YTlhajdvMXJqdDhBeWFPMThjUVdkRWZzeHJheUxOZ1NwdTJtWVBvdE5XTmJjcEpqRF81aXBoUmtwRGIxUjZtNl84RlQ4YTNUZVNyTkNHaWZkN3JMU1NGNlhtUnJaVFIxMGY3c0RoNWkzWmVSX05KazlIYUtuYW9qN05RZzljLW50cXVWTGs5MG1pZklDS1E3YllNU0RvRTJ1T0RqckJGTy0xYlUtV0o5Q2RnTmpGdDlPbGd4QzhZMWxhNUw0cU1POWJFUjBfbVhfU3NUVU14T01YdC1iTFFyOEQwZUcxaWc2RDV5dXROUGxqYUdqR3h1aUdKY3oxRlBHYWV6elc2UDVaczdLWURySDRkVDJIMjlnZWxVNjJiMkd1MVY4eVZ2UGxMNEptSzA1MGoydUF6Y25SMDQ5WiIsImlzc3VlZF9hdCI6MTQyNTMyMTMxMiwidXNlcl9pZCI6Ijk3ODA0MjQ3ODg4NzMzNyJ9"
				userID: "978042478887337"
				 */
			
				var err = Reflect.field(info, "0");
				var authResponse = Reflect.field(info, "1");
				if ( err != null ) {
					// FB在登入頁按取消時會回傳到ERROR CALLBACK, 不一定代表網路問題. 所以無論是按取消或網路錯誤, 全部當成登入失敗
					cb( new Error("login fail"),  {accessToken: '', fbid: '' } );
					
				} else {
					var accessToken = Reflect.field(authResponse, 'accessToken');
					var fbid = Reflect.field(authResponse, 'userID');
					cb(null, {accessToken: accessToken, fbid: fbid });
				}
			});
			
			if ( isWeb == false ) {
				cb( null,  { fbid: 'testfbid', accessToken: 'testtoken' } );
			}
		}
	}
	
	/**
	 * name: 'name',
			link: 'http://rsclient.etmgup.com/htchima/',
			picture: '',
			caption: 'caption',
			description: 'description',
	 */
	public static function callFBShare( params:{name:String, link:String, picture:String, caption:String, description:String} ) {
		return function( cb:Dynamic ) {
			var isWeb = JSInterfaceHelper.callJs( 'shareFB', [params.name, params.link, params.picture, params.caption, params.description], function(info:Dynamic) {
				SimpleController.onLog(info);
				
				var err = Reflect.field(info, "0");
				var info = Reflect.field(info, "1");
				
				if ( err != null ) {
					cb( new Error( err ), {} );
				} else {
					if ( info != null ) {
						cb( null, { postId: Reflect.field( info, "post_id" ) } );
						
					} else {
						cb( new Error("cancel"), { } );
						
					}
					
					/*if ( Reflect.field(info, "post_id") != null ) {
						cb( null, { postId: Reflect.field( info, "post_id" ) } );
						
					} else {
						cb( new Error("cancel"), {} );
					}*/
				}
			});
			
			if ( isWeb == false ) {
				cb( null, {} );
			}
		}
	}
	
	public static function callFBMe( params: { } ) {
		return function( cb:Dynamic ) {
			var isWeb = JSInterfaceHelper.callJs( 'getMe', [], function(info:Dynamic) {
				SimpleController.onLog(info);
				/*
	email: "finalfantasy388@yahoo.com.tw"
	first_name: "Vic"
	gender: "male"
	id: "978883735469878"
	last_name: "Yu"
	link: "https://www.facebook.com/app_scoped_user_id/978883735469878/"
	locale: "zh_TW"
	name: "Vic Yu"
	timezone: 8
	updated_time: "2014-03-22T17:02:59+0000"
	verified: true
				*/
				var err = Reflect.field(info, "0");
				var res = Reflect.field(info, "1");
				
				if ( err != null ) {
					cb( new Error(err),  { name: null, email: null, gender: null} );
					
				}else {
					var name = Reflect.field( res, "name" );
					var email = Reflect.field( res, "email" );
					var gender = Reflect.field( res, "gender" );
					cb(null, { name: name, email: email, gender: gender});
				}
			});
			
			if ( isWeb == false ) {
				cb( null, { name: 'testname', email: 'test@email.com', gender: 'testgender'} );
			}
		}
	}
	
}