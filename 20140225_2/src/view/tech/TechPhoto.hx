package view.tech;

/**
 * ...
 * @author han
 */
class TechPhoto extends DefaultTechPage
{

	public function new() 
	{
		super();
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechPhoto', path:config.swfPath.TechPhoto[ config.swfPath.TechPhoto.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechPhoto', path:'mc_anim' };
	}
}