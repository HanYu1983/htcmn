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
	var _mc_back:MovieClip;
	var _mc_item:MovieClip;
	var _mc_popup:MovieClip;
	
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
					_mc_back = cast(obj, MovieClip);
				case 'mc_item':
					_mc_item = cast(obj, MovieClip);
				case 'mc_popup':
					_mc_popup = cast(obj, MovieClip);
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
		if ( _mc_item != null ) {
			cast( _mc_item, MovieClip ).stop();
		}
		
		SoundMixer.stopAll();
		super.onCloseEvent(cb);
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		if ( _mc_item != null ) {
			var fix_width = 1500.0;
			var fix_height = 768.0;
			
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
	}
}