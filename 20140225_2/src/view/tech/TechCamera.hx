package view.tech;

/**
 * ...
 * @author han
 */
class TechCamera extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechCamera', path:'src/TechCamera.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechCamera', path:'TechCamera' };
	}
}