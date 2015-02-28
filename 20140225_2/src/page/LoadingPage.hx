package page;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class LoadingPage extends WebView
{

	public function new() 
	{
		super();
		
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'Loading' };
	}
}