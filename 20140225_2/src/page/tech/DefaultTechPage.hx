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
	var _mc_item:DisplayObject;
	var _mc_person:DisplayObject;

	public function new() 
	{
		super();
		layerName = 'techpage';
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {

		if( _mc_item != null ){
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h );
		}
		
		if ( _mc_person != null ) {
			Tool.centerForceY( _mc_person, 768, y, h );
		}
		
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		var frame = cast(getWebManager().getPage(TechFrame), TechFrame);
		var clz = Type.getClass(this);
		frame.animateButtonByTechPage(clz);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_back':
					_mc_back = obj;
				case 'mc_item':
					_mc_item = obj;
				case 'mc_person':
					_mc_person = obj;
			}
		});
		
		super.onOpenEvent(param, cb);
	}
}