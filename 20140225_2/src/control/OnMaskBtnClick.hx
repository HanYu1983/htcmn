package control;

import org.vic.web.WebCommand;
import view.TutorialMask;

/**
 * ...
 * @author han
 */
class OnMaskBtnClick extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		getWebManager().closePage( TutorialMask );
		SimpleController.onHeaderSkipButtonClick();
	}
}