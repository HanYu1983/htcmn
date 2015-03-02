package cmd;

import helper.JSInterfaceHelper;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CallFBLogin extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		var cb: Dynamic = args;
		JSInterfaceHelper.callJs( getWebManager(), 'loginFB', [], function(info:Dynamic) {
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
				cb( null, false );
				
			} else {
				var accessToken = Reflect.field(authResponse, 'accessToken');
				var fbid = Reflect.field(authResponse, 'userID');
				getWebManager().setData('fbid', fbid);
				getWebManager().setData('accessToken', accessToken);
				cb(err, true);
			}
		});
	}
}