package page.tech;

import helper.IResize;
import helper.Tool;
import org.vic.web.WebView;

/**
 * ...
 * @author ...
 */

class TechFrame extends DefaultPage
{
	public static var TECH_DOUBLE:Int = 1;

	public function new() 
	{
		super();
		layerName = 'techui';
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Righter', path:'src/Righter.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Righter', path:'Righter' };
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		getWebManager().execute("CloseAllTechPage");
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		getRoot().x = w - getRoot().width;
		Tool.centerY(this, y, h);
	}
}