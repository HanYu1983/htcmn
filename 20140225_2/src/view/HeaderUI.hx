package view ;

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
	var _mc_overline:DisplayObject;
	var barHeight:Int = 45;
	var _btn_onHeaderBtnClick_skip: DisplayObject;
	var _mc_mask:DisplayObject;
	
	public function new() 
	{
		super();
		needLoading = false;
		layerName = 'ui';
	}
	
	public function setSkipButtonVisible(b:Bool) {
		Tweener.addTween( _btn_onHeaderBtnClick_skip, { alpha: b? 1: 0, time: 1 } );
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
			Tweener.addTween(_btns, { y: v ? 0 : -barHeight, time: 1 } );
			Tweener.addTween(_bar, { y: v ? 0 : -barHeight, time: 1 } );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_mask':
					_mc_mask = obj;
				case 'mc_btns':
					_btns = obj;
				case 'mc_bar':
					_bar = obj;
				case 'mc_extend':
					_btn_extend = obj;
					
				case 'mc_overline':
					_mc_overline = obj;
				case 'btn_onHeaderBtnClick_skip':
					_btn_onHeaderBtnClick_skip = obj;
			}
		});
		extendButtonVisible( false );
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
		_btns.addEventListener( 'overline', moveOverLine );
		_btn_onHeaderBtnClick_skip.alpha = 0;
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		_btns.removeEventListener( 'overline', moveOverLine );
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
		_btn_onHeaderBtnClick_skip.y = h - 30;
	}
	
	var _enableAutoBar :Bool = false;
	var _duration_outside : Int = 0;
	public function autoBarEnable(b:Bool) {
		_enableAutoBar = b;
	}
	
	function onEnterFrame(e: Event) {
		if ( !_enableAutoBar )
			return;
		
		var delayFrame = 30;
		var isEnterBarRegin = stage.mouseY < barHeight && stage.mouseX > 500;
		
		if ( isEnterBarRegin ) {
			extendButtonVisible(false);
			animateShowBar(true);
			_duration_outside = 0;
		}else {
			var shouldAnimateClose = _duration_outside > delayFrame;
			if ( shouldAnimateClose ) {
				extendButtonVisible(true);
				animateShowBar(false);
			}
			++_duration_outside;
		}
	}
	
	function moveOverLine( e ):Void {
		Tweener.addTween( _mc_overline, { 	x:Reflect.field( _btns, 'overX' ),
											alpha:1,
											width:Reflect.field( _btns, 'overWidth' ),
											time:.5 } );							
		
		Tweener.addTween( _mc_overline, { 	alpha:0, delay:.5, time:.5 } );
	}
}