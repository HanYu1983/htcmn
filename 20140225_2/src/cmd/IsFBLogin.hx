package cmd;

import helper.JSInterfaceHelper;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class IsFBLogin extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
	}

	override public function execute(?args:Dynamic):Void 
	{
		var cb: Dynamic = args;
		JSInterfaceHelper.callJs( getWebManager(), 'isFBLogin', [], function(info:Dynamic) {
			var err = Reflect.field(info, "0");
			var res = Reflect.field(info, "1");
			if ( err != null ) {
				cb( err, false );
			}else {
				var status = Reflect.field(res, 'status');
				var isLogin = status == 'connected';
				if ( isLogin ) {
					var authResponse = Reflect.field(info, 'authResponse');
					var accessToken = Reflect.field(authResponse, 'accessToken');
					var fbid = Reflect.field(authResponse, 'userID');
					getWebManager().setData('fbid', fbid);
					getWebManager().setData('accessToken', accessToken);
				}
				cb( null, isLogin );
			}
		});
	}
	
}