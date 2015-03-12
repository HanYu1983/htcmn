package control;
import flash.display.Bitmap;
import flash.display3D.Context3DProgramType;
import flash.errors.Error;
import model.AppAPI;
import model.ETMAPI;
import org.vic.web.WebCommand;
import view.ProductPage;
import view.ProductPhotoPage;

/**
 * ...
 * @author han
 */
class OnProductBtnClick extends WebCommand
{

	override public function execute(?args:Dynamic):Void {
		
		var goto:Dynamic = {
			btn_onProductBtnClick_search: function() {
				
				function fetchDone( err:Error, ret:Dynamic ) {
					if ( err != null ) {
						SimpleController.onError( err );
						
					} else {
						if ( ret.length > 0 ) {
							var bitmap = cast(ret[0], Bitmap);
							getWebManager().openPage( ProductPhotoPage, { photo: bitmap.bitmapData } );
						} else {
							SimpleController.onError( 'no photo' );
							
						}
					}
				}
				
				var page:ProductPage = cast( getWebManager().getPage( ProductPage ), ProductPage );
				var searchKey = page.getInput();
				if ( searchKey.length > 0 ) {
					AppAPI.fetchPhoto( { mobile: searchKey } ) (fetchDone);
				}
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}