package view.tech;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.media.SoundMixer;
import haxe.remoting.FlashJsConnection;
import helper.IHasAnimationShouldStop;
import helper.IResize;
import helper.Tool;
import org.vic.utils.BasicUtils;
import view.DefaultPage;

/**
 * ...
 * @author han
 */
class DefaultTechPage extends DefaultPage implements IHasAnimationShouldStop
{
	var _mc_person:MovieClip;
	var _mc_controller:MovieClip;
	
	public function new() 
	{
		super();
		layerName = 'techpage';
		useFakeLoading = true;
	}
	

	public function stopAllAnimation() {
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				cast( obj, MovieClip).stop();
			}
		});
		SoundMixer.stopAll();
		//cast( _mc_person, MovieClip ).stop();
	}
	
	public function resumeAllAnimation() {
		if ( cast( _mc_item, MovieClip ).currentLabel == 'forScript' ) {
			return;
		}
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				var mc = cast( obj, MovieClip );
				if ( mc.currentFrame == mc.totalFrames ) {
					return;
				}
				mc.play();
			}
		});
		//cast( _mc_person, MovieClip ).play();
	}
	
	public function skipAnimation() {
		cast( _mc_person, MovieClip ).onSkip();
		cast( _mc_item, MovieClip ).onSkip();
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		super.onResize(x, y, w, h );
		if ( _mc_person != null ) {
			Tool.centerForceY( _mc_person, 768, y, h, .6 );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_person':
					_mc_person = cast( obj, MovieClip );
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
			}
		});
		if( _mc_controller != null ) _mc_controller.visible = false;
		getRoot().addEventListener( 'forScript', forScript );
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{		
		skipAnimation();
		super.onCloseEvent(cb);
	}
	
	function forScript( e ) {
		if ( _mc_controller != null ) _mc_controller.visible = true;
		SimpleController.onDefaultTechPageAnimationEnded( this );
	}
}