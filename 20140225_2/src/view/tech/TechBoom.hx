package view.tech;
import flash.display.DisplayObject;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechBoom extends DefaultTechPage
{
	var mc_phone:DisplayObject;
	var mc_finger:DisplayObject;
	var ary_wave:Array<DisplayObject> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_phone':
					mc_phone = disobj;
				case 'mc_wave_01', 'mc_wave_02', 'mc_wave_03', 'mc_wave_04', 'mc_wave_05',
					 'mc_wave_06', 'mc_wave_07', 'mc_wave_08', 'mc_wave_09', 'mc_wave_10':
						ary_wave.push( disobj );
			}
		});
		
		getWebManager().log( mc_phone );
		getWebManager().log( ary_wave );
		
		mc_finger = getLoaderManager().getTask( 'TechConnect' ).getObject( 'Finger' );
		getRoot().addChild( mc_finger );
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