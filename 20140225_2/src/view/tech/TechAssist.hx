package view.tech;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechAssist extends DefaultTechPage
{
	var ary_btn:Array<MovieClip> = [];
	var ary_screen:Array<MovieClip> = [];
	var ary_bg:Array<MovieClip> = [];
	
	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'btn_01', 'btn_02', 'btn_03':
					ary_btn.push( cast( disobj, MovieClip ) );
				case 'mc_screen_01', 'mc_screen_02', 'mc_screen_03':
					ary_screen.push( cast( disobj, MovieClip ) );
				case 'mc_bg_01', 'mc_bg_02', 'mc_bg_03':
					ary_bg.push( cast( disobj, MovieClip ) );
					
			}
		});
		
		getWebManager().log( ary_btn );
		getWebManager().log( ary_screen );
		getWebManager().log( ary_bg );
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