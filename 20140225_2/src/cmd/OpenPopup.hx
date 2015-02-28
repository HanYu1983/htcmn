package cmd;

import org.vic.web.WebCommand;

/**
 * ...
 * @author vic
 */
class OpenPopup extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		if ( !Std.is(args, Array) ) {
			var targetPage = args;
			getWebManager().openPage(targetPage, null);
		}else {
			var targetPage = args[0];
			var param = args[1];
			var callback = args[2];
			getWebManager().openPage(targetPage, param, callback);
		}
	}
}