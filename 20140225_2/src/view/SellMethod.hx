package view ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class SellMethod extends DefaultPage
{

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'SellMethod', path:'src/SellPage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'SellMethod', path:'SellPage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}