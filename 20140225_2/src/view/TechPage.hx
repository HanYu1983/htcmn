package view;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.media.SoundMixer;
import haxe.Timer;
import helper.IHasAnimationShouldStop;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends DefaultPage implements IHasAnimationShouldStop
{
	var mc_person:MovieClip;
	var mc_bubble:DisplayObject;
	
	public function new() 
	{
		super();
		layerName = 'page';
		useFakeLoading = true;
	}
	
	public function stopAllAnimation() {
		BasicUtils.stopMovieClip( getRoot() );
		SoundMixer.stopAll();
	}
	
	public function resumeAllAnimation() {
		BasicUtils.playMovieClip( getRoot() );
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_person':
					mc_person = cast( obj, MovieClip );
				case 'mc_bubble2':
					mc_bubble = obj;
			}
		});
		
		disableUnavailableButton();
		
		getRoot().addEventListener( 'on_flv_B_respond_01_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_02_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_03_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_04_finish', on_flv_B_respond_finish );
		
		openRequestAnimationTimer(30* 1000);
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		closeRequestAnimationTimer();
		mc_person.onClose();
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechFront', path:'src/TechFront.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechFront', path:'TechFront' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return true;
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			var fix_width = 1366.0;
			var fix_height = 768.0;
			
			if ( w < fix_width ) {
				var scale = Math.max(w, 1024.0) / fix_width;
				_mc_item.scaleX = _mc_item.scaleY = scale;
				Tool.centerForce( _mc_item, fix_width * scale, fix_height * scale, x, y, w, h, .5, .6 );
				_mc_item.y = 50;
			} else {
				_mc_item.scaleX = _mc_item.scaleY = 1;
				Tool.centerForce( _mc_item, fix_width, fix_height, x, y, w, h, .5, .6 );
				_mc_item.y = 50;
			}
		}
		
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
		
		if ( mc_person != null ) {
			Tool.centerForce( mc_person, 428, 640, x, y, w, h, .53, .6 );
		}
		
		if ( mc_bubble != null ) {
			Tool.centerForce( mc_bubble, 1366, 768, x, y, w, h, .4, .7 );
			mc_bubble.y += 75;
		}
	}
	
	var btnName = '';
	public function onBtnEnterClick( btnName:String ):Void {
		this.btnName = btnName;
		getRoot().dispatchEvent( new Event( btnName ));
	}
	
	function on_flv_B_respond_finish( e ) {
		SimpleController.onFlvBRespondFinished( this.btnName );
	}
	
	function disableUnavailableButton() {
		var disableBtnNames:Array<String> = [
			"btn_onHomeBtnClick_blink",
			"btn_onHomeBtnClick_boom",
			"btn_onHomeBtnClick_person",
			"btn_onHomeBtnClick_photo",
			"btn_onHomeBtnClick_situ"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		function enable(v:Bool):Dynamic{
			return function(btn:BasicButton) {
				btn.enable(v);
				return true;
			}
		}
		
		function alpha(v:Float):Dynamic {
			return function(btn:BasicButton) {
				btn.getShape().alpha = v;
				return true;
			}
		}
		var btns = disableBtnNames.map( getButton );
		Lambda.foreach( btns, enable( false ) );
		Lambda.foreach( btns, alpha( 0.5 ) );
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
		requestAnimationTimer = Timer.delay( requestWaitAnimationInterval, 1000 * 20 );
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