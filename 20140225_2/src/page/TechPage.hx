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
		return {name:'mainPage', path:'src/mainPage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'mainPage', path:'HomePage' };
	}
}