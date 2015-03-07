package cmd;

import helper.AppAPI;
import org.vic.web.WebCommand;
import page.ActivityPopup;

/**
 * ...
 * @author vic
 */
class OnActiveBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		AppAPI.closePage( {
			mgr:getWebManager(),
			page: ActivityPopup,
		
		}) (null);
	}
}