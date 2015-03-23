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
		return {name:'HtcInPage', path:'src/HtcIn.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return { name:'HtcInPage', path:'HtcInPage' };
	}
}