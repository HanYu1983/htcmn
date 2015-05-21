package view ;

import caurina.transitions.JSTweener.JSObject;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import helper.IResize;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class FooterUI extends DefaultPage
{
	var _back:MovieClip;
	var _righter:DisplayObject;
	var _music:MovieClip;
	var _mc_btns:DisplayObject;
	var mc_rightBtns:DisplayObject;

	public function new() 
	{
		super();
		needLoading = false;
		layerName = 'footerui';
	}
	
	public function switchMusic() {
		_music.gotoAndStop( _music.currentFrame == 1 ? 2 : 1 );
	}
	
	private var _animateShowBar:Bool = true;
	
	public function animateShowBar(v:Bool) {
		var barHeight:Int = 45;
		if ( _animateShowBar != v ) {
			_animateShowBar = v;
			Tweener.addTween(_back, { y: v ? 0 : barHeight, alpha: v? 1 :0, time: 1 } );
			Tweener.addTween(_mc_btns, { y: v ? 0 : barHeight, alpha: v? 1:0, time: 1 } );
			Tweener.addTween(mc_rightBtns, { y: v ? 0 : barHeight, alpha: v? 1:0, time: 1 } );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_footback':
					_back = cast( obj, MovieClip );
				case 'mc_righter':
					_righter = obj;
				case 'mc_music':
					_music = cast( obj, MovieClip );
				case 'mc_btns':
					_mc_btns = obj;
				case 'mc_rightBtns':
					mc_rightBtns = obj;
					
			}
		});
		
		//getRoot().mouseChildren = false;
		//getRoot().enabled = false;
		//_back.enabled = false;
		//_back.mouseChildren = false;
		
		_music.visible = false;
		super.onOpenEvent(param, cb);
	}
	/*
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'Footer', path:config.swfPath.Footer[ config.swfPath.Footer.which ] };
	}
	*/
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'Footer' };
	}
	
	override public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		if( _back != null ){
			_back.width = w;
			//getRoot().y = h - _back.height;
			getRoot().y = h - 110;
		}
		if ( _righter != null ) {
			_righter.x = w - _righter.width;
		}
		if ( mc_rightBtns != null ) {
			mc_rightBtns.x = w - 510;
		}
	}

}