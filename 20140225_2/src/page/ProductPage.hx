package page;
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
		return {name:'Product', path:'src/Product.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Product', path:'Product' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}