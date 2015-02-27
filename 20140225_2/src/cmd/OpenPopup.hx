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
		var targetPage = args;
		getWebManager().openPage(targetPage, null);
	}
}