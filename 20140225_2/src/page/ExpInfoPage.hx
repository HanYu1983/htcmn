package page ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ExpInfoPage extends WebView
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
}