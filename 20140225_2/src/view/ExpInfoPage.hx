package view ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ExpInfoPage extends DefaultPage
{

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'ExpInfo', path:'src/ExpInfo.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ExpInfo', path:'ExpInfo' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}