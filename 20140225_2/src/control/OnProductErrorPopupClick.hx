package control;

import org.vic.web.WebCommand;
import view.ProductErrorPopup;

/**
 * ...
 * @author han
 */
class OnProductErrorPopupClick extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		getWebManager().closePage( ProductErrorPopup );
	}
}