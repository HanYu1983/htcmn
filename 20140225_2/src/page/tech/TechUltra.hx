package page.tech;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechUltra extends DefaultTechPage
{
	private var _mc_controller:MovieClip;
	private var _mc_slider:DisplayObject;
	private var _mc_mask:DisplayObject;

	public function new() 
	{
		super();
		this.createDebugRoot("ultra");
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
			}
		});
		
		//x 539~889
		_mc_controller.gotoAndStop( 50 );
		//_mc_slider = _mc_controller.getChildByName( 'mc_slider' );
		//_mc_mask = _mc_controller.getChildByName( 'mc_mask' );
		//_mc_slider.x = _mc_mask.x = 100;
		//trace( _mc_slider.x );
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