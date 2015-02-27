package cmd;

import helper.Tool;
import org.vic.web.WebCommand;

/**
 * ...
 * @author vic
 */
class ChangePage extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		function closePage(page:Dynamic) {
			getWebManager().closePage(page);
			return true;
		}
		Lambda.foreach( Tool.allPage, closePage );
		
		var targetPage = args;
		getWebManager().openPage(targetPage, null);
	}
	
}