package view.tech;

/**
 * ...
 * @author han
 */
class TechSitu extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechAssist', path:config.swfPath.TechAssist[ config.swfPath.TechAssist.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechAssist', path:'mc_anim' };
	}
}