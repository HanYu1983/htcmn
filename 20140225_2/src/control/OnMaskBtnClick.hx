package control;

import org.vic.web.WebCommand;
import view.TutorialMask;

/**
 * ...
 * @author han
 */
class OnMaskBtnClick extends DefaultCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		getWebManager().closePage( TutorialMask );
		SimpleController.onHeaderSkipButtonClick();
	}
}