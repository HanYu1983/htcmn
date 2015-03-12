package view;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import helper.Tool;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class ProductPhotoPage extends DefaultPage
{
	var mc_photoContainer:DisplayObjectContainer;
	var mc_imgmask: DisplayObject;
	
	public function new() {
		super();
		layerName = "popup";
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_photoContainer':
					mc_photoContainer = cast( obj, DisplayObjectContainer );
				case 'mc_imgmask':
					mc_imgmask = obj;
			}
		});
		
		super.onOpenEvent(param, cb);
		
		var photo = cast( param.photo, BitmapData );
		mc_photoContainer.addChild( new Bitmap( photo ) );
		
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_popup != null ) {
			Tool.centerForce(_mc_popup, 829, 494, x, y, w, h );
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'BigPhotoPopup' };
	}
}