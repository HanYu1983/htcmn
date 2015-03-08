package view.tech;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechCamera extends DefaultTechPage
{
	var _mc_controller:MovieClip;
	var _mc_circleButton:MovieClip;
	var _mc_dot:DisplayObject;
	var _mc_bar:DisplayObject;
	var _mc_htcPhoto:DisplayObject;
	var _mc_ohterPhoto:DisplayObject;
	var _mc_htc:DisplayObject;
	var _mc_other:DisplayObject;	
	var _mc_photo:DisplayObjectContainer;

	public function new() 
	{
		super();
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_circleButton':
					_mc_circleButton = cast( obj, MovieClip );
				case 'mc_htc':
					_mc_htc = obj;
				case 'mc_dot':
					_mc_dot = obj;
				case 'mc_bar':
					_mc_bar = obj;
				case 'mc_htcPhoto':
					_mc_htcPhoto = obj;
				case 'mc_otherPhoto':
					_mc_ohterPhoto = obj;
				case 'mc_other':
					_mc_other = obj;
				case 'mc_photo':
					_mc_photo = cast( obj, DisplayObjectContainer );
					
			}
		});
	
	//	_mc_circleButton.gotoAndPlay( 'htc' );
	//	_mc_circleButton.gotoAndPlay( 'other' );
	
		//btn_onTechCameraClick_sub
		//btn_onTechCameraClick_plus
		//btn_onTechCameraClick_switch
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechCamera', path:'src/TechCamera.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechCamera', path:'TechCamera' };
	}
}