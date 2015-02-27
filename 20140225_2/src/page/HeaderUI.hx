package page ;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import helper.IResize;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class HeaderUI extends DefaultPage
{

	private var _btns:DisplayObject;
	private var _bar:DisplayObject;
	private var _btn_extend:DisplayObject;
	
	public function new() 
	{
		super();
		
		layerName = 'ui';
	}
	
	public function extendButtonVisible(v:Bool) {
		Tweener.addTween(_btn_extend, { alpha: v ? 1 : 0, time: 1 } );
	}
	
	public function animateShowBar(v:Bool) {
		Tweener.addTween(getRoot(), { y: v ? 0 : -getRoot().height+25, time: 1 } );
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_btns':
					_btns = obj;
				case 'mc_bar':
					_bar = obj;
				case 'btn_extend':
					_btn_extend = obj;
					_btn_extend.alpha = 0;
			}
		});
		super.onOpenEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'header', path:'src/header.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'header', path:'Header' };
	}
	
	override public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		_btns.x = w - _btns.width;
		_bar.width = w;
	}
}