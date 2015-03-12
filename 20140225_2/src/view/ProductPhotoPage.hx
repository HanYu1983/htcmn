package view;
import flash.display.Bitmap;

/**
 * ...
 * @author han
 */
class ProductPhotoPage extends DefaultPage
{
	
	public function new() {
		super();
		createDebugRoot("photo page");
		createDebugButton("btn_onProductPhotoBtnClick_close");
		layerName = "popup";
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		var photo = cast( param.photo, Bitmap );
		
		//getRoot().addChild( photo );
		
		super.onOpenEvent(param, cb);
	}
}