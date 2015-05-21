package view;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class HtcInPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'HtcInPage', path:config.swfPath.HtcIn[ config.swfPath.HtcIn.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return { name:'HtcInPage', path:'HtcInPage' };
	}
}