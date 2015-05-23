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