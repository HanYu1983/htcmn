package helper;
import haxe.Http;
import haxe.Json;

/**
 * ...
 * @author han
 */
class ETMAPI
{
	public static function isEnterInfo( fbid:String, fbemail:String, cb: Dynamic ) {
		var http = new Http("isEnterInfo.php");
		http.setParameter("fb_id", fbid);
		http.setParameter("fb_email", fbemail);
		http.onData = function(data:String) {
			cb( null, Json.parse(data) );
		}
		http.onError = function( err:String ) {
			cb( err, null );
		}
		http.request();
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
	public static function enterInfo( info:Dynamic, cb: Dynamic ) {
		var token = Reflect.field(info, "token");
		var name = Reflect.field(info, "name");
		var email = Reflect.field(info, "email");
		var gender = Reflect.field(info, "gender");
		var mobile = Reflect.field(info, "mobile");
		var is_read_policy = Reflect.field(info, "is_read_policy");
		var is_agree_personal_info = Reflect.field(info, "is_agree_personal_info");	//Y/N
		var is_accept_notice = Reflect.field(info, "is_accept_notice");	//Y/N
		
		var http = new Http("enterInfo.php");
		
		http.setParameter("token", token);
		http.setParameter("name", name);
		http.setParameter("email", email);
		http.setParameter("gender", gender);
		http.setParameter("mobile", mobile);
		http.setParameter("is_read_policy", is_read_policy);
		http.setParameter("is_agree_personal_info", is_agree_personal_info);
		http.setParameter("is_accept_notice", is_accept_notice);
		
		http.onData = function(data:String) {
			cb( null, Json.parse(data) );
		}
		http.onError = function( err:String ) {
			cb( err, null );
		}
		http.request();
	}
	
}