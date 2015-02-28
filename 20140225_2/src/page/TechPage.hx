package page;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends DefaultPage
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
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechFront', path:'src/TechFront.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechFront', path:'TechFront' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return true;
	}
}