package view.tech;

import caurina.transitions.Tweener;
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
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;
import view.DefaultPage;

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
	var soundA:Sound;
	var soundB:Sound;
	var soundASoundChannel:SoundChannel;
	var soundBSoundChannel:SoundChannel;

	public function new() 
	{
		super();
	}
	
	// 為了onMp3LoadComplete可以叫用super的方法而建立
	// 這個方法只用來呼叫super的onOpenEvent沒有其它功能.
	public function helpCallSuperOnOpenEvent(param:Dynamic, cb:Void->Void) {
		super.onOpenEvent( param, cb );
	}
	
	function onMp3LoadComplete( that, param, cb ) {
		var count = 0;
		return function( e:Event ) {
			if ( ++count == 2 ) {
				that.helpCallSuperOnOpenEvent( param, cb );
			}
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		var onComplete = onMp3LoadComplete( this, param, cb );
		
		soundA = new Sound();
		soundA.addEventListener( Event.COMPLETE, onComplete );
		soundA.load( new URLRequest( getWebManager().getData( 'config' ).sound.techDolby.htc ));
		
		soundB = new Sound();
		soundB.addEventListener( Event.COMPLETE, onComplete );
		soundB.load( new URLRequest( getWebManager().getData( 'config' ).sound.techDolby.other ));
		
		
		
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'btn_Switch':
					btn_Switch = cast( obj, MovieClip );
				case 'mc_txtA':
					mc_txtA = obj;
				case 'mc_txtB':
					mc_txtB = obj;
				case 'mc_phone':
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
			}
		});
		mc_elec.visible = true;
		mc_elec.alpha = 1;
		closeAllSound();
		
		Tweener.addTween( flv_container, { alpha:1, time:.5 } );
		showDescWithType( currSwitchLabel );
		//showPanel();
		
		flv_container.addEventListener( MouseEvent.MOUSE_OVER, onMovieOver );
		
		btn_Switch.buttonMode = true;
		btn_Switch.addEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		
		wakeUpButton( btn_play, false );
		wakeUpButton( btn_stop, false );
		
		btn_play.getShape().addEventListener( MouseEvent.CLICK, onBtnPlayClick );
		btn_stop.getShape().addEventListener( MouseEvent.CLICK, onBtnStopClick );
		getRoot().addEventListener( 'onSoundAStart', onSoundAStart );
		getRoot().addEventListener( 'onSoundBStart', onSoundBStart );
		getRoot().addEventListener( 'onSoundBStop', onSoundBStop );
		
		//btn_stop.buttonMode = true;
		//btn_play.buttonMode = true;
		//showVideo( 'dolby' );
		
		onBtnPlayClick(null);
		//flv_container.gotoAndPlay( 2 );
		//showPhoneWithType( currSwitchLabel );
		//showDescWithType( currSwitchLabel );
		
		addEventListener( Event.ENTER_FRAME, checkOverPanel );
	}
	
	function checkOverPanel( e ) {
		if ( mc_panel.visible == false )	return;
		if ( mc_panel.alpha != 1 )	return;
		var local = getRoot().globalToLocal( new Point(stage.mouseX, stage.mouseY) );
		var hitRect = mc_panel.getRect( getRoot() );
		var isHitRegion = ( local.y > hitRect.top && local.y < hitRect.bottom &&
							local.x > hitRect.left && local.x < hitRect.right );
		if ( !isHitRegion ) {
			closePanel();
		}
	}
	
	function onMovieOver( e ) {
		mc_panel.visible = true;
		showPanel();
	}
	
	function showPanel() {
		if ( isPlay ) {
			btn_stop.getShape().visible = true;
			btn_play.getShape().visible = false;
		}else {
			btn_stop.getShape().visible = false;
			btn_play.getShape().visible = true;
		}
		Tweener.addTween( mc_panel, { alpha:1, time:.5 } );
	}
	
	function closePanel() {
		Tweener.addTween( mc_panel, { alpha:0, time:.5, onComplete:function() {
			mc_panel.visible = false;
		}});
	}
	
	function onBtnPlayClick( e ) {
		isPlay = true;
		flv_container.gotoAndPlay( 2 );
		showPhoneWithType( currSwitchLabel );
		if( currSwitchLabel == 'dolby' )	mc_elec.gotoAndPlay( 'loop' );
		showDescWithType( currSwitchLabel );
		closePanel();
	}
	
	function onBtnStopClick( e ) {
		isPlay = false;
		flv_container.gotoAndStop( 1 );
		showPhoneWithType( 'normal' );
		closeAllSound();
		closePanel();
		mc_elec.gotoAndPlay( 'stand' );
	}
	
	function onSoundAStart(e) {
		soundStartAndThen( changeSoundToNormal );
	}
	
	function onSoundBStart(e) {
		soundStartAndThen( changeSoundToDolby );
	}
	
	function soundStartAndThen( cb ) {
		if ( soundASoundChannel != null ) {
			changeVolumn( soundASoundChannel, 0 );
			soundASoundChannel.stop();
			soundASoundChannel = null;
		}
		if ( soundBSoundChannel != null ) {
			changeVolumn( soundBSoundChannel, 0 );
			soundBSoundChannel.stop();
			soundBSoundChannel = null;
		}
		if( soundASoundChannel == null ){
			soundASoundChannel = soundA.play();
			soundBSoundChannel = soundB.play();
		}
		cb();
	}
	
	function onSoundBStop( e ) {
		changeVolumn( soundASoundChannel, 0 );
		changeVolumn( soundBSoundChannel, 0 );
	}
	
	function changeSoundToDolby() {
		changeVolumn( soundASoundChannel, 1 );
		changeVolumn( soundBSoundChannel, 0 );
	}
	
	function changeSoundToNormal() {
		changeVolumn( soundASoundChannel, 0 );
		changeVolumn( soundBSoundChannel, 1 );
	}
	
	function changeVolumn( soundChannel:SoundChannel, volumn ) {
		if ( soundChannel == null )	return;
		var st = soundChannel.soundTransform;
		st.volume = volumn;
		soundChannel.soundTransform = st;
	}
	
	function showVideo( type: String ) {
		switch( type ) {
			case 'dolby':
				changeSoundToDolby(); 
			case _:
				changeSoundToNormal();
		}
		
		flv_container.gotoAndPlay( 2 );
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
	
	function onBtnSwitchClick( e ) {
		var target = toggleSwitch();
		showDescWithType( target );
		if ( !isPlay )	return;
		
		showPhoneWithType( target );
		
		if ( target == 'dolby' ) {
			_mc_person.onSkip();
			getRoot().playRespond();
			requestWaitAnimation();
		}
		
		closeAllSound();
		
		if ( soundASoundChannel != null ) {
			changeVolumn( soundASoundChannel, 0 );
			soundASoundChannel.stop();
			soundASoundChannel = null;
		}
		if ( soundBSoundChannel != null ) {
			changeVolumn( soundBSoundChannel, 0 );
			soundBSoundChannel.stop();
			soundBSoundChannel = null;
		}
		
		soundASoundChannel = soundA.play();
		soundBSoundChannel = soundB.play();
		
		showVideo( target );
		
		// 不需要消失
		//showTextWithType( target );
	}
	
	function closeAllSound() {
		if ( soundASoundChannel != null ) {
			changeVolumn( soundASoundChannel, 0 );
			soundASoundChannel.stop();
			soundASoundChannel = null;
		}
		if ( soundBSoundChannel != null ) {
			changeVolumn( soundBSoundChannel, 0 );
			soundBSoundChannel.stop();
			soundBSoundChannel = null;
		}
		/*
		try{
			if ( soundA != null ) {
				soundA.close();
			}
			if ( soundB != null ) {
				soundB.close();
			}
		}catch ( e:Error ) {
			
			//sound還沒開始串流時，不能呼叫close，暫時不知道怎麼檢查，先用例外把它處理掉
		}
		*/
		SoundMixer.stopAll();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		if ( btn_Switch != null ) {
			btn_Switch.removeEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		}
		
		closeAllSound();
		
		getRoot().removeEventListener( 'onSoundAStart', onSoundAStart );
		getRoot().removeEventListener( 'onSoundBStart', onSoundBStart );
		getRoot().removeEventListener( 'onSoundBStop', onSoundBStop );
		
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechDolby', path:'src/TechDolby.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDolby', path:'mc_anim' };
	}
}