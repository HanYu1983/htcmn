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
	var flv_container:DisplayObjectContainer;
	var mc_dot:MovieClip;
	var isNormal:Bool = true;
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
		
		_mc_item.addEventListener( 'step1', onStep1 );
		_mc_item.addEventListener( 'step2', onStep2 );
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
					flv_container = cast( obj, DisplayObjectContainer );
				case 'mc_dot':
					mc_dot = cast( obj, MovieClip );
			}
		});
		
		btn_Switch.buttonMode = true;
		btn_Switch.addEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		
		showVideo( 'dolby' );
	}
	
	function onStep1(e) {
		//soundASoundChannel = soundA.play();
		//soundBSoundChannel = soundB.play();
		
		//changeVolumn( soundASoundChannel, 0 );
	}
	
	function onStep2(e) {
		//changeVolumn( soundASoundChannel, 1 );
		//changeVolumn( soundBSoundChannel, 0 );
	}
	
	function changeVolumn( soundChannel:SoundChannel, volumn ) {
		var st = soundChannel.soundTransform;
		st.volume = volumn;
		soundChannel.soundTransform = st;
	}
	
	function showVideo( type: String ) {
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
			getRoot().playRespond();
			requestWaitAnimation();
		}
		// 不需要消失
		//showTextWithType( target );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		if ( btn_Switch != null ) {
			btn_Switch.removeEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		}
		
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