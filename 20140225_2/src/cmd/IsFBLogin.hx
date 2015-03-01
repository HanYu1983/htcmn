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
		//cb( null, false );
		
		JSInterfaceHelper.callJs( getWebManager(), 'isFBLogin', [], function(info:Dynamic) {
			//trace(info);
			var err = Reflect.field(info, "0");
			var success = Reflect.field(info, "1");
			cb( err, success );
		});
	}
	
}