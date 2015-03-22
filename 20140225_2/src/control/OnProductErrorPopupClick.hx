package control;

import org.vic.web.WebCommand;
import view.ProductErrorPopup;

/**
 * ...
 * @author han
 */
class OnProductErrorPopupClick extends DefaultCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		super.execute( args );
		getWebManager().closePage( ProductErrorPopup );
	}
}