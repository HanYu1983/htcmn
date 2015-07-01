package view;

import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.media.SoundMixer;
import helper.IHasAnimationShouldStop;
import helper.IResize;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class IntroPage extends DefaultPage implements IHasAnimationShouldStop
{

	public function new() 
	{
		super();
		needLoading = true;
		layerName = 'page';
	}
	
	public function stopAllAnimation() {
		SimpleController.stagePause( getRoot().stage );
	}
	
	public function resumeAllAnimation() {
		SimpleController.stageStart();
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			var fix_width = 1600.0;
			var fix_height = 1000.0;
			
			if ( w < fix_width ) {
				var scale = Math.max(w, 1024.0) / fix_width;
				_mc_item.scaleX = _mc_item.scaleY = scale;
				Tool.centerForce( _mc_item, fix_width* scale, fix_height* scale, x, y, w, h );
			} else {
				_mc_item.scaleX = _mc_item.scaleY = 1;
				Tool.centerForce( _mc_item, fix_width, fix_height, x, y, w, h );
			}
		}
		if ( _mc_popup != null ) {
			Tool.center(_mc_popup, x, y, w, h);
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
		
		if ( _mc_item != null ) {
			_mc_item.x += 150;
			_mc_item.y += 90;
		}
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'Intro', path:config.swfPath.Intro[ config.swfPath.Intro.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Intro', path:'Intro' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
	
}