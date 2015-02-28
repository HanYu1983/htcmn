package page ;

import flash.display.DisplayObject;
import helper.IResize;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class FooterUI extends DefaultPage
{
	private var _back:DisplayObject;

	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_footback':
					_back = obj;
			}
		});
		super.onOpenEvent(param, cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Footer', path:'src/Footer.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Footer', path:'Footer' };
	}
	
	override public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		if( _back != null ){
			_back.width = w;
			getRoot().y = h - _back.height;
		}
	}
}