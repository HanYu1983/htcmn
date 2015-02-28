package page.tech;

/**
 * ...
 * @author han
 */
class TechUltra extends DefaultTechPage
{

	public function new() 
	{
		super();
		this.createDebugRoot("ultra");
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechUltra', path:'src/TechUltra.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechUltra', path:'TechUltra' };
	}
}