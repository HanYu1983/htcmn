package cmd;
import flash.errors.Error;
import helper.ETMAPI;
import helper.JSInterfaceHelper;
import org.han.Async;
import org.vic.web.WebManager;
import page.fb.DetailFromPopup;
import page.fb.FBLoginPopup;

/**
 * ...
 * @author han
 */
class AsyncLogic
{
	public static function isEnterInfo( params: { mgr: WebManager , fbid:String, email:String } ):Dynamic {
		return function(cb:Dynamic) {
			var fbid = params.fbid;
			var fbemail = params.email;
					
			ETMAPI.isEnterInfo(fbid, fbemail, function(err:String, data:Dynamic) {
				trace( data );
				//{"status":1,"token":"rDtw4Z4hCLTL6UdOZXKjJIjxqWC3BC5hrDmRJHigp50="}
				if ( err != null ) {
					cb( new Error(err), null );
				} else {
					var isWritten = Reflect.field( data, "status" ) == 1;
					var token = Reflect.field( data, "token" );
					cb( null, { isWritten: isWritten, token: token } );
				}
			});
		}
	}
	
	public static function enterInfo(
		params: {
			token : String,
			name : String,
			email : String,
			gender : String,
			mobile : String,
			is_read_policy : String,
			is_agree_personal_info : String,
			is_accept_notice : String
		}):Dynamic
	{
		return function(cb:Dynamic) {
			ETMAPI.enterInfo(params, function(err:String, data:Dynamic) {
				trace( data );
				if ( err != null ) {
					cb( new Error(err), null );
				} else {
					cb( null, {} );
				}
			});
		}
	}
	
	public static function isFBLogin( params:{mgr:WebManager} ):Dynamic {
		return function( cb:Dynamic ) {
			JSInterfaceHelper.callJs( params.mgr, 'isFBLogin', [], function(info:Dynamic) {
				var err = Reflect.field(info, "0");
				var res = Reflect.field(info, "1");
				if ( err != null ) {
					cb( new Error(err), null );
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
		}
	}
	
	
	public static function callFBLogin( params:{mgr:WebManager} ) {
		return function( cb:Dynamic ) {
			JSInterfaceHelper.callJs( params.mgr, 'loginFB', [], function(info:Dynamic) {
				trace( info );
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
		}
	}
	
	
	public static function callFBShare( params:{mgr:WebManager} ) {
		return function( cb:Dynamic ) {
			JSInterfaceHelper.callJs( params.mgr, 'shareFB', [], function(info:Dynamic) {
				var err = Reflect.field(info, "0");
				var success = Reflect.field(info, "1");
				if ( err != null ) {
					cb( new Error( err ), null );
				} else {
					cb( null, {} );
				}
			});
		}
	}
	
	public static function callFBMe( params: { mgr:WebManager } ) {
		return function( cb:Dynamic ) {
			JSInterfaceHelper.callJs( params.mgr, 'getMe', [], function(info:Dynamic) {
				trace(info);
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
					cb( new Error(err), null );
					
				}else {
					var name = Reflect.field( res, "name" );
					var email = Reflect.field( res, "email" );
					var gender = Reflect.field( res, "gender" );
					cb(null, { name: name, email: email, gender: gender});
				}
			});
		}
	}
	
	public static function flow1( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			function done( err:Error, result:Dynamic ) {
				if ( err != null ) {
					if ( err.message == 'not login' ) {
						params.mgr.execute("OpenPopup", FBLoginPopup);
					} else {
						cb( err, null );
					}
				} else {
					WebManager.inst.execute("OpenPopup", [DetailFromPopup, null, null]);
					cb( null, { } );
				}
			}
			
			Async.waterfall([
				AsyncLogic.isFBLogin,
				
				function callFBShare( args: {isLogin:Bool, fbid: String, accessToken: String} ):Dynamic {
					return function( cb:Dynamic ) {
						if ( args.isLogin ) {
							params.mgr.setData('fbid', args.fbid);
							params.mgr.setData('accessToken', args.accessToken);
							AsyncLogic.callFBShare( { mgr:params.mgr } ) (cb);
						} else {
							cb( new Error("not login"), null );
						}
					}
				},
				
				function callFBMe( args: {} ):Dynamic {
					return function( cb:Dynamic ) {
						AsyncLogic.callFBMe( { mgr:params.mgr } ) (cb);
					}
				},
				
				function checkIsEnterInfo( args: { name: String, email: String, gender: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('name', args.name);
						params.mgr.setData('email', args.email);
						params.mgr.setData('gender', args.gender);
						
						AsyncLogic.isEnterInfo( { 
							mgr: params.mgr, 
							fbid: params.mgr.getData('fbid'),
							email: params.mgr.getData('email')
						} ) (cb);
					}
				},
				
				
				function stopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						if ( args.isWritten ) {
							cb( new Error('isWritten'), null );
						} else {
							params.mgr.setData('etmToken', args.token);
							cb( null, { } );
						}
					}
				}
			], done, params );
		}
		
	}
	
	
	
	public static function flow2( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			function done( err:Error, result:Dynamic ) {
				if ( err != null ) {
					if ( err.message == 'not login' ) {
						params.mgr.execute("OpenPopup", FBLoginPopup);
					} else {
						cb( err, null );
					}
				} else {
					WebManager.inst.execute("OpenPopup", [DetailFromPopup, null, null]);
					cb( null, { } );
				}
			}
			
			Async.waterfall([
				AsyncLogic.callFBLogin,
				
				function callFBShare( args: {accessToken: String, fbid: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('fbid', args.fbid);
						params.mgr.setData('accessToken', args.accessToken);
						AsyncLogic.callFBShare( { mgr:params.mgr } ) (cb);
					}
				},
				
				function callFBMe( args: {} ):Dynamic {
					return function( cb:Dynamic ) {
						AsyncLogic.callFBMe( { mgr:params.mgr } ) (cb);
					}
				},
				
				function checkIsEnterInfo( args: { name: String, email: String, gender: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('name', args.name);
						params.mgr.setData('email', args.email);
						params.mgr.setData('gender', args.gender);
						
						AsyncLogic.isEnterInfo( { 
							mgr: params.mgr, 
							fbid: params.mgr.getData('fbid'),
							email: params.mgr.getData('email')
						} ) (cb);
					}
				},
				
				function stopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						if ( args.isWritten ) {
							cb( new Error('isWritten'), null );
						} else {
							params.mgr.setData('etmToken', args.token);
							cb( null, { } );
						}
					}
				}
			], done, params );
		}
		
	}
}