package view.tech;

import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.errors.Error;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundMixer;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import helper.IResize;
import helper.Tool;
import model.AppAPI;
import model.DolbySoundMediator;
import model.SoundManager;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;
import view.DefaultPage;
import view.MoviePage;

/**
 * ...
 * @author han
 */
class TechDolby extends DefaultTechPage
{
	var mc_controller:DisplayObjectContainer;
	var btn_Switch:MovieClip;
	var mc_txtA:DisplayObject;
	var mc_txtB:DisplayObject;
	var mc_phone:MovieClip;
	var mc_htc:DisplayObject;
	var mc_other:DisplayObject;
	var flv_videoA:MovieClip;
	var flv_videoB:MovieClip;
	var flv_container:MovieClip;
	var mc_dot:MovieClip;
	var mc_elec:MovieClip;
	var mc_panel:DisplayObject;
	var btn_play:BasicButton;
	var btn_stop:BasicButton;
	var mc_dolbyTxt:DisplayObject;
	var mc_otherTxt:DisplayObject;
	var isNormal:Bool = true;
	var isPlay:Bool = false;
	var currVideo:MovieClip;
	var dolbyMediator:DolbySoundMediator = new DolbySoundMediator( SoundType.Normal );
	var soundManager:SoundManager = new SoundManager();
	var btn_onTechDolbyClick_movie:MovieClip;
	
	public function new() 
	{
		super();
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		soundManager.getFromWebManager( getWebManager(), [
			{ key:"D_respond_01", path:"TechDolby/D_respond _01_1.mp3" },
			// 這段改為影片播
			//{ key:"intro_02_1", path:"TechDolby/intro_02_1_1.mp3" }
		] );
		
		dolbyMediator.getFromWebManager( getWebManager(), {
			htc: "TechDolby/dolby_1.mp3",
			other: "TechDolby/other_1.mp3"
		});
		
		getRoot().addEventListener( 'onSoundAStart', onSoundAStart );
		getRoot().addEventListener( 'onSoundBStart', onSoundBStart );
		getRoot().addEventListener( 'onSoundBStop', onSoundBStop );
		
		getRoot().addEventListener( 'onFlvIntro02', onFlvIntro02 );
		getRoot().addEventListener( 'onFlvRespond01', onFlvRespond01 );
		getRoot().addEventListener( 'onFlvEnter01', onFlvEnter01 );
		
		super.onOpenEvent( param, cb );
	}
	
	var ch: SoundChannel;
	
	function speech( key:String ) {
		stopSpeech();
		ch = soundManager.play( key );
	}
	
	function stopSpeech() {
		if ( ch != null ) {
			ch.stop();
			ch = null;
		}
	}
	
