package view.tech;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechTheme extends DefaultTechPage
{
	var ary_btn:Array<MovieClip> = [];
	var ary_screen:Array<MovieClip> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'btn_01', 'btn_02', 'btn_more':
					ary_btn.push( cast( disobj, MovieClip ) );
				case 'mc_01', 'mc_02':
					ary_screen.push( cast( disobj, MovieClip ) );
			}
		});
		
		getWebManager().log( ary_btn );
		getWebManager().log( ary_screen );
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