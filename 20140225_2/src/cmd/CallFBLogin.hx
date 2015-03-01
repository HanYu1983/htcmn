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
			var err = Reflect.field(info, "0");
			var success = Reflect.field(info, "1");
			cb(err, success);
		});
	}
}