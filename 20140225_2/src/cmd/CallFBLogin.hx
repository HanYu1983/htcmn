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
			var err = Reflect.field(info, "0");
			var res = Reflect.field(info, "1");
			cb(err, true);
		});
	}
}