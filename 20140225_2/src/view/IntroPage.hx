package view;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.media.SoundMixer;
import helper.IHasAnimationShouldStop;
import helper.IResize;
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
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				cast( obj, MovieClip).stop();
			}
		});
		SoundMixer.stopAll();
	}
	
	public function resumeAllAnimation() {
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				var mc = cast( obj, MovieClip );
				if ( mc.currentFrame == mc.totalFrames ) {
					return;
				}
				mc.play();
			}
		});
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Intro', path:'src/Intro.swf' };
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