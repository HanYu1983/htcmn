package view ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ActivityPopup extends WebView
{

	public function new() 
	{
		super();
		
		layerName = 'popup';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'active', path:'src/active.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'active', path:'Active' };
	}
}