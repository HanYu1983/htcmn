package page;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends WebView
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechFront', path:'src/TechFront.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechFront', path:'TechFront' };
	}
}