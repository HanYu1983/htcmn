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
		return {name:'movie', path:'src/movie.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'movie', path:'Movie' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}