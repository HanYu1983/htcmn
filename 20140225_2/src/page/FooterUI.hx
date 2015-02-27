package page ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class FooterUI extends WebView
{

	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Footer', path:'src/Footer.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Footer', path:'Footer' };
	}
}