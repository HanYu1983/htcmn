package view.tech;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.errors.Error;
import flash.events.MouseEvent;
import flash.media.SoundMixer;
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

	public function new() 
	{
		super();
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
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
		// 不需要消失
		//showTextWithType( target );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		if ( btn_Switch != null ) {
			btn_Switch.removeEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		}
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechDolby', path:'src/TechDolby.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDolby', path:'TechDolby' };
	}
}