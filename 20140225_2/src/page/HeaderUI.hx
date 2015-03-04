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
	var _mc_overline:DisplayObject;
	var barHeight:Int = 45;
	
	public function new() 
	{
		super();
		needLoading = false;
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
				case 'mc_overline':
					_mc_overline = obj;
			}
		});
		
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
		_btns.addEventListener( 'overline', moveOverLine );
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
	}
	
	var _enableAutoBar :Bool = false;
	public function autoBarEnable(b:Bool) {
		_enableAutoBar = b;
	}
	
	function onEnterFrame(e: Event) {
		if ( !_enableAutoBar )
			return;
			
		var isEnterBarRegin = stage.mouseY < barHeight;
		if ( isEnterBarRegin ) {
			extendButtonVisible(false);
			animateShowBar(true);
		}else {
			extendButtonVisible(true);
			animateShowBar(false);
		}
	}
	
	function moveOverLine( e ):Void {
		Tweener.addTween( _mc_overline, { 	x:Reflect.field( _btns, 'overX' ),
											alpha:1,
											//transition:'easeOutBack',
											width:Reflect.field( _btns, 'overWidth' ),
											time:.5 } );							
		
		Tweener.addTween( _mc_overline, { 	alpha:0, delay:.5, time:.5 } );
	}
}