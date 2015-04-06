package view.tech;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechBlink extends DefaultTechPage
{
	var mc_rest:MovieClip;
	var btn_screen:MovieClip;

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_rest':
					mc_rest = cast( disobj, MovieClip );
				case 'btn_screen':
					btn_screen = cast( disobj, MovieClip );
			}
		});
		btn_screen.buttonMode = true;
		btn_screen.addEventListener( MouseEvent.CLICK, onScreenClick );
	}
	
	function onScreenClick( e ) {
		mc_rest.gotoAndPlay( 2 );
		getRoot().playRespond();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		if( btn_screen != null )
			btn_screen.removeEventListener( MouseEvent.CLICK, onScreenClick );
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechBlink', path:config.swfPath.TechBlink[ config.swfPath.TechBlink.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechBlink', path:'mc_anim' };
	}
}