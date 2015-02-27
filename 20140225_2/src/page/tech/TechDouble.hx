package page.tech;

import helper.IResize;
import helper.Tool;
import org.vic.flash.display.FakeMovieClip;
import org.vic.web.WebView;
import page.DefaultPage;

/**
 * ...
 * @author ...
 */
class TechDouble extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechDouble', path:'src/TechDouble.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDouble', path:'TechDouble' };
	}
}