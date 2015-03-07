package view;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class SellPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'Sell', path:'src/Sell.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Sell', path:'Sell' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}