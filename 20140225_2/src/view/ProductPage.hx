package view;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ProductPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'ProductPage', path:'src/ProductPage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ProductPage', path:'ProductPage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}