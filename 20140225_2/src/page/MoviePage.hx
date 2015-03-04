package page ;

import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class MoviePage extends DefaultPage
{

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	override function getSwfInfo():Dynamic 
	{
		return {name:'MoviePage', path:'src/MoviePage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'MoviePage', path:'MoviePage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}