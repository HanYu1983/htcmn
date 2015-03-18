package view;

import caurina.transitions.Tweener;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import helper.IResize;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class FakeStopPage extends WebView implements IResize
{
	var container:MovieClip;
	var tempImage:Bitmap;

	public function new() 
	{
		super();
		
		layerName = 'fakeStop';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		tempImage = new Bitmap( param.img );
		tempImage.x = param.x;
		tempImage.y = param.y;
		getRoot().addChild( tempImage );
	}
	
	public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		//tempImage.width = w;
		//tempImage.height = h;
	}
}