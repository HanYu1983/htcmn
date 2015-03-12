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
			},
			btn_onProductPhotoBtnClick_plus:function() {
				
			},
			btn_onProductPhotoBtnClick_sub:function() {
				
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}