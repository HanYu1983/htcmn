package view.tech;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.errors.Error;
import flash.events.MouseEvent;
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
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		soundA = new Sound();
		soundA.load( new URLRequest( getWebManager().getData( 'config' ).sound.techDolby.htc ));
		
		soundB = new Sound();
		soundB.load( new URLRequest( getWebManager().getData( 'config' ).sound.techDolby.other ));
		
		getRoot().addEventListener( 'onSoundAStart', onSoundAStart );
		getRoot().addEventListener( 'onSoundBStart', onSoundBStart );
		getRoot().addEventListener( 'onSoundBStop', onSoundBStop );
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
				case 'mc_elec':
					mc_elec = cast( obj, MovieClip );
				case 'mc_panel':
					mc_panel = obj;
				case 'btn_play':
					btn_play = new BasicButton( cast( obj, MovieClip ));
				case 'btn_stop':
					btn_stop = new BasicButton( cast( obj, MovieClip ));
			}
		});
		
		closeAllSound();
		
		Tweener.addTween( flv_container, { alpha:1, time:1 } );
		showPanelWith( btn_play );
		
		btn_Switch.buttonMode = true;
		btn_Switch.addEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		
		wakeUpButton( btn_play, false );
		wakeUpButton( btn_stop, false );
		
		btn_play.getShape().addEventListener( MouseEvent.CLICK, onBtnPlayClick );
		btn_stop.getShape().addEventListener( MouseEvent.CLICK, onBtnStopClick );
		
		//btn_stop.buttonMode = true;
		//btn_play.buttonMode = true;
		//showVideo( 'dolby' );
	}
	
	function showPanelWith( btn ) {
		if ( isPlay ) {
			btn_stop.getShape().visible = true;
			btn_play.getShape().visible = false;
		}else {
			btn_stop.getShape().visible = false;
			btn_play.getShape().visible = true;
		}
		Tweener.addTween( mc_panel, { alpha:1, time:1 } );
	}
	
	function onBtnPlayClick( e ) {
		flv_container.gotoAndPlay( 2 );
		isPlay = true;
		Tweener.addTween( mc_panel, { alpha:0, time:1 } );
		
		if ( soundASoundChannel == null ) {
			onSoundAStart( null );
		}else {
			changeSoundToNormal();
		}
	}
	
	function onBtnStopClick( e ) {
		flv_container.stop();
		isPlay = false;
		Tweener.addTween( mc_panel, { alpha:0, time:1 } );
	}
	
	
	function onSoundAStart(e) {
		soundASoundChannel = soundA.play();
		soundBSoundChannel = soundB.play();
		
		changeSoundToNormal();
	}
	
	function onSoundBStart(e) {
		changeSoundToDolby();
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
		trace( type );
		switch( type ) {
			case 'dolby':
				changeSoundToDolby(); 
			case 'normal':
				changeSoundToNormal();
		}
		/*
		var currframe = 1;
		if ( currVideo != null ) {
			SoundMixer.stopAll();
			currframe = currVideo.currentFrame;
			flv_container.removeChild( currVideo );
			currVideo = null;
		}
		var video = switch( type ) {
			case 'dolby':
				cast( getWebManager().getLoaderManager().getTask( 'TechDolby' ).getObject( 'flv_videoA' ), MovieClip );
			case _:
				cast( getWebManager().getLoaderManager().getTask( 'TechDolby' ).getObject( 'flv_videoA' ), MovieClip );
		}
		
		if ( currframe == 1 ) {
			video.gotoAndPlay( 'play' );
		} else {
			video.gotoAndPlay( currframe );
		}
		
		flv_container.addChild( video );
		currVideo = video;
		*/
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
		showVideo( target );
		showPhoneWithType( target );
		if ( target == 'dolby' ) {
			_mc_person.onSkip();
			//getRoot().playRespond();
			//requestWaitAnimation();
		}
		// 不需要消失
		//showTextWithType( target );
	}
	
	function closeAllSound() {
		try{
			if ( soundA != null ) {
				soundA.close();
				soundASoundChannel.stop();
			}
			if ( soundB != null ) {
				soundB.close();
				soundBSoundChannel.stop();
			}
		}catch ( e:Error ) {
			//sound還沒開始串流時，不能呼叫close，暫時不知道怎麼檢查，先用例外把它處理掉
		}
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