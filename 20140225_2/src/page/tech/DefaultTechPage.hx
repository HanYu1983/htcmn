package page.tech;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import haxe.remoting.FlashJsConnection;
import helper.IResize;
import helper.TechFramePage;
import helper.Tool;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class DefaultTechPage extends DefaultPage
{
	var _mc_back:DisplayObject;
	var _mc_item:MovieClip;
	var _mc_person:DisplayObject;

	public function new() 
	{
		super();
		layerName = 'techpage';
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {

		if( _mc_item != null ){
			Tool.center( _mc_item, x, y, w, h );
		}
		
		if ( _mc_person != null ) {
			Tool.centerY( _mc_person, y, h );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_back':
					_mc_back = obj;
				case 'mc_item':
					_mc_item = cast( obj, MovieClip );
				case 'mc_person':
					_mc_person = obj;
			}
		});
	}
}