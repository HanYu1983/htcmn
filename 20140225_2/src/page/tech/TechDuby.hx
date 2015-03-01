package page.tech;

import helper.IResize;
import helper.Tool;
import page.DefaultPage;

/**
 * ...
 * @author han
 */
class TechDuby extends DefaultTechPage
{

	public function new() 
	{
		super();
		this.createDebugRoot("duby");
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechDolby', path:'src/TechDolby.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDolby', path:'TechDolby' };
	}
}