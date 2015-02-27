package page.tech;

import helper.IResize;
import helper.Tool;
import org.vic.web.WebView;

/**
 * ...
 * @author ...
 */
class TechFrame extends DefaultPage implements IResize
{

	public function new() 
	{
		super();
		layerName = 'page';
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
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		getRoot().x = w - getRoot().width;
		Tool.centerY(this, y, h);
	}
}