package cmd2;

import helper.ETMAPI;
import helper.WebManagerFieldProvider;
import org.vic.web.WebCommand2;
import org.vic.web.WebManager;

/**
 * ...
 * @author han
 */
class CallETMAPI extends WebCommand2
{
	
	override function executeImpl(cb:Dynamic):Void 
	{
		require(["mgr", "cmd"]);
		
		var mgr:WebManager = get("mgr");
		var cmd:String = get("cmd") ;
		
		switch(cmd) {
			case "isEnterInfo":
				{
					require(["fbid", "email"]);
					
					var fbid = get("fbid");
					var fbemail = get("email");
					
					ETMAPI.isEnterInfo(fbid, fbemail, function(err:String, data:Dynamic) {
						trace( data );
						//{"status":1,"token":"rDtw4Z4hCLTL6UdOZXKjJIjxqWC3BC5hrDmRJHigp50="}
						if ( err != null ) {
							cb( err, false );
						} else {
							var isWritten = Reflect.field( data, "status" ) == 1;
							var token = Reflect.field( data, "token" );
							
							mgr.setData("etmToken", token);
							cb( null, isWritten );
						}
					});
				}
				
				
			case "enterInfo":
				{
					require([
						"etmToken", "name", "email", "gender", "mobile", 
						"is_read_policy", "is_agree_personal_info", "is_accept_notice"
					]);
					
					var info = {
						token : get("etmToken"),
						name : get("name"),
						email : get("email"),
						gender : get("gender"),
						mobile : get("mobile"),
						is_read_policy : get("is_read_policy"),
						is_agree_personal_info : get("is_agree_personal_info"),
						is_accept_notice : get("is_accept_notice")
					}
					
					ETMAPI.enterInfo(info, function(err:String, data:Dynamic) {
						trace( data );
						if ( err != null ) {
							cb( err, false );
						} else {
							cb( null, true );
						}
					});
				}
				
				
			default:
				cb("error", null);
		}
	}
	
}