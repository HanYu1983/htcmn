package cmd;
import helper.ETMAPI;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CallETMAPI extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		var param: Dynamic = args[0];
		var cb: Dynamic = args[1];
		var cmd = Reflect.field(param, "cmd");
		switch(cmd) {
			case "isEnterInfo":
				{
					var fbid = getWebManager().getData('fbid');
					var fbemail = getWebManager().getData('email');
					
					trace("fbid:", fbid);
					ETMAPI.isEnterInfo(fbid, fbemail, function(err:String, data:Dynamic) {
						trace( data );
						//{"status":1,"token":"rDtw4Z4hCLTL6UdOZXKjJIjxqWC3BC5hrDmRJHigp50="}
						if ( err != null ) {
							cb( err, false );
						} else {
							var isWritten = Reflect.field( data, "status" ) == 1;
							var token = Reflect.field( data, "token" );
							getWebManager().setData("etmToken", token);
							cb( null, isWritten );
						}
					});
				}
				
				
			case "enterInfo":
				{
					var info = {
						token : getWebManager().getData("etmToken"),
						name : getWebManager().getData("name"),
						email : getWebManager().getData("email"),
						gender : getWebManager().getData("gender"),
						mobile : getWebManager().getData("mobile"),
						is_read_policy : getWebManager().getData("is_read_policy"),
						is_agree_personal_info : getWebManager().getData("is_agree_personal_info"),
						is_accept_notice : getWebManager().getData("is_accept_notice")
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