package page ;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.sampler.NewObjectSample;
import helper.IResize;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class HeaderUI extends DefaultPage
{

	var _btns:DisplayObject;
	var _bar:DisplayObject;
	var _btn_extend:DisplayObject;
	var barHeight:Int = 45;
	
	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	private var _extendButtonVisible:Bool = true;
	
	public function extendButtonVisible(v:Bool) {
		if ( _extendButtonVisible != v ) {
			_extendButtonVisible = v;
			Tweener.addTween(_btn_extend, { alpha: v ? 1 : 0, time: 1 } );
		}
	}
	
	private var _animateShowBar:Bool = true;
	
	public function animateShowBar(v:Bool) {
		if ( _animateShowBar != v ) {
			_animateShowBar = v;
			Tweener.addTween(getRoot(), { y: v ? 0 : -barHeight, time: 1 } );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_btns':
					_btns = obj;
				case 'mc_bar':
					_bar = obj;
				case 'mc_extend':
					_btn_extend = obj;
					_btn_extend.alpha = 0;
			}
		});
		
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'header', path:'src/Header.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'header', path:'Header' };
	}
	
	var _sw:Int = 1024;
	
	override public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		_btns.x = w - _btns.width;
		_bar.width = w;
		_sw = w;
	}
	
	var _enableAutoBar :Bool = false;
	public function autoBarEnable(b:Bool) {
		_enableAutoBar = b;
	}
	
	function onEnterFrame(e: Event) {
		if ( !_enableAutoBar )
			return;
			
		var isEnterBarRegin = stage.mouseY < barHeight && stage.mouseX > 200;
		if ( isEnterBarRegin ) {
			extendButtonVisible(false);
			animateShowBar(true);
		}else {
			extendButtonVisible(true);
			animateShowBar(false);
		}
	}
}