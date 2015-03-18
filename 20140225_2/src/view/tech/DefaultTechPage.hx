package view.tech;
import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.Lib;
import flash.media.SoundMixer;
import flash.net.drm.DRMURLDownloadContext;
import flash.utils.SetIntervalTimer;
import haxe.remoting.FlashJsConnection;
import haxe.Timer;
import helper.IHasAnimationShouldStop;
import helper.IResize;
import helper.Tool;
import model.Const;
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
	var mc_bubble:MovieClip;
	
	public function new() 
	{
		super();
		layerName = 'techpage';
		useFakeLoading = true;
	}
	
	public function stopAllAnimation() {
		closeRequestAnimationTimer();
		BasicUtils.stopMovieClip( getRoot() );
		SoundMixer.stopAll();
		scriptEnable = false;
	}
	
	public function resumeAllAnimation() {
		openRequestAnimationTimer();
		BasicUtils.playMovieClip( getRoot() );
		scriptEnable = true;
	}
	
	public function skipAnimation() {
		getRoot().skipAllAnimation();
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		super.onResize(x, y, w, h );
		if ( _mc_person != null ) {
			_mc_person.x = 0;
			Tool.centerForceY( _mc_person, 600, y, h );
			//_mc_person.y = h - 650;
		}
		if ( mc_bubble != null ) {
			mc_bubble.y = _mc_person.y;
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
				case 'mc_bubble':
					mc_bubble = cast( obj, MovieClip );
			}
		});
		getRoot().addEventListener( 'forScript', forScript );
		super.onOpenEvent(param, cb);
		
		SoundMixer.stopAll();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{	
		closeRequestAnimationTimer();
		getRoot().closeAllAnimation();
		super.onCloseEvent(cb);
	}
	
	var scriptEnable = false;
	
	public function isScriptEanbled():Bool {
		return scriptEnable;
	}
	
	function forScript( e ) {
		scriptEnable = true;
		openRequestAnimationTimer();
		SimpleController.onDefaultTechPageAnimationEnded( this );
		/*
		if ( _mc_controller != null ) {
			_mc_controller.alpha = 0;
			Tweener.addTween( _mc_controller, {alpha:1, time:1 } );
		}*/
	}
	
	// ============ Request Wait Animation Timer ==================//
	
	var delayStart:Timer;
	
	function openRequestAnimationTimer( delay: Int = 0 ) {
		delayStart = Timer.delay( requestWaitAnimationInterval, delay );
	}
	
	function closeRequestAnimationTimer() {
		if ( delayStart != null) {
			delayStart.stop();
			delayStart = null;
		}
		if ( requestAnimationTimer != null) {
			requestAnimationTimer.stop();
			requestAnimationTimer = null;
		}
		if ( timer != null ) {
			timer.stop();
			timer = null;
		}
	}
	
	var requestAnimationTimer: Timer;
	
	function requestWaitAnimationInterval() {
		if ( requestAnimationTimer != null ) {
			requestAnimationTimer.stop();
			requestAnimationTimer = null;
		}
		requestWaitAnimation();
		requestAnimationTimer = Timer.delay( requestWaitAnimationInterval, 1000 * Const.PEOPLE_PLAY_WAIT_DURATION_SECONDS );
	}
	
	var timer: Timer = null;	
	public function requestWaitAnimation() {
		if ( timer != null ) {
			timer.stop();
			timer = null;
		}
		timer = Timer.delay( function() {
			getRoot().playWait();
		}, 1000* 19 );
	}
	
	
}