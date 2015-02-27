package page ;

import flash.display.DisplayObject;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class FooterUI extends WebView
{
	private var _back:DisplayObject;

	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_footback':
					_back = obj;
			}
		});
		
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Footer', path:'src/Footer.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Footer', path:'Footer' };
	}
}