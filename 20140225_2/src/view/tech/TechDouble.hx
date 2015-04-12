package view.tech;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.sampler.NewObjectSample;
import haxe.Timer;
import helper.Cookie;
import helper.IResize;
import helper.IYoutubePageBelong;
import helper.Tool;
import org.vic.flash.display.FakeMovieClip;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebView;
import view.DefaultPage;
import view.TechPage;
import view.YoutubePage;

/**
 * ...
 * @author ...
 */
class TechDouble extends DefaultTechPage implements IYoutubePageBelong
{
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
	var mc_descA:DisplayObject;
	var mc_descB:DisplayObject;
	var mc_descC:DisplayObject;
	var _mc_currentPhone:MovieClip;
	var _mc_currentBigPhone:MovieClip;
	var _ary_dotPos:Array<Float>;
	var _btn_onTechDoubleBtnClick_skip:DisplayObject;
	
	var mc_phoneController:DisplayObject;
	var mc_phoneBorder:DisplayObject;
	
	var btn_onTechDoubleClick_colorA:MovieClip;
	var btn_onTechDoubleClick_colorB:MovieClip;
	var btn_onTechDoubleClick_colorC:MovieClip;
	
	public function new() 
	{
		super();
	}
	
	public function changeSide( which ) {
		closeHint();
		switch( which ) {
			case 'a':
				gotoSideA( _mc_phoneA );
				gotoSideA( _mc_phoneB );
				gotoSideA( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 1 );
				_mc_phoneBBig.gotoAndStop( 1 );
				_mc_phoneCBig.gotoAndStop( 1 );
				Tweener.addTween( mc_descA, { alpha:1, time:.5 } );
				Tweener.addTween( mc_descB, { alpha:0, time:.5 } );
				Tweener.addTween( mc_descC, { alpha:0, time:.5 } );
				Tweener.addTween( _mc_dot, {x:_ary_dotPos[0] - _mc_dot.width / 2, time:.5 } );
				Tweener.addTween( _mc_mask, {x:_ary_dotPos[0] - _mc_dot.width / 2 - 380, time:.5 } );
			case 'b':
				gotoSideB( _mc_phoneA );
				gotoSideB( _mc_phoneB );
				gotoSideB( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 2 );
				_mc_phoneBBig.gotoAndStop( 2 );
				_mc_phoneCBig.gotoAndStop( 2 );
				Tweener.addTween( mc_descA, { alpha:0, time:.5 } );
				Tweener.addTween( mc_descB, { alpha:1, time:.5 } );
				Tweener.addTween( mc_descC, { alpha:0, time:.5 } );
				Tweener.addTween( _mc_dot, {x:_ary_dotPos[1] - _mc_dot.width / 2, time:.5 } );
				Tweener.addTween( _mc_mask, {x:_ary_dotPos[1] - _mc_dot.width / 2 - 380, time:.5 } );
			case 'c':
				gotoSideC( _mc_phoneA );
				gotoSideC( _mc_phoneB );
				gotoSideC( _mc_phoneC );
				_mc_phoneABig.gotoAndStop( 3 );
				_mc_phoneBBig.gotoAndStop( 3 );
				_mc_phoneCBig.gotoAndStop( 3 );
				Tweener.addTween( mc_descA, { alpha:0, time:.5 } );
				Tweener.addTween( mc_descB, { alpha:0, time:.5 } );
				Tweener.addTween( mc_descC, { alpha:1, time:.5 } );
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
				sleepButton( getButtonsByName( 'btn_onTechDoubleClick_colorA' ));
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorB' ), true);
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorC' ), true);
				_mc_currentPhone = _mc_phoneA;
				_mc_currentBigPhone = _mc_phoneABig;
				getRoot().playRespond();
				requestWaitAnimation();
				
			case 'b':
				sleepButton( getButtonsByName( 'btn_onTechDoubleClick_colorB' ));
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorA' ), true);
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorC' ), true);
				_mc_currentPhone = _mc_phoneB;
				_mc_currentBigPhone = _mc_phoneBBig;
			case 'c':
				sleepButton( getButtonsByName( 'btn_onTechDoubleClick_colorC' ));
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorA' ), true);
				wakeUpButton( getButtonsByName( 'btn_onTechDoubleClick_colorB' ), true);
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
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
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
				case 'btn_onTechDoubleClick_skip':
					_btn_onTechDoubleBtnClick_skip = obj;
				case 'mc_phoneController':
					mc_phoneController = obj;
				case 'mc_phoneBorder':
					mc_phoneBorder = obj;
				case 'btn_onTechDoubleClick_colorA':
					btn_onTechDoubleClick_colorA = cast( obj, MovieClip );
				case 'btn_onTechDoubleClick_colorB':
					btn_onTechDoubleClick_colorB = cast( obj, MovieClip );
				case 'btn_onTechDoubleClick_colorC':
					btn_onTechDoubleClick_colorC = cast( obj, MovieClip );
				case 'mc_desc1':
					mc_descA = obj;
				case 'mc_desc2':
					mc_descB = obj;
				case 'mc_desc3':
					mc_descC = obj;
			}
		});
		_ary_dotPos = [ _mc_line.x, _mc_line.x + _mc_line.width / 2, _mc_line.x + _mc_line.width ];
		
		_mc_currentBigPhone = _mc_phoneABig;
		_mc_currentPhone = _mc_phoneA;
		_mc_phoneA.alpha = 0;
		_mc_phoneB.alpha = 0;
		_mc_phoneC.alpha = 0;
		_mc_phoneABig.alpha = 0;
		_mc_phoneBBig.alpha = 0;
		_mc_phoneCBig.alpha = 0;
		mc_descA.alpha = 0;
		mc_descB.alpha = 0;
		mc_descC.alpha = 0;
		changeColor( 'b' );
		changeSide( 'a' );
		
		setCircleVisible( false );
		setCircleMaskVisible( false );
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame);
		
		super.onOpenEvent(param, cb);
		
		if ( shouldOpenYoutubeAndWrite() ) {
			getWebManager().openPage( YoutubePage, null );
		} else {
			Timer.delay( function() {
				getRoot().playEnter();
			}, 1500);
		}
	}
	
	public function onYoutubePageClose(page: IWebView) {
		getRoot().playEnter();
	}
	
	function shouldOpenYoutubeAndWrite():Bool {
		var cookie = Cookie.load( { isDoubleYoutubeOpened: false } );
		var shouldOpen = cookie.data.isDoubleYoutubeOpened == false;
		cookie.data.isDoubleYoutubeOpened = true;
		cookie.save();
		return shouldOpen;
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		setCircleMaskVisible( true );
	}
	
	function setCircleMaskVisible( v:Bool ) {
		Tweener.addTween( _mc_circleMask, { alpha: v? 1: 0, time: 1 } );
		Tweener.addTween( _mc_circleMaskBorder, { alpha: v? 1: 0, time: 1 } );
	}
	
	var _targetPoint: Point = new Point();
	
	function circleMove() {
		mc_phoneController.x += (_targetPoint.x - mc_phoneController.x) * .5;
		mc_phoneController.y += (_targetPoint.y - mc_phoneController.y)* .5;
	}
	
	var _originSize: Point = null;
	
	function syncBackPhonePosition() {
		if ( _originSize == null ) {
			_originSize = new Point( _mc_phoneABig.width, _mc_phoneABig.height );
		}
		
		var offsetX = mc_phoneController.x - mc_phoneBorder.x;
		var offsetY = mc_phoneController.y - mc_phoneBorder.y;
		
		var scaleX = _originSize.x / mc_phoneBorder.width;
		var scaleY = _originSize.y / mc_phoneBorder.height;
		
		_mc_phoneABig.x = _mc_phoneBBig.x = _mc_phoneCBig.x = -offsetX* scaleX;
		_mc_phoneABig.y = _mc_phoneBBig.y = _mc_phoneCBig.y = -offsetY* scaleY;
	}
	
	function onEnterFrame(e: Event) {
		if ( !isScriptEanbled() ) {
			return;
		}
		if (_mc_circleMask == null)
			return;
		var isEnterRegion = mc_phoneBorder.hitTestPoint( stage.mouseX, stage.mouseY );
		if ( isEnterRegion ) {
			_targetPoint = _mc_item.globalToLocal( new Point( stage.mouseX, stage.mouseY ) );	
		}
		setCircleVisible( isEnterRegion );
		circleMove();
		syncBackPhonePosition();
	}
	
	
	var _circleVisible = true;
	
	function setCircleVisible( b:Bool ) {
		if ( _circleVisible != b ) {
			_circleVisible = b;
			Tweener.addTween( mc_phoneController, { alpha: b? 1: 0, time: 0.5 } );
		}
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		_mc_item.removeEventListener( 'forScript', forScript );
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechDouble', path:config.swfPath.TechDouble[ config.swfPath.TechDouble.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechDouble', path:'mc_anim' };
	}
}
