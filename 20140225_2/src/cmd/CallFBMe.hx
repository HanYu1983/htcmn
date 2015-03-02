package cmd;

/**
 * ...
 * @author han
 */
class CallFBMe extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		var cb: Dynamic = args;
		JSInterfaceHelper.callJs( getWebManager(), 'getMe', [], function(info:Dynamic) {
			var err = Reflect.field(info, "0");
			var res = Reflect.field(info, "1");
			cb(err, res);
		});
	}
}