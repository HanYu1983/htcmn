package view.tech;

/**
 * ...
 * @author han
 */
class TechPerson extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechTheme', path:config.swfPath.TechTheme[ config.swfPath.TechTheme.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechTheme', path:'mc_anim' };
	}
}