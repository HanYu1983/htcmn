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
	var mc_htcTxt:DisplayObject;
	var mc_otherTxt:DisplayObject;
	
	public function new() 
	{
		super();
	}
	
	
	var isEndAnimation = false;
	
	override function forScript(e) 
	{
		BasicUtils.revealObj( _mc_item, function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_htcTxt':
					mc_htcTxt = obj;
				case 'mc_otherTxt':
					mc_otherTxt = obj;
			}
		});
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
	
	var _targetX:Float = 1366;
	
	function onEnterFrame(e: Event) {
		if ( !isScriptEanbled() ) {
			return;
		}
		if (_mc_controller == null)
			return;
		if ( _mc_htc == null )
			return;
		if ( isEndAnimation ) {
			var local = _mc_controller.globalToLocal( new Point(stage.mouseX, stage.mouseY) );
			var hitRect = _mc_htc.getRect( _mc_controller );
			var isHitRegion = ( local.y > hitRect.top && local.y < hitRect.bottom ) && local.x > hitRect.left;
			if ( isHitRegion ) {
				_targetX = local.x;
			}
			var currX = moveMask( hitRect.left, hitRect.right, _targetX );
			var side = currX - hitRect.left < hitRect.width / 2 ? 'left' : 'right';
			changeSide( side );
			chagenDesc();
			onMostLeftSide( currX - hitRect.left < 50 );
		}
	}
	
	var _side:String = 'left';
	
	function changeSide( side:String ) {
		if ( _side != side ) {
			_side = side;
		}
	}
	
	function chagenDesc() {
		if ( _side == 'left' ) {
			Tweener.addTween( mc_htcTxt, { alpha:1, time:1  } );
			Tweener.addTween( mc_otherTxt, { alpha:0, time:1  } );
			Tweener.addTween( mc_txt_htc, { alpha: 1, time: .5 } );
			Tweener.addTween( mc_txt_other, { alpha: 0, time: .5 } );
		}else {
			Tweener.addTween( mc_htcTxt, { alpha:0, time:1  } );
			Tweener.addTween( mc_otherTxt, { alpha:1, time:1  } );
			Tweener.addTween( mc_txt_htc, { alpha: 0, time: .5 } );
			Tweener.addTween( mc_txt_other, { alpha: 1, time: .5 } );
		}
	}
	
	var _onMostLeftSide = false;
	
	function onMostLeftSide( b:Bool ) {
		// 只能觸發一次
		if ( _onMostLeftSide == true)
			return;
		if ( _onMostLeftSide != b ) {
			_onMostLeftSide = b;
			if ( _onMostLeftSide ) {
				// 改為只會回應一次
				//SoundMixer.stopAll();
				//getRoot().playRespond();
				//requestWaitAnimation();
				if ( playRespondOnce() ) {
					SoundMixer.stopAll();
					requestWaitAnimation();
				}
				closeHint();
			}
		}
	}
	/*
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
	*/
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
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechUltra', path:config.swfPath.TechUltra[ config.swfPath.TechUltra.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechUltra', path:'mc_anim' };
	}
}