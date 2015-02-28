package cmd;

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
		cb(null, true);
	}
}