package control;

import org.vic.web.WebCommand;
import view.ProductPhotoPage;

/**
 * ...
 * @author han
 */
class OnProductPhotoBtnClick extends WebCommand
{

	override public function execute(?args:Dynamic):Void {
		var goto:Dynamic = {
			btn_onProductPhotoBtnClick_close:function() {
				getWebManager().closePage( ProductPhotoPage );
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}