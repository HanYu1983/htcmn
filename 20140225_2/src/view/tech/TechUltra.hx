package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechUltra extends DefaultTechPage
{
	//var _mc_controller:MovieClip;
	var _mc_slider:DisplayObject;
	var _mc_mask:DisplayObject;
	var _mc_htc:DisplayObject;
	var _btn_onTechUltraBtnClick_skip:DisplayObject;
	
	
	public function new() 
	{
		super();
		this.createDebugRoot("ultra");
	}
	
	override public function skipAnimation() 
	{
		cast( _mc_item, MovieClip ).gotoAndPlay('forScript');
	}
	
	override public function hideSkipButton() {
		Tweener.addTween( _btn_onTechUltraBtnClick_skip, { alpha: 0, time: 1 } );
	}
	
	var _targetX:Float = 0;
	
	function onEnterFrame(e: Event) {
		if (_mc_controller == null)
			return;
		if ( _mc_htc == null )
			return;
		var isEndAnimation = cast( _mc_item, MovieClip ).currentFrameLabel == 'forScript';
		if ( isEndAnimation ) {
			hideSkipButton();
			var local = _mc_controller.globalToLocal( new Point(stage.mouseX, stage.mouseY) );
			var hitRect = _mc_htc.getRect( _mc_controller );
			var isHitRegion = ( local.y > hitRect.top && local.y < hitRect.bottom );
			if ( isHitRegion ) {
				_targetX = local.x;
			}
			moveMask( hitRect.left, hitRect.right, _targetX );
		}
	}
	
	function moveMask(min:Float, max:Float, targetX:Float) {
		if (targetX < min)
			targetX = min;
		if (targetX > max)
			targetX = max;
		_mc_controller.mc_slider.x += ((targetX - 20) - _mc_controller.mc_slider.x) * .2;
		_mc_controller.mc_mask.x += (targetX - _mc_controller.mc_mask.x) * .2;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_htc':
					_mc_htc = obj;
				case 'btn_onTechUltraBtnClick_skip':
					_btn_onTechUltraBtnClick_skip = obj;
			}
		});
		
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
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
		return {name:'TechUltra', path:'TechUltra' };
	}
}