package view.tech;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import haxe.remoting.FlashJsConnection;
import helper.IResize;
import helper.Tool;
import org.vic.utils.BasicUtils;
import view.DefaultPage;

/**
 * ...
 * @author han
 */
class DefaultTechPage extends DefaultPage
{
	var _mc_person:DisplayObject;

	public function new() 
	{
		super();
		layerName = 'techpage';
		
	}
	
	public function skipAnimation() {
		
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		super.onResize(x, y, w, h );
		if ( _mc_person != null ) {
			Tool.centerForceY( _mc_person, 768, y, h );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_person':
					_mc_person = obj;
			}
		});
		
		super.onOpenEvent(param, cb);
	}
}