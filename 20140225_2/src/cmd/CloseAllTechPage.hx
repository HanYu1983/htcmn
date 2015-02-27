package cmd;

import helper.Tool;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CloseAllTechPage extends WebCommand
{

	override public function execute(?args:Dynamic):Void 
	{
		function closePage(page:Dynamic) {
			getWebManager().closePage(page);
			return true;
		}
		Lambda.foreach( Tool.allTechPage, closePage );
	}
	
}