	override function forScript(e) 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'btn_Switch':
					btn_Switch = cast( obj, MovieClip );
				case 'mc_txtA':
					mc_txtA = obj;
				case 'mc_txtB':
					mc_txtB = obj;
				case 'mc_phone2':
					mc_phone = cast( obj, MovieClip );
				case 'flv_container':
					flv_container = cast( obj, MovieClip );
				case 'mc_dot':
					mc_dot = cast( obj, MovieClip );
				case 'mc_elec2':
					mc_elec = cast( obj, MovieClip );
				case 'mc_panel':
					mc_panel = obj;
				case 'btn_play':
					btn_play = new BasicButton( cast( obj, MovieClip ));
				case 'btn_stop':
					btn_stop = new BasicButton( cast( obj, MovieClip ));
				case 'mc_otherTxt':
					mc_otherTxt = obj;
				case 'mc_dolbyTxt':
					mc_dolbyTxt = obj;
				case 'btn_onTechDolbyClick_movie':
					btn_onTechDolbyClick_movie = cast(obj, MovieClip);
				case 'mc_htc':
					mc_htc = obj;
				case 'mc_other':
					mc_other = obj;
			}
		});
		
		btn_Switch.buttonMode = true;
		btn_Switch.addEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		btn_play.getShape().addEventListener( MouseEvent.CLICK, onBtnPlayClick );
		btn_stop.getShape().addEventListener( MouseEvent.CLICK, onBtnStopClick );
		
		btn_onTechDolbyClick_movie.buttonMode = true;
		btn_onTechDolbyClick_movie.addEventListener( MouseEvent.CLICK, onTechDolbyMovieClick );
		
		flv_container.addFrameScript( flv_container.totalFrames - 1, function() {
			showPlayButton();
		} );
		
		super.forScript(e);
		// Dolby頁不播Wait動作, 所以在super.forScript()之後, 將AnimationTimer關掉
		// super.forScript()會openRequestAnimationTimer()
		closeRequestAnimationTimer();
		onInitControl();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		if ( btn_Switch != null ) {
			btn_Switch.removeEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		}
		
		dolbyMediator.stop();
		stopSpeech();
		
		if( flv_container != null )
			flv_container.addFrameScript( flv_container.totalFrames - 1, null );
		
		getRoot().removeEventListener( 'onSoundAStart', onSoundAStart );
		getRoot().removeEventListener( 'onSoundBStart', onSoundBStart );
		getRoot().removeEventListener( 'onSoundBStop', onSoundBStop );
		
		getRoot().removeEventListener( 'onFlvIntro02', onFlvIntro02 );
		getRoot().removeEventListener( 'onFlvRespond01', onFlvRespond01 );
		getRoot().removeEventListener( 'onFlvEnter01', onFlvEnter01 );
		
		if( btn_onTechDolbyClick_movie != null )
			btn_onTechDolbyClick_movie.removeEventListener( MouseEvent.CLICK, onTechDolbyMovieClick );
		
		
		super.onCloseEvent(cb);
	}
	
	// ======================== Control ===============================//
	
	function onFlvIntro02( e ) {
		// 這段改為影片播
		//speech("intro_02_1");
	}
	
	function onFlvRespond01( e ) {
		speech("D_respond_01");
	}
	
	function onFlvEnter01( e ) {
		// 目前聲音還在影片上
		//speech("D_enter_01_1");
	}
	
	function onTechDolbyMovieClick( e ) {
		SimpleController.onButtonInteract( e.currentTarget );
		var config = getWebManager().getData( 'config' );
		Tool.getURL( config.url.techDolby );
	}
	
	function onInitControl() {
		initView();
		playMovie();
		showStopButton();
	}
	
	function onBtnSwitchClick( e ) {
		SimpleController.onButtonInteract( e.currentTarget );
		var target = toggleSwitch();
		showDescWithType( target );
		showPhoneWithType( target );
		changeElecEffectWithType( target );
		dolbyMediator.toggle( isPlay );
		if ( target == 'dolby' ) {
			// 取消互動
			//getRoot().playRespond();
		} else {
			stopSpeech();
			// 取消互動後, STOP動作也不需要了
			//getRoot().playStop();
		}
		// 也不要Wait動作
		// requestWaitAnimation();
		closeHint();
	}
	
	function onBtnPlayClick( e ) {
		SimpleController.onButtonInteract( e.currentTarget );
		playMovie();
		showStopButton();
		//closeRequestAnimationTimer();
	}
	
	function onBtnStopClick( e ) {
		SimpleController.onButtonInteract( e.currentTarget );
		stopMovie();
		showPlayButton();
		// 不要Wait動作
		//openRequestAnimationTimer();
	}
	
	function onSoundAStart(e) {
		dolbyMediator.play();
	}
	
	function onSoundBStart(e) {
		dolbyMediator.toggle();
	}
	
	function onSoundBStop( e ) {
		dolbyMediator.stop();
		dolbyMediator.toggle(); // toggle到Normal的聲道
	}
	
	// ======================= View =============================//
	
	function initView() {
		mc_elec.visible = true;
		mc_elec.alpha = 1;
	
		Tweener.addTween( flv_container, { alpha:1, time:.5 } );
		showDescWithType( currSwitchLabel );
	}
	
	function showPlayButton() {
		sleepButton( btn_stop );
		btn_stop.enable( false );
		
		wakeUpButton( btn_play, false );
		btn_play.enable( true );
		
		Tweener.addTween( btn_play.getShape(), { alpha: 1, time: 0.3 } );
		Tweener.addTween( btn_stop.getShape(), { alpha: 0, time: 0.3 } );
	}
	
	function showStopButton() {
		sleepButton( btn_play );
		btn_play.enable( false );
		
		wakeUpButton( btn_stop, false );
		btn_stop.enable( true );
		Tweener.addTween( btn_stop.getShape(), { alpha: 1, time: 0.3 } );
		Tweener.addTween( btn_play.getShape(), { alpha: 0, time: 0.3 } );
	}

	var currtime = 0.0;
	
	function playMovie() {
		isPlay = true;
		
		if ( flv_container.currentFrame == 1 ) {
			flv_container.gotoAndPlay( 2 );
			currtime = 0;

		} else if ( flv_container.currentFrame == flv_container.totalFrames ) {
			flv_container.gotoAndPlay( 2 );
			currtime = 0;

		} else {
			flv_container.play();
			
		}
		
		dolbyMediator.play( currtime );
	}
	
	function stopMovie() {
		isPlay = false;
		currtime = dolbyMediator.stop();
		flv_container.stop();
	}
	
	var currSwitchLabel = 'normal';
	
	function toggleSwitch():String {
		var target = currSwitchLabel == 'dolby' ? 'normal' : 'dolby';
		mc_dot.gotoAndPlay( target );
		currSwitchLabel = target;
		return currSwitchLabel;
	}
	
	function showPhoneWithType( type:String ) {
		mc_phone.gotoAndPlay( type );
		
		if ( type == 'dolby' ) {
			Tweener.addTween( mc_other, { alpha:0, time:.5 } );
			Tweener.addTween( mc_htc, { alpha:1, time:.5 } );
		}else {
			Tweener.addTween( mc_other, { alpha:1, time:.5 } );
			Tweener.addTween( mc_htc, { alpha:0, time:.5 } );
		}
	}
	
	function showDescWithType( type:String ){
		if ( type == 'dolby' ) {
			Tweener.addTween( mc_otherTxt, { alpha:0, time:.5 } );
			Tweener.addTween( mc_dolbyTxt, { alpha:1, time:.5 } );
			
		}else {
			Tweener.addTween( mc_otherTxt, { alpha:1, time:.5 } );
			Tweener.addTween( mc_dolbyTxt, { alpha:0, time:.5 } );
			
		}
	}
	
	function showTextWithType( type:String ) {
		switch( type ) {
			case 'dolby':
				Tweener.addTween( mc_txtB, { alpha: 1, time: .5 } );
				Tweener.addTween( mc_txtA, { alpha: 0, time: .5 } );
			case _:
				Tweener.addTween( mc_txtA, { alpha: 1, time: .5 } );
				Tweener.addTween( mc_txtB, { alpha: 0, time: .5 } );
				
		}
	}
	
	function changeElecEffectWithType( type:String ) {
		mc_elec.gotoAndPlay( type == 'dolby' ? 'loop' : 'stand' );
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechDolby', path:config.swfPath.TechDolby[ config.swfPath.TechDolby.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDolby', path:'mc_anim' };
	}
}