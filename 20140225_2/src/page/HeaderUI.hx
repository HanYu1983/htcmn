package page ;

import flash.display.DisplayObject;
import helper.IResize;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class HeaderUI extends DefaultPage
{

	private var _btns:DisplayObject;
	
	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_btns':
					_btns = obj;
			}
		});
		super.onOpenEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'header', path:'src/header.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'header', path:'Header' };
	}
	
	override public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		_btns.x = w - _btns.width;
	}
}