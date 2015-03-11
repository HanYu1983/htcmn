package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechCamera extends DefaultTechPage
{
	
	var _mc_circleButton:MovieClip;
	var _mc_dot:MovieClip;
	var _mc_bar:MovieClip;
	var _mc_htcPhoto:DisplayObject;
	var _mc_ohterPhoto:DisplayObject;
	var _mc_htc:DisplayObject;
	var _mc_other:DisplayObject;	
	var _mc_photo:DisplayObjectContainer;
	var mc_photoScale:DisplayObject;
	var mc_photoOffset:DisplayObject;
	var mc_photoMask:DisplayObject;
	
	public function new() 
	{
		super();
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_circleButton':
					_mc_circleButton = cast( obj, MovieClip );
				case 'mc_htc':
					_mc_htc = obj;
				case 'mc_dot':
					_mc_dot = cast( obj, MovieClip );
				case 'mc_bar':
					_mc_bar = cast( obj, MovieClip );
				case 'mc_htcPhoto':
					_mc_htcPhoto = obj;
				case 'mc_otherPhoto':
					_mc_ohterPhoto = obj;
				case 'mc_other':
					_mc_other = obj;
				case 'mc_photo':
					_mc_photo = cast( obj, DisplayObjectContainer );
				case 'mc_photoScale':
					mc_photoScale = obj;
				case 'mc_photoOffset':
					mc_photoOffset = obj;
				case 'mc_photoMask':
					mc_photoMask = obj;
			}
		});
		
		_originDotX = _mc_dot.x;
		animateForSmartPhone(taggleCircleButton());
		//scalePhoto( 0 );
		
		_mc_bar.buttonMode = true;
		_mc_bar.addEventListener( MouseEvent.CLICK, onMouseClickSlideBar );
		
		_mc_dot.buttonMode = true;
		_mc_dot.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownDot );
		
		mc_photoOffset.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownMask );
		getRoot().addEventListener( MouseEvent.MOUSE_UP, onMouseUpMask );
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame );
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		mc_photoOffset.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDownMask );
		getRoot().removeEventListener( MouseEvent.MOUSE_UP, onMouseUpMask );
		_mc_bar.removeEventListener( MouseEvent.CLICK, onMouseClickSlideBar );
		super.onCloseEvent(cb);
	}
	
	function onEnterFrame( e:Event ) {
		if ( isDragOffset ) {
			movePhotoOffset();
		}
		if ( isDragDot ) {
			moveDot();
		}
	}
	
	function moveDot() {
		var currPoint = new Point( stage.mouseX, stage.mouseY );
		var local = _mc_item.globalToLocal( currPoint );
		var per = (local.x - _mc_bar.x) / _mc_bar.width;
		var currScale = per + 1;
		var offsetScale = currScale - _scale;
		scalePhoto( offsetScale );
	}
	
	var isDragDot = false;
	
	function onMouseDownDot( e:MouseEvent ) {
		isDragDot = true;
	}
	
	var isDragOffset = false;
	var dragOrigin:Point = null;
	var dragOffset:Point = new Point();
	
	function onMouseDownMask( e:MouseEvent ) {
		isDragOffset = true;
		dragOrigin = new Point( stage.mouseX, stage.mouseY );
	}
	
	function onMouseUpMask( e:MouseEvent ) {
		isDragOffset = isDragDot = false;
		dragOffset = new Point( mc_photoOffset.x, mc_photoOffset.y );
	}
	
	function movePhotoOffset() {
		var currPoint = new Point( stage.mouseX, stage.mouseY );
		var offset = currPoint.subtract( dragOrigin );
		
		mc_photoOffset.x = offset.x/ _scale + dragOffset.x;
		mc_photoOffset.y = offset.y/ _scale + dragOffset.y;
	
		boundingPhotoOffset();
	}
	
	function boundingPhotoOffset() {
		
		// 有*2和/2的係數是因為在flash的階層中, mc_photoOffset的子層被放大的二倍, 而那層沒被計算到, 所以要乘回來
		
		// 錨點在圖片中間, 算出左上角的點的世界坐標
		var origin1 = new Point( -mc_photoOffset.width/2 *2, -mc_photoOffset.height); // 乘2的係數, 之後省略不寫
		var global1 = mc_photoOffset.localToGlobal( origin1 );
		
		// 錨點在圖片左上角, 算出左上角的點的世界坐標
		var globalMask1 = mc_photoMask.localToGlobal( new Point() );

		if ( global1.x > globalMask1.x ) {
			var local = mc_photoOffset.globalToLocal( new Point(globalMask1.x, 0) );
			var offset = local.subtract( origin1 );
			mc_photoOffset.x += offset.x / 2;	// 除2的係數
		}
		
		if ( global1.y > globalMask1.y ) {
			var local = mc_photoOffset.globalToLocal( new Point(0,globalMask1.y ) );
			var offset = local.subtract( origin1 );
			mc_photoOffset.y += offset.y / 2;	// 除2的係數
		}
		
		// 錨點在圖片中間, 算出右下角的點的世界坐標
		var origin2 = new Point(mc_photoOffset.width, mc_photoOffset.height);
		var global2 = mc_photoOffset.localToGlobal( origin2 );
		
		// 錨點在圖片左上角, 算出有下角的點的世界坐標
		var globalMask2 = mc_photoMask.localToGlobal( new Point(mc_photoMask.width, mc_photoMask.height) );
		
		if ( global2.x < globalMask2.x ) {
			var local = mc_photoOffset.globalToLocal( new Point(globalMask2.x, 0) );
			var offset = local.subtract( origin2 );
			mc_photoOffset.x += offset.x / 2;	// 除2的係數
		}
		if ( global2.y < globalMask2.y ) {
			var local = mc_photoOffset.globalToLocal( new Point(0, globalMask2.y) );
			var offset = local.subtract( origin2 );
			mc_photoOffset.y += offset.y / 2;	// 除2的係數
		}
		
	}
	
	function onMouseClickSlideBar( e:MouseEvent ) {
		var local = _mc_bar.globalToLocal( new Point(stage.mouseX, stage.mouseY) );
		var per = local.x / _mc_bar.width;
		var currScale = per + 1;
		var offsetScale = currScale - _scale;
		scalePhoto( offsetScale );
	}
	
	var _originDotX:Float;
	
	public function setDotPosition( v:Float ) {
		var tx = (v-1) * _mc_bar.width +_originDotX;
		Tweener.addTween( _mc_dot, { x: tx, time:.3 } );
	}
	
	
	var _scale = 1.0;
	
	public function scalePhoto( v: Float ) {
		_scale += v;
		_scale = Math.min( _scale, 2 );
		_scale = Math.max( 1, _scale );
		Tweener.addTween( mc_photoScale, { scaleX: _scale, scaleY: _scale, time:.3, onUpdate: boundingPhotoOffset } );
		setDotPosition( _scale );
	}
	
	function setHTCPhoneVisible( v:Bool ) {
		Tweener.addTween( _mc_htc, { alpha:v ? 1: 0, time:.3 } );
		Tweener.addTween( _mc_htcPhoto, { alpha: v? 1 : 0, time:.3 } );
	}
	
	function setOtherPhoneVisible( v:Bool ) {
		Tweener.addTween( _mc_other, { alpha:v ? 1: 0, time:.3 } );
		Tweener.addTween( _mc_ohterPhoto, { alpha: v? 1 : 0, time:.3 } );
	}
	
	public function animateForSmartPhone( phone:String ) {
		switch( phone ) {
			case 'htc':
				setHTCPhoneVisible( true );
				setOtherPhoneVisible( false );
			case 'other':
				setHTCPhoneVisible( false );
				setOtherPhoneVisible( true );
		}
	}
	
	public function taggleCircleButton(): String {
		var curr = _mc_circleButton.currentLabel;
		getWebManager().log(curr);
		var target = switch( curr ) {
			case 'htc': 'other';
			case 'other': 'htc';
			case _ : 'htc';
		}
		_mc_circleButton.gotoAndPlay( target );
		return target;
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechCamera', path:'src/TechCamera.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechCamera', path:'TechCamera' };
	}
}