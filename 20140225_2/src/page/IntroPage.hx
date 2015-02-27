package page;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class IntroPage extends WebView
{

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Intro', path:'src/Intro.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Intro', path:'Intro' };
	}
}