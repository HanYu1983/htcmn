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
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'SellMethod', path:config.swfPath.SellPage[ config.swfPath.SellPage.which ] };
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