package page;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class SpecPage extends WebView
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'spec', path:'src/spec.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'spec', path:'Spec' };
	}
}