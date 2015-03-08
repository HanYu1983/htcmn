package view.tech;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import helper.IResize;
import helper.Tool;
import org.vic.flash.display.FakeMovieClip;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;
import view.DefaultPage;

/**
 * ...
 * @author ...
 */
class TechDouble extends DefaultTechPage
{
	//var _mc_controller:MovieClip;
	var _mc_mask:DisplayObject;
	var _mc_dot:DisplayObject;
	var _mc_line:DisplayObject;
	var _mc_circleMask:DisplayObject;
	var _mc_circleMaskBorder:DisplayObject;
	var _mc_phoneA:MovieClip;
	var _mc_phoneB:MovieClip;
	var _mc_phoneC:MovieClip;
	var _mc_phoneABig:MovieClip;
	var _mc_phoneBBig:MovieClip;
	var _mc_phoneCBig:MovieClip;
	var _mc_currentPhone:MovieClip;
	var _mc_currentBigPhone:MovieClip;
	var _ary_dotPos:Array<Float>;
	
	public function new() 
	{
		super();
	}
	
	public function changeSide( which ) {
		
		switch( which ) {
			case 'a':
				gotoSideA( _mc_phoneA );
				gotoSideA( _mc_phoneB );
				gotoSideA( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 1 );
				_mc_phoneBBig.gotoAndStop( 1 );
				_mc_phoneCBig.gotoAndStop( 1 );
				Tweener.addTween( _mc_dot, {x:_ary_dotPos[0] - _mc_dot.width / 2, time:.5 } );
				Tweener.addTween( _mc_mask, {x:_ary_dotPos[0] - _mc_dot.width / 2 - 380, time:.5 } );
			case 'b':
				gotoSideB( _mc_phoneA );
				gotoSideB( _mc_phoneB );
				gotoSideB( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 2 );
				_mc_phoneBBig.gotoAndStop( 2 );
				_mc_phoneCBig.gotoAndStop( 2 );
				Tweener.addTween( _mc_dot, {x:_ary_dotPos[1] - _mc_dot.width / 2, time:.5 } );
				Tweener.addTween( _mc_mask, {x:_ary_dotPos[1] - _mc_dot.width / 2 - 380, time:.5 } );
			case 'c':
				gotoSideC( _mc_phoneA );
				gotoSideC( _mc_phoneB );
				gotoSideC( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 3 );
				_mc_phoneBBig.gotoAndStop( 3 );
				_mc_phoneCBig.gotoAndStop( 3 );
				Tweener.addTween( _mc_dot, {x:_ary_dotPos[2] - _mc_dot.width / 2, time:.5 } );
				Tweener.addTween( _mc_mask, {x:_ary_dotPos[2] - _mc_dot.width / 2 - 380, time:.5 } );
		}
	}
	
	public function changeColor( which ) {
		
		_mc_phoneA.alpha = 0;
		_mc_phoneB.alpha = 0;
		_mc_phoneC.alpha = 0;
		_mc_phoneABig.alpha = 0;
		_mc_phoneBBig.alpha = 0;
		_mc_phoneCBig.alpha = 0;
		
		switch( which ) {
			case 'a':
				_mc_currentPhone = _mc_phoneA;
				_mc_currentBigPhone = _mc_phoneABig;
			case 'b':
				_mc_currentPhone = _mc_phoneB;
				_mc_currentBigPhone = _mc_phoneBBig;
			case 'c':
				_mc_currentPhone = _mc_phoneC;
				_mc_currentBigPhone = _mc_phoneCBig;
		}
		
		Tweener.addTween( _mc_currentPhone, {alpha:1, time:.5 } );
		Tweener.addTween( _mc_currentBigPhone, {alpha:1, time:.5 } );
	}
	
	function gotoSideA( phone:MovieClip ) {
		switch( phone.currentLabel ){
			case 'frontToSide','backToSide':
				phone.gotoAndPlay( 'sideToBack' );
			case 'backToFront','sideToFront':
				phone.gotoAndPlay( 'frontToBack' );
		}
	}
	function gotoSideB( phone:MovieClip ) {
		switch( phone.currentLabel ){
			case null:
				phone.gotoAndPlay( 'backToSide' );
			case 'backToFront','sideToFront':
				phone.gotoAndPlay( 'frontToSide' );
				
		}
	}
	function gotoSideC( phone:MovieClip ) {
		switch( phone.currentLabel ){
			case null:
				phone.gotoAndPlay( 'backToFront' );
			case 'frontToSide','backToSide':
				phone.gotoAndPlay( 'sideToFront' );
				
		}
	}
	/*
	function forScript( e ) {
		_mc_controller.visible = true;
	}
	*/
	/*
	override public function skipAnimation() 
	{
		cast( _mc_item, MovieClip ).gotoAndPlay('forScript');
	}
	
	*/
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_mask':
					_mc_mask = obj;
				case 'mc_dot':
					_mc_dot = obj;
				case 'mc_line':
					_mc_line = obj;
				case 'mc_phoneA':
					_mc_phoneA = cast( obj, MovieClip );
				case 'mc_phoneB':
					_mc_phoneB = cast( obj, MovieClip );
				case 'mc_phoneC':
					_mc_phoneC = cast( obj, MovieClip );
				case 'mc_phoneABig':
					_mc_phoneABig = cast( obj, MovieClip );
				case 'mc_phoneBBig':
					_mc_phoneBBig = cast( obj, MovieClip );
				case 'mc_phoneCBig':
					_mc_phoneCBig = cast( obj, MovieClip );
				case 'mc_circleMask':
					_mc_circleMask = obj;
				case 'mc_circleMaskBorder':
					_mc_circleMaskBorder = obj;
			}
		});
		
		_ary_dotPos = [ _mc_line.x, _mc_line.x + _mc_line.width / 2, _mc_line.x + _mc_line.width ];
		
		_mc_currentBigPhone = _mc_phoneABig;
		_mc_currentPhone = _mc_phoneA;
		//_mc_controller.visible = false;
		//_mc_item.addEventListener( 'forScript', forScript );
		
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
	}
	
	var _targetPoint: Point = new Point();
	
	function circleMove() {
		_mc_circleMask.x += (_targetPoint.x - _mc_circleMask.x)* .2;
		_mc_circleMask.y += (_targetPoint.y - _mc_circleMask.y)* .2;
		
		_mc_circleMaskBorder.x += (_targetPoint.x - _mc_circleMaskBorder.x)* .2;
		_mc_circleMaskBorder.y += (_targetPoint.y - _mc_circleMaskBorder.y)* .2;
	}
	
	function onEnterFrame(e: Event) {
		if (_mc_circleMask == null)
			return;
		
		_targetPoint = _mc_item.globalToLocal( new Point( stage.mouseX, stage.mouseY ) );
		circleMove();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		_mc_item.removeEventListener( 'forScript', forScript );
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechDouble', path:'src/TechDouble.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDouble', path:'TechDouble' };
	}
}
