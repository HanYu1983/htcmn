package view.tech;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechPhoto extends DefaultTechPage
{
	var ary_effect:Array<MovieClip> = [];
	var ary_btn:Array<MovieClip> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_effect_01', 'mc_effect_02', 'mc_effect_03',
					 'mc_effect_04', 'mc_effect_05', 'mc_effect_06':
						ary_effect.push( cast( disobj, MovieClip ));
				case 'btn_effect_01', 'btn_effect_02', 'btn_effect_03',
					 'btn_effect_04', 'btn_effect_05', 'btn_effect_06':
						ary_btn.push( cast( disobj, MovieClip ));
			}
		});
		trace( ary_effect );
		trace( ary_btn );
		
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