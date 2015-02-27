package page ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class HeaderUI extends WebView
{

	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'header', path:'src/header.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'header', path:'Header' };
	}
}