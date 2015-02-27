package page;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class RelativePage extends WebView
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'Relative', path:'src/Relative.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Relative', path:'Relative' };
	}
}