package view;
import helper.Tool;
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
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h, 0.5, 0.2 );
		}
		if ( _mc_popup != null ) {
			Tool.center(_mc_popup, x, y, w, h);
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
}