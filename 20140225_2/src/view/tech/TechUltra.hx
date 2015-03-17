package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.media.SoundMixer;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechUltra extends DefaultTechPage
{
	var _mc_slider:DisplayObject;
	var _mc_mask:DisplayObject;
	var _mc_htc:DisplayObject;
	var mc_txt_htc:DisplayObject;
	var mc_txt_other:DisplayObject;

	
	public function new() 
	{
		super();
	}
	
	
	var isEndAnimation = false;
	
	override function forScript(e) 
	{
		super.forScript(e);
		isEndAnimation = true;
	}
	
	override public function stopAllAnimation() 
	{
		isEndAnimation = false;
		super.stopAllAnimation();
	}
	
	override public function resumeAllAnimation() 
	{
		isEndAnimation = true;
		super.resumeAllAnimation();
	}
	
	var _targetX:Float = 0;
	
	function onEnterFrame(e: Event) {
		if (_mc_controller == null)
			return;
		if ( _mc_htc == null )
			return;
		if ( isEndAnimation ) {
			var local = _mc_controller.globalToLocal( new Point(stage.mouseX, stage.mouseY) );
			var hitRect = _mc_htc.getRect( _mc_controller );
			var isHitRegion = ( local.y > hitRect.top && local.y < hitRect.bottom );
			if ( isHitRegion ) {
				_targetX = local.x;
			}
			var currX = moveMask( hitRect.left, hitRect.right, _targetX );
			var side = currX - hitRect.left < hitRect.width / 2 ? 'left' : 'right';
			changeSide( side );
			
			onMostLeftSide( currX - hitRect.left < 50 );
		}
	}
	
	var _side:String = 'left';
	
	function changeSide( side:String ) {
		if ( _side != side ) {
			_side = side;
		}
	}
	
	var _onMostLeftSide = false;
	
	function onMostLeftSide( b:Bool ) {
		if ( _onMostLeftSide != b ) {
			_onMostLeftSide = b;
			if ( _onMostLeftSide ) {
				SoundMixer.stopAll();
				getRoot().playRespond();
				requestWaitAnimation();
			}
		}
	}
	
	function showPhoneMark( type: String ) {
		switch(type) {
			case 'htc':
				Tweener.addTween( mc_txt_htc, { alpha: 1, time: .5 } );
				Tweener.addTween( mc_txt_other, { alpha: 0, time: .5 } );
			case _:
				Tweener.addTween( mc_txt_htc, { alpha: 0, time: .5 } );
				Tweener.addTween( mc_txt_other, { alpha: 1, time: .5 } );
		}
	}
	
	function moveMask(min:Float, max:Float, targetX:Float): Float {
		targetX = Math.min( targetX, max );
		targetX = Math.max( targetX, min );
		_mc_controller.mc_slider.x += ((targetX - 20) - _mc_controller.mc_slider.x) * .2;
		_mc_controller.mc_mask.x += (targetX - _mc_controller.mc_mask.x) * .2;
		return _mc_controller.mc_mask.x;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_htc':
					_mc_htc = obj;
				case 'mc_txt_htc':
					mc_txt_htc = obj;
				case 'mc_txt_other':
					mc_txt_other = obj;
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
		return {name:'TechUltra', path:'src/TechUltra.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechUltra', path:'mc_anim' };
	}
}