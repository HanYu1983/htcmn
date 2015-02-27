package page;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ProductPage extends WebView
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
}