package view;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.media.SoundMixer;
import helper.IResize;
import control.SimpleController;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebView;
import view.tech.DefaultTechPage;
import view.tech.TechFrame;

/**
 * ...
 * @author han
 */
class DefaultPage extends WebView implements IResize
{
	var _mc_back:DisplayObject;
	var _mc_item:DisplayObject;
	var _mc_popup:DisplayObject;
	
	public function new() {
		super();
		SimpleController.onPageNew( this );
		needLoading = true;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_back':
					_mc_back = obj;
				case 'mc_item':
					_mc_item = obj;
				case 'mc_popup':
					_mc_popup = obj;
			}
		});
		super.onOpenEvent(param, cb);
		SimpleController.onPageOpen( getWebManager(), this );
		SimpleController.onResize( getWebManager() );
	}
	
	public function suggestionEnableAutoBarWhenOpen():Null<Bool> {
		return null;
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		SimpleController.onPageClose( getWebManager(), this );
		super.onCloseEvent(cb);
		
		if ( _mc_item != null ) {
			cast( _mc_item, MovieClip ).stop();
		}
		
		SoundMixer.stopAll();
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		if( _mc_item != null ){
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h );
		}
		if ( _mc_popup != null ) {
			Tool.center(_mc_popup, x, y, w, h);
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
}