package model;
import flash.errors.Error;
import haxe.Http;
import haxe.Json;

/**
 * ...
 * @author han
 */
class ETMAPI
{
	
	/**
	 * 
	 * callback: Error, Json Object
	 */
	public static function isEnterInfo( params: { fbid:String, email:String } ):Dynamic {
		return function(cb:Dynamic) {
			var fbid = params.fbid;
			var fbemail = params.email;		
			var http = new Http("isEnterInfo.php");
			http.setParameter("fb_id", fbid);
			http.setParameter("fb_email", fbemail);
			http.onData = function(data:String) {
				cb( null, Json.parse(data) );
			}
			http.onError = function( err:String ) {
				cb( new Error(err), null );
			}
			http.request();
		}
	}
	/**
	 * token:<input id="token" name="token" type="text" size="100">由 isEnterInfo.php 取得的 token 值<br>
name:<input id="name" name="name" type="text">姓名<br>
email:<input id="email" name="email" type="text">Email<br>
gender:<input id="gender" name="gender" type="radio" value="M" checked>男(M)
<input id="gender" name="gender" type="radio" value="F">女(F)<br>
mobile:<input id="mobile" name="mobile" type="text">行動電話<br>
is_read_policy:<input id="is_read_policy" name="is_read_policy" type="text" value="Y">是否閱讀各項規定(Y|N)<br>
is_agree_personal_info:<input id="is_agree_personal_info" name="is_agree_personal_info" type="text" value="Y">是否同意個資蒐集(Y|N)<br>
is_accept_notice:<input id="is_accept_notice" name="is_accept_notice" type="text" value="Y">是否同意收到HTC優惠訊息(Y|N)<br>
	 * @param	info
	 * @param	cb
	 */

	 
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
			var http = new Http("enterInfo.php");
		
			http.setParameter("token", params.token);
			http.setParameter("name", params.name);
			http.setParameter("email", params.email);
			http.setParameter("gender", params.gender);
			http.setParameter("mobile", params.mobile);
			http.setParameter("is_read_policy", params.is_read_policy);
			http.setParameter("is_agree_personal_info", params.is_agree_personal_info);
			http.setParameter("is_accept_notice", params.is_accept_notice);
			
			http.onData = function(data:String) {
				cb( null, Json.parse(data) );
			}
			http.onError = function( err:String ) {
				cb( new Error(err), null );
			}
			http.request();
		}
	}
	
}