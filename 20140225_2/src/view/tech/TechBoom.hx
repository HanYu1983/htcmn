package view.tech;

/**
 * ...
 * @author han
 */
class TechBoom extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechConnect', path:config.swfPath.TechConnect[ config.swfPath.TechConnect.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechConnect', path:'mc_anim' };
	}
}