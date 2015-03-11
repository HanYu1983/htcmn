package view.tech;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
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
					
				case 'flv_videoA':
					//flv_videoA = cast( obj, MovieClip );
				case 'flv_videoB':
					//flv_videoB = cast( obj, MovieClip );
					
				case 'flv_container':
					flv_container = cast( obj, DisplayObjectContainer );
				case 'mc_dot':
					mc_dot = cast( obj, MovieClip );
			}
		});
		
		btn_Switch.buttonMode = true;
		btn_Switch.addEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		
		/* 產生a影片
		flv_videoA = cast( getWebManager().getLoaderManager().getTask( 'TechDolby' ).getObject( 'flv_videoA' ), MovieClip );
		flv_container.addChild( flv_videoA );
		
		產生b影片
		flv_videoA = cast( getWebManager().getLoaderManager().getTask( 'TechDolby' ).getObject( 'flv_videoB' ), MovieClip );
		flv_container.addChild( flv_videoA );
		
		產生的影片要乎叫這個才會有聲音
		flv_videoA.gotoAndPlay( 'play' );
		*/
	}
	
	function onBtnSwitchClick( e ) {
		//選項
		//mc_phone.gotoAndPlay( 'dolby' );//normal, dolby
		//mc_dot.gotoAndPlay( 'dolby' );//normal, dolby
		
		//移除影片
		//SoundMixer.stopAll();
		//flv_container.removeChild( flv_videoA );
		//flv_container.removeChild( flv_videoB );
		
		//trace( mc_dot );
		//mc_txtA.visible = false;
		//mc_txtB.visible = false;
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		
		if ( btn_Switch != null ) {
			btn_Switch.removeEventListener( MouseEvent.CLICK, onBtnSwitchClick );
		}
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