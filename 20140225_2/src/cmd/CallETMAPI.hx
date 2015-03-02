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
					var fbid = Reflect.field(param, "fbid");
					var fbemail = Reflect.field(param, "fbemail");
					ETMAPI.isEnterInfo(fbid, fbemail, function(err:String, data:Dynamic) {
						if ( err != null ) {
							cb( err, null );
							return;
						}
						var isOK = Reflect.field( data, "status" ) == 1;
						cb( null, isOK );
					});
				}
			default:
				cb("error", null);
		}
	}
}