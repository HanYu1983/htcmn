package cmd;

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
		getWebManager().execute("ClosePage", ActivityPopup );
	}
}